# lazyvim_config

Scripts for installing LazyVim and generating Lua files. Users can select the programming languages ​​for which Lua files will be generated. This allows you to install and configure only plugins for the languages ​​you need. Supported languages: Rust, Go.

<details>
<summary>Table of Contents</summary>

- [Install LazyVim and generate lua files](#install-lazyvim-and-generate-lua-files)
- [Delete configuration](#delete-configuration)
- [Install dependencies for selected languages](#install-dependencies-for-selected-languages)
  - [Rust dependencies](#rust-dependencies)
  - [Go dependencies](#go-dependencies)
- [Keymaps](#keymaps)
  - [General](#general)
  - [neotest](#neotest)
  - [nvim-dap](#nvim-dap)
  - [nvim-dap-ui](#nvim-dap-ui)
  - [windsurf.nvim](#windsurfnvim)
  - [copilot.vim, CopilotChat.nvim](#copilotvim-copilotchatnvim)
- [AI](#ai)
  - [Windsurf](#windsurf)
  - [Copilot](#copilot)

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

### Go dependencies

You need to install: gopls, golangci-lint, golangci-lint-langserver, goimports, golines, delve.

```bash
# install from source (alternative - install binary)
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/segmentio/golines@latest
go install github.com/go-delve/delve/cmd/dlv@latest
```

## Keymaps

[LazyVim Keymaps](https://www.lazyvim.org/keymaps)

### General

| № | Action  | Default Key  |  Custom Key  | Description         |    Mode     |
|:-:|---------|:------------:|:------------:|---------------------|:-----------:|
| 1 | Replace |   `<A-j>`    |  `<A-Down>`  | Move Down           | **n, i, v** |
| 2 | Replace |   `<A-k>`    |   `<A-Up>`   | Move Up             | **n, i, v** |
| 3 | Add     |              |   `<C-/>`    | Toggle comment line |  **n, v**   |
| 4 | Replace |   `<c-/>`    |   `<C-`>`    | Terminal (Root Dir) |    **n**    |
| 5 | Replace |   `<C-/>`    |   `<C-`>`    | Hide Terminal       |    **t**    |
| 6 | Replace | `<leader>-`  | `<leader>\|` | Split Window Below  |    **n**    |
| 7 | Replace | `<leader>\|` | `<leader>\`  | Split Window Right  |    **n**    |

### neotest

|     Key      | Description                   | Mode  |
|:------------:|-------------------------------|:-----:|
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

### nvim-dap

|     Key      | Description             | Mode  |
|:------------:|-------------------------|:-----:|
| `<leader>da` | Run with Args           | **n** |
| `<leader>db` | Toggle Breakpoint       | **n** |
| `<leader>dB` | Breakpoint Condition    | **n** |
| `<leader>dc` | Run/Continue            | **n** |
| `<leader>dC` | Run to Cursor           | **n** |
| `<leader>dg` | Go to Line (No Execute) | **n** |
| `<leader>di` | Step Into               | **n** |
| `<leader>dj` | Down                    | **n** |
| `<leader>dk` | Up                      | **n** |
| `<leader>dl` | Run Last                | **n** |
| `<leader>do` | Step Out                | **n** |
| `<leader>dO` | Step Over               | **n** |
| `<leader>dP` | Pause                   | **n** |
| `<leader>dr` | Toggle REPL             | **n** |
| `<leader>ds` | Session                 | **n** |
| `<leader>dt` | Terminate               | **n** |
| `<leader>dw` | Widgets                 | **n** |

### nvim-dap-ui

|     Key      | Description |     Mode     |
|:------------:|-------------|:------------:|
| `<leader>de` | Eval        | **n**, **v** |
| `<leader>du` | Dap UI      |    **n**     |

### windsurf.nvim

|     Key      | Description                  | Mode  |
|:------------:|------------------------------|:-----:|
|   `<A-[>`    | Codeium previous suggestion  | **i** |
|   `<A-]>`    | Codeium next suggestion      | **i** |
|   `<Tab>`    | Codeium accept suggestion    | **i** |
| `<leader>a`  | +ai                          | **n** |
| `<leader>aa` | Open Codeium Chat in Browser | **n** |

### copilot.vim, CopilotChat.nvim

|     Key      | Description                  |     Mode     |
|:------------:|------------------------------|:------------:|
|   `<A-[>`    | Copilot previous suggestion  |    **i**     |
|   `<A-]>`    | Copilot next suggestion      |    **i**     |
|   `<Tab>`    | Copilot accept suggestion    |    **i**     |
| `<leader>a`  | +ai                          | **n**, **v** |
| `<leader>aa` | Toggle (CopilotChat)         | **n**, **v** |
| `<leader>ap` | Prompt Actions (CopilotChat) | **n**, **v** |
| `<leader>am` | Select Model (CopilotChat)   | **n**, **v** |
| `<leader>aq` | Quick Chat (CopilotChat)     | **n**, **v** |
| `<leader>ax` | Clear (CopilotChat)          | **n**, **v** |

## AI

Script for generating Lua files will prompt you to select an AI plugin. You can choose Codeium (Windsurf plugin) or GitHub Copilot.

### Windsurf

Setup:

1. Open nvim
2. Run the command `:Codeium Auth`
3. Select the `Open Default Browser` option
4. Copy the generated token
5. Switch to nvim
6. Paste the copied token

### Copilot

Setup:

1. Open nvim
2. Run the command `:Copilot setup`
3. Authorize with GitHub
4. Switch to nvim
