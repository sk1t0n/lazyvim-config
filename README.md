# lazyvim_config

Scripts for installing LazyVim and generating Lua files. Users can select the programming languages ​​for which Lua files will be generated. This allows you to install and configure only plugins for the languages ​​you need. Supported programming, markup, and stylesheet languages: HTML with Emmet, CSS with Tailwind, JSON, YAML, Markdown, SQL, HTTP, JavaScript/TypeScript with React, Rust, Zig, Go, PHP with Laravel.

**Plugins that can install and setup**:

1. General: [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim), [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [conform.nvim](https://github.com/stevearc/conform.nvim), [neotest](https://github.com/nvim-neotest/neotest), [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter), [nvim-lint](https://github.com/mfussenegger/nvim-lint), [nvim-dap](https://github.com/mfussenegger/nvim-dap), [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui), [actions-preview.nvim](https://github.com/aznhe21/actions-preview.nvim), [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim), [treesj](https://github.com/Wansmer/treesj), [garbage-day.nvim](https://github.com/Zeioth/garbage-day.nvim), [smartcolumn.nvim](https://github.com/m4xshen/smartcolumn.nvim), [focus.nvim](https://github.com/nvim-focus/focus.nvim), [better-escape.nvim](https://github.com/max397574/better-escape.nvim), [zen-mode.nvim](https://github.com/folke/zen-mode.nvim), [timerly](https://github.com/nvzone/timerly)
2. AI: [windsurf.nvim](https://github.com/Exafunction/windsurf.nvim) or [copilot.vim](https://github.com/github/copilot.vim) + [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)
3. Others: [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim), [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui), [kulala.nvim](https://github.com/mistweaverco/kulala.nvim)
4. Frontend: [neotest-jest](https://github.com/nvim-neotest/neotest-jest), [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors)
5. Rust: [rustaceanvim](https://github.com/mrcjkb/rustaceanvim), [crates.nvim](https://github.com/saecki/crates.nvim)
6. Go: [neotest-golang](https://github.com/fredrikaverpil/neotest-golang), [nvim-dap-go](https://github.com/leoluz/nvim-dap-go)
7. PHP: [neotest-pest](https://github.com/V13Axel/neotest-pest), [blade-nav.nvim](https://github.com/RicardoRamirezR/blade-nav.nvim)

<details>
<summary>Table of Contents</summary>

- [Requirements](#requirements)
- [Install LazyVim and generate lua files](#install-lazyvim-and-generate-lua-files)
- [Delete configuration](#delete-configuration)
- [Regenerate lua files if necessary](#regenerate-lua-files-if-necessary)
- [Install dependencies for plugins](#install-dependencies-for-plugins)
- [Install dependencies for selected languages](#install-dependencies-for-selected-languages)
  - [Frontend dependencies](#frontend-dependencies)
    - [HTML](#html)
    - [JavaScript, TypeScript](#javascript-typescript)
  - [Others dependencies](#others-dependencies)
    - [Spell checker for code](#spell-checker-for-code)
    - [Spell checker for prose](#spell-checker-for-prose)
    - [YAML](#yaml)
    - [Markdown](#markdown)
    - [SQL](#sql)
    - [HTTP](#http)
  - [Rust dependencies](#rust-dependencies)
  - [Zig dependencies](#zig-dependencies)
  - [Go dependencies](#go-dependencies)
  - [PHP dependencies](#php-dependencies)
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
  - [render-markdown.nvim](#render-markdownnvim)
  - [vim-dadbod-ui](#vim-dadbod-ui)
  - [kulala.nvim](#kulalanvim)
  - [blade-nav.nvim](blade-navnvim)
  - [windsurf.nvim](#windsurfnvim)
  - [copilot.vim, CopilotChat.nvim](#copilotvim-copilotchatnvim)
- [AI](#ai)
  - [Windsurf](#windsurf)
  - [Copilot](#copilot)

</details>

## Requirements

- Unix (Linux/Mac). If all the plugins you need and their dependencies support Windows, you can try the following steps:
  1. install, for example, [Cygwin](https://cygwin.com/index.html) to work with bash, make, echo, printf, read, mkdir, curl, gcc etc;
  2. replace all paths in the script `scripts/generate_lua_files.sh`. Paths to replace:
     - `~/.config/nvim` :arrow_right: `~/AppData/Local/nvim`,
     - `~/.local/share/nvim` :arrow_right: `~/AppData/Local/nvim-data`.
- [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- [Git](https://git-scm.com/downloads)
- [Nerd Font](https://www.nerdfonts.com/font-downloads) - for to support icons in fonts (example configuration file for [WezTerm](https://github.com/sk1t0n/dotfiles/blob/master/home/anton/.wezterm.lua#L13), [mappings](https://github.com/sk1t0n/dotfiles#mappings-weztermlua) for this WezTerm configuration)
- [bash](https://www.gnu.org/software/bash/)
- [make](https://www.gnu.org/software/make/)

## Install LazyVim and generate lua files

**Unix (Linux/Mac)**:

```bash
make install
# or
make
```

## Delete configuration

**Unix (Linux/Mac)**:

```bash
make delete
# or delete configuration along with backups
make delete DELETE_WITH_BACKUPS=true
```

## Regenerate lua files if necessary

**Unix (Linux/Mac)**:

```bash
make generate
```

## Install dependencies for plugins

- [Requirements for mason.nvim](https://github.com/mason-org/mason.nvim#requirements)
- [C compiler for nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- [Python for mdformat](https://www.python.org/downloads/)
- [Node.js](https://nodejs.org/en/download)

You also should install: [lazygit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation), [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation), [fdfind](https://github.com/sharkdp/fd#installation), [fzf](https://github.com/junegunn/fzf#installation).

**Linux (Ubuntu/Debian)**:

```bash
sudo apt update
sudo apt install lazygit ripgrep fd-find fzf
```

**Mac**:

```bash
brew update
brew install lazygit ripgrep fd-find fzf
```

## Install dependencies for selected languages

### Frontend dependencies

#### HTML

To enable formatting, you need to set the `html.formatter.enabled` parameter to `true`. [See the example](#example_biome_config) for details.

#### JavaScript, TypeScript

You should install [vscode-js-debug](https://github.com/microsoft/vscode-js-debug).

1. Open nvim
2. Run the command `:MasonInstall js-debug-adapter`

To configure biome, you need to create a [configuration file](https://biomejs.dev/reference/configuration/) in the root folder of your project.

<p id="example_biome_config">Example <i>biome.json</i>:</p>

```json
{
  "html": {
    "formatter": {
      "enabled": true,
      "indentStyle": "space",
      "indentWidth": 2
    }
  },
  "css": {
    "formatter": {
      "indentStyle": "space",
      "indentWidth": 2
    }
  },
  "javascript": {
    "formatter": {
      "indentStyle": "space",
      "indentWidth": 2,
      "quoteStyle": "double",
      "semicolons": "always"
    }
  },
  "json": {
    "formatter": {
      "indentStyle": "space",
      "indentWidth": 2
    }
  }
}
```

### Others dependencies

#### Spell checker for code

You should install: [cspell](https://cspell.org/docs/installation).

**Unix (Linux/Mac)**:

```bash
npm install -g cspell@latest
```

To configure cspell, you need to create a [configuration file](https://cspell.org/docs/Configuration) in the root folder of your project.

Example `cspell.json`:

```jsonc
// cSpell Settings
{
    // Version of the setting file.  Always 0.2
    "version": "0.2",
    // language - current active spelling language
    "language": "en",
    // words - list of words to be always considered correct
    "words": [
        "mkdirp",
        "tsmerge",
        "githubusercontent",
        "streetsidesoftware",
        "vsmarketplacebadge",
        "visualstudio"
    ],
    // flagWords - list of words to be always considered incorrect
    // This is useful for offensive words and common spelling errors.
    // For example "hte" should be "the"
    "flagWords": [
        "hte"
    ]
}
```

#### Spell checker for prose

To configure harper, you need to create a [user dictionary](https://writewithharper.com/docs/integrations/language-server#User-Dictionary).

Example `~/.config/harper-ls/dictionary.txt` (Linux):

```txt
vscode
nvim
Neovim
```

#### YAML

You should install: [yamlfmt](https://github.com/google/yamlfmt/releases).

```bash
# install from source (or you can choose your installation method from the link above)
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

You should install: [doctoc](https://github.com/thlorenz/doctoc), [mdformat](https://github.com/hukkin/mdformat), [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2).

**Linux (Ubuntu/Debian)**:

```bash
npm install -g doctoc
sudo apt install pipx
pipx install mdformat
pipx inject mdformat mdformat-gfm mdformat-frontmatter mdformat-footnote mdformat-gfm-alerts
pipx inject mdformat mdformat-toc
npm install markdownlint-cli2 --global
```

**Mac**:

```bash
npm install -g doctoc
brew install pipx
pipx install mdformat
pipx inject mdformat mdformat-gfm mdformat-frontmatter mdformat-footnote mdformat-gfm-alerts
pipx inject mdformat mdformat-toc
npm install markdownlint-cli2 --global
```

To configure mdformat, you need to create a [configuration file](https://mdformat.readthedocs.io/en/stable/users/configuration_file.html) in the root folder of your project.

Example `.mdformat.toml`:

```toml
wrap = "keep" # options: {"keep", "no", INTEGER}
number = true # options: {false, true}
end_of_line = "lf" # options: {"lf", "crlf", "keep"}
validate = true # options: {false, true}
extensions = [ # options: a list of enabled extensions (default: all installed are enabled)
    "gfm",
    "toc",
]

# Python 3.13+ only:
exclude = [ # options: a list of file path pattern strings
    "**/node_modules/**", # recursively exclude a directory at any level
]
```

To configure markdownlint, you need to create a configuration file in the root folder of your project.

Example `.markdownlint.yaml`:

```yaml
# Example markdownlint configuration with all properties set to their default value
# https://github.com/DavidAnson/markdownlint/blob/main/schema/.markdownlint.yaml

default: true  # Start with all default rules

MD013:  # Line length rule
  line_length: 120  # Allow lines up to 120 characters

MD025:  # First heading should be a top-level heading
  front_matter_title: ""  # Allow front-matter titles (e.g., Jekyll/Hugo)

MD026: false  # Disable "Trailing punctuation in headings" rule

MD033: false  # Allow inline HTML (e.g., <div>, <br>) inside Markdown files
```

#### SQL

You should install: [sqruff](https://github.com/quarylabs/sqruff).

**Linux**:

```bash
curl -fsSL https://raw.githubusercontent.com/quarylabs/sqruff/main/install.sh | bash
```

**Mac**:

```bash
brew install sqruff
```

To configure sqruff, you need to create a [configuration file](https://github.com/quarylabs/sqruff#configuration) in the root folder of your project.

Example `.sqruff`:

```ini
[sqruff]
dialect = sqlite
exclude_rules = AM01,AM02
rules = all

[sqruff:indentation]
indent_unit = space
tab_space_size = 4
indented_joins = True
```

#### HTTP

You should install: [curl](https://curl.se/download.html).

**Linux (Ubuntu/Debian)**:

```bash
sudo apt install curl
```

**Mac**:

```bash
brew install curl
```

### Rust dependencies

You should install: rust-analyzer, clippy, rustfmt, [cargo-nextest](https://github.com/nextest-rs/nextest/tree/main/cargo-nextest).

**Unix (Linux/Mac)**:

```bash
rustup component add rust-analyzer
rustup component add clippy
rustup component add rustfmt
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash # or for Mac: brew install cargo-binstall
cargo binstall cargo-nextest --secure
```

### Zig dependencies

You should install: [ziggy](https://github.com/kristoff-it/ziggy/releases/).

### Go dependencies

You should install: gopls, [golangci-lint](https://golangci-lint.run/docs/welcome/install/#local-installation), goimports, [golines](https://github.com/segmentio/golines/releases), [delve](https://github.com/go-delve/delve/tree/master/Documentation/installation).

```bash
# install from source (or you can choose your installation method from the link above)
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/segmentio/golines@latest
go install github.com/go-delve/delve/cmd/dlv@latest
```

To configure golangci-lint, you need to create a [configuration file](https://golangci-lint.run/docs/configuration/file/) in the root folder of your project.

<details>
<summary>Golden configuration <i>.golangci.yml</i></summary>

```yaml
# This file is licensed under the terms of the MIT license https://opensource.org/license/mit
# Copyright (c) 2021-2025 Marat Reymers

## Golden config for golangci-lint v2.5.0
#
# This is the best config for golangci-lint based on my experience and opinion.
# It is very strict, but not extremely strict.
# Feel free to adapt it to suit your needs.
# If this config helps you, please consider keeping a link to this file (see the next comment).

# Based on https://gist.github.com/maratori/47a4d00457a92aa426dbd48a18776322

version: "2"

issues:
  # Maximum count of issues with the same text.
  # Set to 0 to disable.
  # Default: 3
  max-same-issues: 50

formatters:
  enable:
    - goimports # checks if the code and import statements are formatted according to the 'goimports' command
    - golines # checks if code is formatted, and fixes long lines

    ## you may want to enable
    #- gci # checks if code and import statements are formatted, with additional rules
    #- gofmt # checks if the code is formatted according to 'gofmt' command
    #- gofumpt # enforces a stricter format than 'gofmt', while being backwards compatible
    #- swaggo # formats swaggo comments

  # All settings can be found here https://github.com/golangci/golangci-lint/blob/HEAD/.golangci.reference.yml
  settings:
    goimports:
      # A list of prefixes, which, if set, checks import paths
      # with the given prefixes are grouped after 3rd-party packages.
      # Default: []
      local-prefixes:
        - github.com/my/project

    golines:
      # Target maximum line length.
      # Default: 100
      max-len: 120

linters:
  enable:
    - asasalint # checks for pass []any as any in variadic func(...any)
    - asciicheck # checks that your code does not contain non-ASCII identifiers
    - bidichk # checks for dangerous unicode character sequences
    - bodyclose # checks whether HTTP response body is closed successfully
    - canonicalheader # checks whether net/http.Header uses canonical header
    - copyloopvar # detects places where loop variables are copied (Go 1.22+)
    - cyclop # checks function and package cyclomatic complexity
    - depguard # checks if package imports are in a list of acceptable packages
    - dupl # tool for code clone detection
    - durationcheck # checks for two durations multiplied together
    - embeddedstructfieldcheck # checks embedded types in structs
    - errcheck # checking for unchecked errors, these unchecked errors can be critical bugs in some cases
    - errname # checks that sentinel errors are prefixed with the Err and error types are suffixed with the Error
    - errorlint # finds code that will cause problems with the error wrapping scheme introduced in Go 1.13
    - exhaustive # checks exhaustiveness of enum switch statements
    - exptostd # detects functions from golang.org/x/exp/ that can be replaced by std functions
    - fatcontext # detects nested contexts in loops
    - forbidigo # forbids identifiers
    - funcorder # checks the order of functions, methods, and constructors
    - funlen # tool for detection of long functions
    - gocheckcompilerdirectives # validates go compiler directive comments (//go:)
    - gochecknoglobals # checks that no global variables exist
    - gochecknoinits # checks that no init functions are present in Go code
    - gochecksumtype # checks exhaustiveness on Go "sum types"
    - gocognit # computes and checks the cognitive complexity of functions
    - goconst # finds repeated strings that could be replaced by a constant
    - gocritic # provides diagnostics that check for bugs, performance and style issues
    - gocyclo # computes and checks the cyclomatic complexity of functions
    - godoclint # checks Golang's documentation practice
    - godot # checks if comments end in a period
    - gomoddirectives # manages the use of 'replace', 'retract', and 'excludes' directives in go.mod
    - goprintffuncname # checks that printf-like functions are named with f at the end
    - gosec # inspects source code for security problems
    - govet # reports suspicious constructs, such as Printf calls whose arguments do not align with the format string
    - iface # checks the incorrect use of interfaces, helping developers avoid interface pollution
    - ineffassign # detects when assignments to existing variables are not used
    - intrange # finds places where for loops could make use of an integer range
    - iotamixing # checks if iotas are being used in const blocks with other non-iota declarations
    - loggercheck # checks key value pairs for common logger libraries (kitlog,klog,logr,zap)
    - makezero # finds slice declarations with non-zero initial length
    - mirror # reports wrong mirror patterns of bytes/strings usage
    - mnd # detects magic numbers
    - musttag # enforces field tags in (un)marshaled structs
    - nakedret # finds naked returns in functions greater than a specified function length
    - nestif # reports deeply nested if statements
    - nilerr # finds the code that returns nil even if it checks that the error is not nil
    - nilnesserr # reports that it checks for err != nil, but it returns a different nil value error (powered by nilness and nilerr)
    - nilnil # checks that there is no simultaneous return of nil error and an invalid value
    - noctx # finds sending http request without context.Context
    - nolintlint # reports ill-formed or insufficient nolint directives
    - nonamedreturns # reports all named returns
    - nosprintfhostport # checks for misuse of Sprintf to construct a host with port in a URL
    - perfsprint # checks that fmt.Sprintf can be replaced with a faster alternative
    - predeclared # finds code that shadows one of Go's predeclared identifiers
    - promlinter # checks Prometheus metrics naming via promlint
    - protogetter # reports direct reads from proto message fields when getters should be used
    - reassign # checks that package variables are not reassigned
    - recvcheck # checks for receiver type consistency
    - revive # fast, configurable, extensible, flexible, and beautiful linter for Go, drop-in replacement of golint
    - rowserrcheck # checks whether Err of rows is checked successfully
    - sloglint # ensure consistent code style when using log/slog
    - spancheck # checks for mistakes with OpenTelemetry/Census spans
    - sqlclosecheck # checks that sql.Rows and sql.Stmt are closed
    - staticcheck # is a go vet on steroids, applying a ton of static analysis checks
    - testableexamples # checks if examples are testable (have an expected output)
    - testifylint # checks usage of github.com/stretchr/testify
    - testpackage # makes you use a separate _test package
    - tparallel # detects inappropriate usage of t.Parallel() method in your Go test codes
    - unconvert # removes unnecessary type conversions
    - unparam # reports unused function parameters
    - unqueryvet # detects SELECT * in SQL queries and SQL builders, encouraging explicit column selection
    - unused # checks for unused constants, variables, functions and types
    - usestdlibvars # detects the possibility to use variables/constants from the Go standard library
    - usetesting # reports uses of functions with replacement inside the testing package
    - wastedassign # finds wasted assignment statements
    - whitespace # detects leading and trailing whitespace

    ## you may want to enable
    #- arangolint # opinionated best practices for arangodb client
    #- decorder # checks declaration order and count of types, constants, variables and functions
    #- exhaustruct # [highly recommend to enable] checks if all structure fields are initialized
    #- ginkgolinter # [if you use ginkgo/gomega] enforces standards of using ginkgo and gomega
    #- godox # detects usage of FIXME, TODO and other keywords inside comments
    #- goheader # checks is file header matches to pattern
    #- inamedparam # [great idea, but too strict, need to ignore a lot of cases by default] reports interfaces with unnamed method parameters
    #- interfacebloat # checks the number of methods inside an interface
    #- ireturn # accept interfaces, return concrete types
    #- noinlineerr # disallows inline error handling `if err := ...; err != nil {`
    #- prealloc # [premature optimization, but can be used in some cases] finds slice declarations that could potentially be preallocated
    #- tagalign # checks that struct tags are well aligned
    #- varnamelen # [great idea, but too many false positives] checks that the length of a variable's name matches its scope
    #- wrapcheck # checks that errors returned from external packages are wrapped
    #- zerologlint # detects the wrong usage of zerolog that a user forgets to dispatch zerolog.Event

    ## disabled
    #- containedctx # detects struct contained context.Context field
    #- contextcheck # [too many false positives] checks the function whether use a non-inherited context
    #- dogsled # checks assignments with too many blank identifiers (e.g. x, _, _, _, := f())
    #- dupword # [useless without config] checks for duplicate words in the source code
    #- err113 # [too strict] checks the errors handling expressions
    #- errchkjson # [don't see profit + I'm against of omitting errors like in the first example https://github.com/breml/errchkjson] checks types passed to the json encoding functions. Reports unsupported types and optionally reports occasions, where the check for the returned error can be omitted
    #- forcetypeassert # [replaced by errcheck] finds forced type assertions
    #- gomodguard # [use more powerful depguard] allow and block lists linter for direct Go module dependencies
    #- gosmopolitan # reports certain i18n/l10n anti-patterns in your Go codebase
    #- grouper # analyzes expression groups
    #- importas # enforces consistent import aliases
    #- lll # [replaced by golines] reports long lines
    #- maintidx # measures the maintainability index of each function
    #- misspell # [useless] finds commonly misspelled English words in comments
    #- nlreturn # [too strict and mostly code is not more readable] checks for a new line before return and branch statements to increase code clarity
    #- paralleltest # [too many false positives] detects missing usage of t.Parallel() method in your Go test
    #- tagliatelle # checks the struct tags
    #- thelper # detects golang test helpers without t.Helper() call and checks the consistency of test helpers
    #- wsl # [too strict and mostly code is not more readable] whitespace linter forces you to use empty lines
    #- wsl_v5 # [too strict and mostly code is not more readable] add or remove empty lines

  # All settings can be found here https://github.com/golangci/golangci-lint/blob/HEAD/.golangci.reference.yml
  settings:
    cyclop:
      # The maximal code complexity to report.
      # Default: 10
      max-complexity: 30
      # The maximal average package complexity.
      # If it's higher than 0.0 (float) the check is enabled.
      # Default: 0.0
      package-average: 10.0

    depguard:
      # Rules to apply.
      #
      # Variables:
      # - File Variables
      #   Use an exclamation mark `!` to negate a variable.
      #   Example: `!$test` matches any file that is not a go test file.
      #
      #   `$all` - matches all go files
      #   `$test` - matches all go test files
      #
      # - Package Variables
      #
      #   `$gostd` - matches all of go's standard library (Pulled from `GOROOT`)
      #
      # Default (applies if no custom rules are defined): Only allow $gostd in all files.
      rules:
        "deprecated":
          # List of file globs that will match this list of settings to compare against.
          # By default, if a path is relative, it is relative to the directory where the golangci-lint command is executed.
          # The placeholder '${base-path}' is substituted with a path relative to the mode defined with `run.relative-path-mode`.
          # The placeholder '${config-path}' is substituted with a path relative to the configuration file.
          # Default: $all
          files:
            - "$all"
          # List of packages that are not allowed.
          # Entries can be a variable (starting with $), a string prefix, or an exact match (if ending with $).
          # Default: []
          deny:
            - pkg: github.com/golang/protobuf
              desc: Use google.golang.org/protobuf instead, see https://developers.google.com/protocol-buffers/docs/reference/go/faq#modules
            - pkg: github.com/satori/go.uuid
              desc: Use github.com/google/uuid instead, satori's package is not maintained
            - pkg: github.com/gofrs/uuid$
              desc: Use github.com/gofrs/uuid/v5 or later, it was not a go module before v5
        "non-test files":
          files:
            - "!$test"
          deny:
            - pkg: math/rand$
              desc: Use math/rand/v2 instead, see https://go.dev/blog/randv2
        "non-main files":
          files:
            - "!**/main.go"
          deny:
            - pkg: log$
              desc: Use log/slog instead, see https://go.dev/blog/slog

    embeddedstructfieldcheck:
      # Checks that sync.Mutex and sync.RWMutex are not used as embedded fields.
      # Default: false
      forbid-mutex: true

    errcheck:
      # Report about not checking of errors in type assertions: `a := b.(MyStruct)`.
      # Such cases aren't reported by default.
      # Default: false
      check-type-assertions: true

    exhaustive:
      # Program elements to check for exhaustiveness.
      # Default: [ switch ]
      check:
        - switch
        - map

    exhaustruct:
      # List of regular expressions to match type names that should be excluded from processing.
      # Anonymous structs can be matched by '<anonymous>' alias.
      # Has precedence over `include`.
      # Each regular expression must match the full type name, including package path.
      # For example, to match type `net/http.Cookie` regular expression should be `.*/http\.Cookie`,
      # but not `http\.Cookie`.
      # Default: []
      exclude:
        # std libs
        - ^net/http.Client$
        - ^net/http.Cookie$
        - ^net/http.Request$
        - ^net/http.Response$
        - ^net/http.Server$
        - ^net/http.Transport$
        - ^net/url.URL$
        - ^os/exec.Cmd$
        - ^reflect.StructField$
        # public libs
        - ^github.com/Shopify/sarama.Config$
        - ^github.com/Shopify/sarama.ProducerMessage$
        - ^github.com/mitchellh/mapstructure.DecoderConfig$
        - ^github.com/prometheus/client_golang/.+Opts$
        - ^github.com/spf13/cobra.Command$
        - ^github.com/spf13/cobra.CompletionOptions$
        - ^github.com/stretchr/testify/mock.Mock$
        - ^github.com/testcontainers/testcontainers-go.+Request$
        - ^github.com/testcontainers/testcontainers-go.FromDockerfile$
        - ^golang.org/x/tools/go/analysis.Analyzer$
        - ^google.golang.org/protobuf/.+Options$
        - ^gopkg.in/yaml.v3.Node$
      # Allows empty structures in return statements.
      # Default: false
      allow-empty-returns: true

    funcorder:
      # Checks if the exported methods of a structure are placed before the non-exported ones.
      # Default: true
      struct-method: false

    funlen:
      # Checks the number of lines in a function.
      # If lower than 0, disable the check.
      # Default: 60
      lines: 100
      # Checks the number of statements in a function.
      # If lower than 0, disable the check.
      # Default: 40
      statements: 50

    gochecksumtype:
      # Presence of `default` case in switch statements satisfies exhaustiveness, if all members are not listed.
      # Default: true
      default-signifies-exhaustive: false

    gocognit:
      # Minimal code complexity to report.
      # Default: 30 (but we recommend 10-20)
      min-complexity: 20

    gocritic:
      # Settings passed to gocritic.
      # The settings key is the name of a supported gocritic checker.
      # The list of supported checkers can be found at https://go-critic.com/overview.
      settings:
        captLocal:
          # Whether to restrict checker to params only.
          # Default: true
          paramsOnly: false
        underef:
          # Whether to skip (*x).method() calls where x is a pointer receiver.
          # Default: true
          skipRecvDeref: false

    godoclint:
      # List of rules to enable in addition to the default set.
      # Default: empty
      enable:
        # Assert no unused link in godocs.
        # https://github.com/godoc-lint/godoc-lint?tab=readme-ov-file#no-unused-link
        - no-unused-link

    govet:
      # Enable all analyzers.
      # Default: false
      enable-all: true
      # Disable analyzers by name.
      # Run `GL_DEBUG=govet golangci-lint run --enable=govet` to see default, all available analyzers, and enabled analyzers.
      # Default: []
      disable:
        - fieldalignment # too strict
      # Settings per analyzer.
      settings:
        shadow:
          # Whether to be strict about shadowing; can be noisy.
          # Default: false
          strict: true

    inamedparam:
      # Skips check for interface methods with only a single parameter.
      # Default: false
      skip-single-param: true

    mnd:
      # List of function patterns to exclude from analysis.
      # Values always ignored: `time.Date`,
      # `strconv.FormatInt`, `strconv.FormatUint`, `strconv.FormatFloat`,
      # `strconv.ParseInt`, `strconv.ParseUint`, `strconv.ParseFloat`.
      # Default: []
      ignored-functions:
        - args.Error
        - flag.Arg
        - flag.Duration.*
        - flag.Float.*
        - flag.Int.*
        - flag.Uint.*
        - os.Chmod
        - os.Mkdir.*
        - os.OpenFile
        - os.WriteFile
        - prometheus.ExponentialBuckets.*
        - prometheus.LinearBuckets

    nakedret:
      # Make an issue if func has more lines of code than this setting, and it has naked returns.
      # Default: 30
      max-func-lines: 0

    nolintlint:
      # Exclude following linters from requiring an explanation.
      # Default: []
      allow-no-explanation: [ funlen, gocognit, golines ]
      # Enable to require an explanation of nonzero length after each nolint directive.
      # Default: false
      require-explanation: true
      # Enable to require nolint directives to mention the specific linter being suppressed.
      # Default: false
      require-specific: true

    perfsprint:
      # Optimizes into strings concatenation.
      # Default: true
      strconcat: false

    reassign:
      # Patterns for global variable names that are checked for reassignment.
      # See https://github.com/curioswitch/go-reassign#usage
      # Default: ["EOF", "Err.*"]
      patterns:
        - ".*"

    rowserrcheck:
      # database/sql is always checked.
      # Default: []
      packages:
        - github.com/jmoiron/sqlx

    sloglint:
      # Enforce not using global loggers.
      # Values:
      # - "": disabled
      # - "all": report all global loggers
      # - "default": report only the default slog logger
      # https://github.com/go-simpler/sloglint?tab=readme-ov-file#no-global
      # Default: ""
      no-global: all
      # Enforce using methods that accept a context.
      # Values:
      # - "": disabled
      # - "all": report all contextless calls
      # - "scope": report only if a context exists in the scope of the outermost function
      # https://github.com/go-simpler/sloglint?tab=readme-ov-file#context-only
      # Default: ""
      context: scope

    staticcheck:
      # SAxxxx checks in https://staticcheck.dev/docs/configuration/options/#checks
      # Example (to disable some checks): [ "all", "-SA1000", "-SA1001"]
      # Default: ["all", "-ST1000", "-ST1003", "-ST1016", "-ST1020", "-ST1021", "-ST1022"]
      checks:
        - all
        # Incorrect or missing package comment.
        # https://staticcheck.dev/docs/checks/#ST1000
        - -ST1000
        # Use consistent method receiver names.
        # https://staticcheck.dev/docs/checks/#ST1016
        - -ST1016
        # Omit embedded fields from selector expression.
        # https://staticcheck.dev/docs/checks/#QF1008
        - -QF1008

    usetesting:
      # Enable/disable `os.TempDir()` detections.
      # Default: false
      os-temp-dir: true

  exclusions:
    # Log a warning if an exclusion rule is unused.
    # Default: false
    warn-unused: true
    # Predefined exclusion rules.
    # Default: []
    presets:
      - std-error-handling
      - common-false-positives
    # Excluding configuration per-path, per-linter, per-text and per-source.
    rules:
      - source: 'TODO'
        linters: [ godot ]
      - text: 'should have a package comment'
        linters: [ revive ]
      - text: 'exported \S+ \S+ should have comment( \(or a comment on this block\))? or be unexported'
        linters: [ revive ]
      - text: 'package comment should be of the form ".+"'
        source: '// ?(nolint|TODO)'
        linters: [ revive ]
      - text: 'comment on exported \S+ \S+ should be of the form ".+"'
        source: '// ?(nolint|TODO)'
        linters: [ revive, staticcheck ]
      - path: '_test\.go'
        linters:
          - bodyclose
          - dupl
          - errcheck
          - funlen
          - goconst
          - gosec
          - noctx
          - wrapcheck
```

</details>

### PHP dependencies

You should install [vscode-php-debug](https://github.com/xdebug/vscode-php-debug).

1. Open nvim

2. Run the command `:MasonInstall php-debug-adapter`

3. Install [Xdebug](https://xdebug.org/docs/install)

4. [Configure PHP to use Xdebug](https://xdebug.org/docs/install#configure-php)

   Simple `xdebug.ini`:

   ```ini
   zend_extension=xdebug.so

   xdebug.mode = debug
   xdebug.start_with_request = yes
   ```

To configure phpstan, you need to create a [configuration file](https://phpstan.org/config-reference) in the root folder of your project.

Example `phpstan.dist.neon`:

```neon
parameters:
    level: 6
    paths:
        - src
        - tests
```

To configure pint, you need to create a [configuration file](https://laravel.com/docs/12.x/pint#configuring-pint) in the root folder of your project.

Example `pint.json`:

```json
{
    "preset": "laravel"
}
```

Instead of pint, you can configure php-cs-fixer. To do this, you need to create a [configuration file](https://cs.symfony.com/doc/config.html) in the root folder of your project.

Example `.php-cs-fixer.dist.php`:

```php
<?php

$finder = PhpCsFixer\Finder::create()
    ->exclude(['node_modules', 'storage', 'vendor'])
    ->in(__DIR__);

$config = new PhpCsFixer\Config();

return $config
    ->setRiskyAllowed(true)
    ->setRules([
        '@PhpCsFixer' => true,
        'echo_tag_syntax' => ['format' => 'long'],
        'multiline_whitespace_before_semicolons' => [
            'strategy' => 'no_multi_line',
        ],
        'yoda_style' => [
            'equal' => false,
            'identical' => false,
            'less_and_greater' => false,
        ],
        'blank_line_before_statement' => [
            'statements' => ['declare', 'return'],
        ],
        'no_alternative_syntax' => ['fix_non_monolithic_code' => false],
        'phpdoc_to_comment' => ['ignored_tags' => ['var']],
        'not_operator_with_successor_space' => true,
    ])->setFinder($finder);
```

To format Blade templates you need to install [blade-formatter](https://github.com/shufo/blade-formatter).

```bash
npm install -g blade-formatter
```

To configure blade-formatter, you need to create a [configuration file](https://github.com/shufo/blade-formatter#configuring-blade-formatter) in the root folder of your project.

Example `.bladeformatterrc.json`:

```json
{
  "indentSize": 4,
  "wrapAttributes": "auto",
  "wrapLineLength": 120,
  "wrapAttributesMinAttrs": 2,
  "indentInnerHtml": true,
  "endWithNewLine": true,
  "endOfLine": "LF",
  "useTabs": false,
  "sortTailwindcssClasses": true,
  "sortHtmlAttributes": "none",
  "noMultipleEmptyLines": false,
  "noPhpSyntaxCheck": false,
  "noSingleQuote": false,
  "noTrailingCommaPhp": false,
  "extraLiners": [],
  "componentPrefix": ["x-", "livewire:"],
  "phpVersion": "8.4"
}
```

## Keymaps

[LazyVim Keymaps](https://www.lazyvim.org/keymaps)

### General

|  №  | Action  | Default Key  |  Custom Key  | Description          |    Mode     |
| :-: | ------- | :----------: | :----------: | -------------------- | :---------: |
|  1  | Add     |              | `<leader>h`  | WhichKey             |    **n**    |
|  2  | Replace |   `<A-j>`    |  `<A-Down>`  | Move Down            | **n, i, v** |
|  3  | Replace |   `<A-k>`    |   `<A-Up>`   | Move Up              | **n, i, v** |
|  4  | Add     |              |   `<C-/>`    | Toggle comment line  |  **n, v**   |
|  5  | Replace |   `<C-/>`    |   `<C-`>`    | Terminal (Root Dir)  |    **n**    |
|  6  | Replace |   `<C-/>`    |   `<C-`>`    | Hide Terminal        |    **t**    |
|  7  | Add     |              |   `<C-x>`    | Escape terminal mode |    **t**    |
|  8  | Replace | `<leader>-`  | `<leader>\|` | Split Window Below   |    **n**    |
|  9  | Replace | `<leader>\|` | `<leader>\`  | Split Window Right   |    **n**    |

### LSP

|     Key      | Description         |     Mode     |
| :----------: | ------------------- | :----------: |
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
| :----------: | --------------- | :----------: |
| `<leader>cR` | Select Refactor | **n**, **v** |

### treesj

|     Key      | Description                      | Mode  |
| :----------: | -------------------------------- | :---: |
| `<leader>cb` | Splitting/joining blocks of code | **n** |

### bufferline.nvim

|    Key    | Description | Mode  |
| :-------: | ----------- | :---: |
| `<S-Tab>` | Prev Buffer | **n** |
|  `<Tab>`  | Next Buffer | **n** |

### neotest

|     Key      | Description                   | Mode  |
| :----------: | ----------------------------- | :---: |
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
| :----------: | ----------------------- | :---: |
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
| :----------: | ----------- | :----------: |
| `<leader>de` | Eval        | **n**, **v** |
| `<leader>du` | Dap UI      |    **n**     |

### timerly

|     Key     | Description  | Mode  |
| :---------: | ------------ | :---: |
| `<leader>T` | Toggle Timer | **n** |

### render-markdown.nvim

|     Key      | Description                | Mode  |
| :----------: | -------------------------- | :---: |
| `<leader>mm` | Toggle RenderMarkdown      | **n** |
| `<leader>mt` | Generate Table of Contents | **n** |

### vim-dadbod-ui

|     Key     | Description | Mode  |
| :---------: | ----------- | :---: |
| `<leader>D` | Toggle DBUI | **n** |

### kulala.nvim

|     Key      | Description       |     Mode     |
| :----------: | ----------------- | :----------: |
| `<leader>rs` | Send request      | **n**, **v** |
| `<leader>ra` | Send all requests | **n**, **v** |
| `<leader>rb` | Open scratchpad   |    **n**     |

### blade-nav.nvim

| Key | Description                                  | Mode  |
| :-: | -------------------------------------------- | :---: |
| gf  | Goto File (Blade template / Blade component) | **n** |

### windsurf.nvim

|     Key      | Description                  | Mode  |
| :----------: | ---------------------------- | :---: |
|   `<A-[>`    | Codeium previous suggestion  | **i** |
|   `<A-]>`    | Codeium next suggestion      | **i** |
|   `<Tab>`    | Codeium accept suggestion    | **i** |
| `<leader>a`  | +ai                          | **n** |
| `<leader>aa` | Open Codeium Chat in Browser | **n** |

### copilot.vim, CopilotChat.nvim

|     Key      | Description                  |     Mode     |
| :----------: | ---------------------------- | :----------: |
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
