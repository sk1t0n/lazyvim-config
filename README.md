# lazyvim_config

Scripts for installing LazyVim and generating lua files.

<details>
<summary>Table of Contents</summary>

- [Install LazyVim and generate lua files](#install-lazyvim-and-generate-lua-files)
- [Delete configuration](#delete-configuration)
- [Install dependencies for selected languages](#install-dependencies-for-selected-languages)
  - [Rust dependencies](#rust-dependencies)
- [Keymaps](#keymaps)
  - [General](#general)
  - [Neotest](#neotest)

</details>

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

## Keymaps

[LazyVim Keymaps](https://www.lazyvim.org/keymaps)

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

### Neotest

| Key          | Description                   | Mode  |
|--------------|-------------------------------|-------|
| `<leader>t`  | +test                         | **n** |
| `<leader>tl` | Run Last (Neotest)            | **n** |
| `<leader>to` | Show Output (Neotest)         | **n** |
| `<leader>tO` | Toggle Output Panel (Neotest) | **n** |
| `<leader>tr` | Run Nearest (Neotest)         | **n** |
| `<leader>ts` | Toggle Summary (Neotest)      | **n** |
| `<leader>tS` | Stop (Neotest)                | **n** |
| `<leader>tt` | Run File (Neotest)            | **n** |
| `<leader>tT` | Run All Test Files (Neotest)  | **n** |
| `<leader>tw` | Toggle Watch (Neotest)        | **n** |
