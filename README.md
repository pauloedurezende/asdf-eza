<div align="center">

# asdf-eza [![Build](https://github.com/pauloedurezende/asdf-eza/actions/workflows/build.yml/badge.svg)](https://github.com/pauloedurezende/asdf-eza/actions/workflows/build.yml) [![Lint](https://github.com/pauloedurezende/asdf-eza/actions/workflows/lint.yml/badge.svg)](https://github.com/pauloedurezende/asdf-eza/actions/workflows/lint.yml)

[eza](https://github.com/eza-community/eza) plugin for the [asdf version manager](https://asdf-vm.com).

eza is a modern, maintained replacement for `ls` with better defaults and additional features like Git integration, colors, and icons.

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Build Information](#build-information)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- **Rust** - `rustc` and `cargo` are required to build eza from source. Install from [rustup.rs](https://rustup.rs/).
- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
asdf plugin add eza
# or
asdf plugin add eza https://github.com/pauloedurezende/asdf-eza.git
```

eza:

```shell
# Show all installable versions
asdf list-all eza

# Install specific version
asdf install eza latest

# Set a version globally (on your ~/.tool-versions file)
asdf global eza latest

# Now eza commands are available
eza --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Build Information

This plugin builds eza from source code for each installation, ensuring compatibility across different platforms and architectures. 

**Build process:**
- Downloads the source code for the specified version
- Compiles using `cargo` (Rust's package manager)
- Installation typically takes 2-5 minutes depending on your system

**Note:** Make sure you have a working Rust toolchain installed before attempting to install eza.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/pauloedurezende/asdf-eza/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Paulo Eduardo Rezende](https://github.com/pauloedurezende/)
