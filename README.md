<div align="center">

# asdf-sqlc [![Build](https://github.com/dylanrayboss/asdf-sqlc/actions/workflows/build.yml/badge.svg)](https://github.com/dylanrayboss/asdf-sqlc/actions/workflows/build.yml) [![Lint](https://github.com/dylanrayboss/asdf-sqlc/actions/workflows/lint.yml/badge.svg)](https://github.com/dylanrayboss/asdf-sqlc/actions/workflows/lint.yml)

[sqlc](https://docs.sqlc.dev/en/latest/index.html) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

This plugin depends on common POSIX utilities (awk, grep, sed, etc.), Bash, Git, and Go. If you have a Go toolchain installed and selected via asdf (asdf current golang), it will be used to retrieve and build protoc-gen-connect-go. Otherwise, asdf will be used to retrieve the latest Go version and that will be used for the build.

# Install

Plugin:

```shell
asdf plugin add sqlc
# or
asdf plugin add sqlc https://github.com/dylanrayboss/asdf-sqlc.git
```

sqlc:

```shell
# Show all installable versions
asdf list-all sqlc

# Install specific version
asdf install sqlc latest

# Set a version globally (on your ~/.tool-versions file)
asdf global sqlc latest

# Now sqlc commands are available
sqlc --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/dylanrayboss/asdf-sqlc/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [dylan](https://github.com/dylanrayboss/)
