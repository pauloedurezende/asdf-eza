# Contributing

## Prerequisites

Before contributing, ensure you have the following tools installed:

- **Rust** - `rustc` and `cargo` are required to build eza. Install from [rustup.rs](https://rustup.rs/)
- **asdf** - Follow installation instructions at [asdf-vm.com](https://asdf-vm.com/)
- **Basic tools** - `bash`, `curl`, `tar`, `git`

## Testing Locally

```shell
asdf plugin test eza <path-to-plugin> --asdf-tool-version 0.18.17 "eza --version"
```

**Note:** The test will compile eza from source code, which may take several minutes depending on your system.

Tests are automatically run in GitHub Actions on push and PR.
