<div align="center">

# asdf-eza [![Build](https://github.com/pauloedurezende/asdf-eza/actions/workflows/build.yml/badge.svg)](https://github.com/pauloedurezende/asdf-eza/actions/workflows/build.yml) [![Lint](https://github.com/pauloedurezende/asdf-eza/actions/workflows/lint.yml/badge.svg)](https://github.com/pauloedurezende/asdf-eza/actions/workflows/lint.yml)

[eza](https://github.com/eza-community/eza) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

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

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/pauloedurezende/asdf-eza/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Paulo Eduardo Rezende](https://github.com/pauloedurezende/)
