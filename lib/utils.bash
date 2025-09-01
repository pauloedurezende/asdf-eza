#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for eza.
GH_REPO="https://github.com/eza-community/eza"
TOOL_NAME="eza"
TOOL_TEST="eza --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*" >&2
	exit 1
}

log_info() {
	echo "* $*"
}

log_error() {
	echo "ERROR: $*" >&2
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if eza is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	# TODO: Adapt this. By default we simply list the tag names from GitHub releases.
	# Change this function if eza has other means of determining installable versions.
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	# TODO: Adapt the release URL convention for eza
	url="$GH_REPO/archive/v${version}.tar.gz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

check_build_dependencies() {
	local missing_deps=()
	
	if ! command -v cargo >/dev/null 2>&1; then
		missing_deps+=("cargo (Rust package manager)")
	fi

	if ! command -v rustc >/dev/null 2>&1; then
		missing_deps+=("rustc (Rust compiler)")
	fi

	if [ ${#missing_deps[@]} -gt 0 ]; then
		fail "Missing required Rust toolchain components: ${missing_deps[*]}. Install Rust from https://rustup.rs/ and ensure it's in your PATH."
	fi
}

build_from_source() {
	local version="$1"
	local install_path="$2"

	echo "* Building $TOOL_NAME $version from source..."
	
	# Validate source code directory exists and is accessible
	if [ ! -d "$ASDF_DOWNLOAD_PATH" ]; then
		fail "Source code directory not found: $ASDF_DOWNLOAD_PATH. Download may have failed."
	fi
	
	# Navigate to the downloaded source code
	cd "$ASDF_DOWNLOAD_PATH" || fail "Could not access source code directory: $ASDF_DOWNLOAD_PATH. Check permissions."
	
	# Validate this is a valid Rust project
	if [ ! -f "Cargo.toml" ]; then
		fail "Invalid source code: Cargo.toml not found in $ASDF_DOWNLOAD_PATH. Source extraction may have failed."
	fi
	
	# Build and install the binary using cargo
	echo "* Compiling $TOOL_NAME with cargo (this may take a few minutes)..."
	if ! cargo install --path . --root "$install_path" --locked; then
		fail "Cargo build failed for $TOOL_NAME $version. Check that your Rust toolchain is up to date and try again."
	fi
}

verify_installation() {
	local install_path="$1"
	local tool_cmd
	tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
	local binary_path="$install_path/bin/$tool_cmd"
	
	# Check if the binary was created
	if [ ! -f "$binary_path" ]; then
		fail "Binary not found at expected location: $binary_path. Cargo installation may have failed silently."
	fi
	
	# Check if the binary is executable
	if [ ! -x "$binary_path" ]; then
		fail "Binary exists but is not executable: $binary_path. Check file permissions."
	fi
	
	# Test that the binary actually works
	echo "* Verifying $TOOL_NAME installation..."
	if ! "$binary_path" --version >/dev/null 2>&1; then
		fail "Binary is present but fails to execute: $binary_path. The build may be corrupted or missing dependencies."
	fi
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="$3"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	# Check for required build dependencies
	check_build_dependencies

	(
		# Build the tool from source code
		build_from_source "$version" "$install_path"

		# Verify the installation was successful
		verify_installation "$install_path"

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
