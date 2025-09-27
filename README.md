# lazyvim_config

## Install LazyVim and generate lua files

**Linux**:

```sh
make install
# or
make
```

## Delete configuration along with backups

**Linux**:

```sh
make remove_with_backups
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
