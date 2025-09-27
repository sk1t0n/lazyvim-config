# lazyvim_config

## Install LazyVim and generate lua files

**Linux**:

```sh
make install
# or
make
```

## Delete configuration

**Linux**:

```sh
make delete
# or delete configuration along with backups
make delete DELETE_WITH_BACKUPS=true
```

## Install dependencies for selected languages

### Rust dependencies

You need to install: rust-analyzer, rustfmt, cargo-nextest.

**Linux**:

```sh
rustup component add rust-analyzer
rustup component add rustfmt
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall cargo-nextest --secure
```
