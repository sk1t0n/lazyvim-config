# lazyvim_config

Scripts for installing LazyVim and generating lua files.

## Install LazyVim and generate lua files

**Linux**:

```bash
make install
# or
make
```

## Delete configuration

**Linux**:

```bash
make delete
# or delete configuration along with backups
make delete DELETE_WITH_BACKUPS=true
```

## Install dependencies for selected languages

### Rust dependencies

You need to install: rust-analyzer, rustfmt, cargo-nextest.

**Linux**:

```bash
rustup component add rust-analyzer
rustup component add rustfmt
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall cargo-nextest --secure
```

## Replaced [keymaps](https://www.lazyvim.org/keymaps)

### General

| № | Action  | Default Key  | Custom Key   | Description         | Mode        |
|---|---------|--------------|--------------|---------------------|-------------|
| 1 | Replace | `<A-j>`      | `<A-Down>`   | Move Down           | **n, i, v** |
| 2 | Replace | `<A-k>`      | `<A-Up>`     | Move Up             | **n, i, v** |
| 3 | Add     |              | `<C-/>`      | Toggle comment line | **n, v**    |
| 4 | Replace | `<c-/>`      | `<C-`>`      | Terminal (Root Dir) | **n**       |
| 5 | Replace | `<C-/>`      | `<C-`>`      | Hide Terminal       | **t**       |
| 6 | Replace | `<leader>-`  | `<leader>\|` | Split Window Below  | **n**       |
| 7 | Replace | `<leader>\|` | `<leader>\`  | Split Window Right  | **n**       |
