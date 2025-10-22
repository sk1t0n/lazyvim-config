# lazyvim_config

Scripts for installing LazyVim and generating Lua files. Users can select the programming languages ​​for which Lua files will be generated. This allows you to install and configure only plugins for the languages ​​you need. Supported programming, markup, and stylesheet languages: HTML, CSS, JSON, YAML, Markdown, JavaScript/TypeScript with React, Rust, Go.

**Plugins that can install and setup**:

1. General: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [conform.nvim](https://github.com/stevearc/conform.nvim), [neotest](https://github.com/nvim-neotest/neotest), [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter), [nvim-lint](https://github.com/mfussenegger/nvim-lint), [nvim-dap](https://github.com/mfussenegger/nvim-dap), [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui), [actions-preview.nvim](https://github.com/aznhe21/actions-preview.nvim), [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim), [treesj](https://github.com/Wansmer/treesj), [garbage-day.nvim](https://github.com/Zeioth/garbage-day.nvim), [smartcolumn.nvim](https://github.com/m4xshen/smartcolumn.nvim), [focus.nvim](https://github.com/nvim-focus/focus.nvim), [better-escape.nvim](https://github.com/max397574/better-escape.nvim), [zen-mode.nvim](https://github.com/folke/zen-mode.nvim), [timerly](https://github.com/nvzone/timerly)
2. AI: [windsurf.nvim](https://github.com/Exafunction/windsurf.nvim) or [copilot.vim](https://github.com/github/copilot.vim) + [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)
3. Others: [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)
4. Frontend: [neotest-jest](https://github.com/nvim-neotest/neotest-jest), [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors)
5. Rust: [rustaceanvim](https://github.com/mrcjkb/rustaceanvim), [crates.nvim](https://github.com/saecki/crates.nvim)
6. Go: [neotest-golang](https://github.com/fredrikaverpil/neotest-golang), [nvim-dap-go](https://github.com/leoluz/nvim-dap-go)

<details>
<summary>Table of Contents</summary>

- [Requirements](#requirements)
- [Install LazyVim and generate lua files](#install-lazyvim-and-generate-lua-files)
- [Delete configuration](#delete-configuration)
- [Regenerate lua files if needed](#regenerate-lua-files-if-needed)
- [Install dependencies for plugins](#install-dependencies-for-plugins)
- [Install dependencies for selected languages](#install-dependencies-for-selected-languages)
  - [Frontend dependencies](#frontend-dependencies)
    - [HTML](#html)
    - [JavaScript, TypeScript](#javascript-typescript)
  - [Others dependencies](#others-dependencies)
    - [YAML](#yaml)
    - [Markdown](#markdown)
  - [Rust dependencies](#rust-dependencies)
  - [Go dependencies](#go-dependencies)
- [Keymaps](#keymaps)
  - [General](#general)
  - [LSP](#lsp)
  - [refactoring.nvim](#refactoringnvim)
  - [treesj](#treesj)
  - [bufferline.nvim](#bufferlinenvim)
  - [neotest](#neotest)
  - [nvim-dap](#nvim-dap)
  - [nvim-dap-ui](#nvim-dap-ui)
  - [timerly](#timerly)
  - [windsurf.nvim](#windsurfnvim)
  - [copilot.vim, CopilotChat.nvim](#copilotvim-copilotchatnvim)
- [AI](#ai)
  - [Windsurf](#windsurf)
  - [Copilot](#copilot)

</details>

## Requirements

- [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- [Git](https://git-scm.com/downloads)
- [Nerd Font](https://www.nerdfonts.com/font-downloads) - for to support icons in fonts (example configuration file for [WezTerm](https://github.com/sk1t0n/dotfiles/blob/master/home/anton/.wezterm.lua#L13))
- [bash](https://www.gnu.org/software/bash/)
- [make](https://www.gnu.org/software/make/)

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

## Regenerate lua files if needed

**Linux**:

```bash
make generate
```

## Install dependencies for plugins

- [Requirements for mason.nvim](https://github.com/mason-org/mason.nvim#requirements)
- [C compiler for nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- [Node.js](https://nodejs.org/en/download)

You also need to install: [lazygit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation), [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation).

**Linux (Ubuntu/Debian)**:

```bash
sudo apt install lazygit ripgrep
```

## Install dependencies for selected languages

### Frontend dependencies

#### HTML

You need to install a prebuilt version of superhtml from the [Releases](https://github.com/kristoff-it/superhtml/releases) section (or build it yourself).

#### JavaScript, TypeScript

You need to install [vscode-js-debug](https://github.com/microsoft/vscode-js-debug).

1. Open nvim
2. Run the command `:MasonInstall js-debug-adapter`

### Others dependencies

#### YAML

You need to install: yamlfmt.

```bash
# install from source (alternative - install binary)
go install github.com/google/yamlfmt/cmd/yamlfmt@latest
```

To configure yamlfmt, you need to create a [configuration file](https://github.com/google/yamlfmt/blob/main/docs/config-file.md).

Example `~/.config/yamlfmt/.yamlfmt`:

```yaml
formatter:
  type: basic
  retain_line_breaks: true
  indent: 2
  include_document_start: false
```

#### Markdown

You need to install: [doctoc](https://github.com/thlorenz/doctoc), [mdformat](https://github.com/hukkin/mdformat), [vale](https://vale.sh).

**Linux (Ubuntu/Debian)**:

```bash
npm install -g doctoc
sudo apt update
sudo apt install pipx
pipx install mdformat
pipx inject mdformat mdformat-gfm
sudo snap install vale # for Ubuntu
```

Before using vale, you need

- to create a [configuration file](https://vale.sh/docs/vale-ini), for example `~/.config/vale/.vale.ini`:

    ```ini
    StylesPath = .
    MinAlertLevel = suggestion
    Packages = alex

    [*.{md}]
    BasedOnStyles = Vale, alex
    ```

- to run `vale sync` to download the packages.

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

You need to install: gopls, golangci-lint, goimports, golines, delve.

```bash
# install from source (alternative - install binary)
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/segmentio/golines@latest
go install github.com/go-delve/delve/cmd/dlv@latest
```

## Keymaps

[LazyVim Keymaps](https://www.lazyvim.org/keymaps)

### General

| № | Action  | Default Key  |  Custom Key  | Description          |    Mode     |
|:-:|---------|:------------:|:------------:|----------------------|:-----------:|
| 1 | Replace |   `<A-j>`    |  `<A-Down>`  | Move Down            | **n, i, v** |
| 2 | Replace |   `<A-k>`    |   `<A-Up>`   | Move Up              | **n, i, v** |
| 3 | Add     |              |   `<C-/>`    | Toggle comment line  |  **n, v**   |
| 4 | Replace |   `<C-/>`    |   `<C-`>`    | Terminal (Root Dir)  |    **n**    |
| 5 | Replace |   `<C-/>`    |   `<C-`>`    | Hide Terminal        |    **t**    |
| 6 | Add     |              |   `<C-x>`    | Escape terminal mode |    **t**    |
| 7 | Replace | `<leader>-`  | `<leader>\|` | Split Window Below   |    **n**    |
| 8 | Replace | `<leader>\|` | `<leader>\`  | Split Window Right   |    **n**    |

### LSP

|     Key      | Description         |     Mode     |
|:------------:|---------------------|:------------:|
|      K       | Hover               |    **n**     |
|      gK      | Signature Help      |    **n**     |
|      gD      | Goto Declaration    |    **n**     |
|      gd      | Goto Definition     |    **n**     |
|      gi      | Goto Implementation |    **n**     |
| `<leader>ca` | Code Action         | **n**, **v** |
| `<leader>cd` | Line Diagnostics    |    **n**     |
| `<leader>cr` | Rename              |    **n**     |

### refactoring.nvim

|     Key      | Description     |     Mode     |
|:------------:|-----------------|:------------:|
| `<leader>cR` | Select Refactor | **n**, **v** |

### treesj

|     Key      | Description                      | Mode  |
|:------------:|----------------------------------|:-----:|
| `<leader>cb` | Splitting/joining blocks of code | **n** |

### bufferline.nvim

|    Key    | Description | Mode  |
|:---------:|-------------|:-----:|
| `<S-Tab>` | Prev Buffer | **n** |
|  `<Tab>`  | Next Buffer | **n** |

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

### timerly

|     Key     | Description  | Mode  |
|:-----------:|--------------|:-----:|
| `<leader>T` | Toggle Timer | **n** |

### render-markdown.nvim

|     Key      | Description                | Mode  |
|:------------:|----------------------------|:-----:|
| `<leader>mm` | Toggle RenderMarkdown      | **n** |
| `<leader>mt` | Generate Table of Contents | **n** |

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
