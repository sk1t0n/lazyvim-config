generate_frontend() {
read -p "Install plugins for Frontend? (y/n, default: y): " -i "y" -e need_frontend
if [[ "$need_frontend" == "y" || "$need_frontend" == "Y" ]]; then
    frontend_plugins='
  { "nvim-neotest/neotest-jest" },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },'
    frontend_conform='javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    json = { "biome" },
    css = { "biome" },'
    frontend_lsp=(
        '"html",'
        '"emmet_ls",'
        '"cssls",'
        '"css_variables",'
        '"cssmodules_ls",'
        '"tailwindcss",'
        '"jsonls",'
        '"biome",'
        '"ts_ls",'
    )
    frontend_treesitter='"html",
    "css",
    "json",
    "jsdoc",
    "javascript",
    "typescript",
    "tsx",'
    frontend_dap='local frontend_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
for _, language in ipairs(frontend_filetypes) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file in new node process",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach debugger to existing `npm --node-options --inspect-brk run dev` process",
      processId = require("dap.utils").pick_process,
      sourceMaps = true,
      resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
      cwd = "${workspaceFolder}", -- for Vite "${workspaceFolder}/src"
      skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome to debug client side code",
      url = "http://localhost:5173", -- default vite dev server url
      sourceMaps = true,
      webRoot = "${workspaceFolder}", -- for Vite "${workspaceFolder}/src"
      protocol = "inspector",
      port = 9222,
      skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*", "**/.next/*" },
    },
  }
end
local frontend_adapters = { "pwa-node", "pwa-chrome" }
local vscode = require("dap.ext.vscode")
for _, adapter in ipairs(frontend_adapters) do
  vscode.type_to_filetypes[adapter] = frontend_filetypes
  dap.adapters[adapter] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = {'
    frontend_dap+="
        \"$HOME/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js\",
        \"\${port}\",
      },
    },
  }
end"
    frontend_autocmds='vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "html" },
  callback = function()
    vim.lsp.start({
      name = "superhtml",
      cmd = { "superhtml", "lsp" },
      root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
    })
    vim.keymap.set("n", "<C-s>", "<cmd>!superhtml fmt .<cr>")
  end,
})'
    js_neotest='require("neotest-jest")({
      jestCommand = "npm test",
      jestConfigFile = function()
        local f = io.open("jest.config.ts", "r")
        if f then
          io.close(f)
          return "jest.config.ts"
        else
          return "jest.config.js"
        end
      end,
      env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
    }),'
    js_lint='
  javascript = { "biomejs" },
  typescript = { "biomejs" },
  javascriptreact = { "biomejs" },
  typescriptreact = { "biomejs" },'
else
    frontend_plugins=""
    frontend_conform=""
    frontend_lsp=()
    frontend_treesitter=""
    frontend_dap=""
    frontend_autocmds=""
    js_neotest=""
    js_lint=""
fi
}

generate_others() {
read -p "Install plugins for YAML, Markdown and SQL? (y/n, default: y): " -i "y" -e need_others
if [[ "$need_others" == "y" || "$need_others" == "Y" ]]; then
    others_plugins='
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
    opts = {},
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },'
    others_conform='
    yaml = { "yamlfmt" },
    markdown = { "mdformat" },
    sql = { "sqruff" },'
    others_lsp=(
        '"yamlls",
          "harper_ls",
          "marksman",
          "sqls",'
    )
    others_treesitter='
    "yaml",
    "markdown",
    "markdown_inline",
    "sql",'
    others_lint='markdown = { "vale" },
  sql = { "sqruff" },'
else
    others_plugins=""
    others_conform=""
    others_lsp=()
    others_treesitter=""
    others_lint=""
fi
}

generate_rust() {
read -p "Install Rust plugins? (y/n, default: n): " -i "n" -e need_rust
if [[ "$need_rust" == "y" || "$need_rust" == "Y" ]]; then
    rust_plugins='
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
  },
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup()
    end,
  },'
    rust_conform='
    rust = { "rustfmt" },'
    rust_neotest='
    require("rustaceanvim.neotest")({
      args = {},
    }),'
    rust_treesitter='
    "rust",'
else
    rust_plugins=""
    rust_conform=""
    rust_neotest=""
    rust_treesitter=""
fi
}

generate_go() {
read -p "Install Go plugins? (y/n, default: n): " -i "n" -e need_go
if [[ "$need_go" == "y" || "$need_go" == "Y" ]]; then
    go_plugins='
  {
    "fredrikaverpil/neotest-golang",
    version = "*",
    build = function()
      vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
    end,
  },
  { "leoluz/nvim-dap-go" },'
    go_conform='
    go = { "gofmt", "goimports", "golines" },'
    go_lsp=(
        '"golangci_lint_ls",'
    )
    go_inlay_hint="

lspconfig.gopls.setup({
  settings = {
    gopls = {
      hints = {
        parameterNames = true,
        functionTypeParameters = true,
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        rangeVariableTypes = true,
        constantValues = true,
      },
    },
  },
})"
    go_neotest='
    require("neotest-golang")({
      runner = "gotestsum",
    }),'
    go_treesitter='
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",'
    treesitter_gotmpl_injections='((text) @injection.content
 (#set! injection.language "html")
 (#set! injection.combined))'
    mkdir -p ~/.config/nvim/queries/gotmpl
    echo "$treesitter_gotmpl_injections" > ~/.config/nvim/queries/gotmpl/injections.scm
    go_lint='
  go = { "golangcilint" },'
    go_snippets='
      {
        "language": ["go"],
        "path": "./go.json"
      }'
    go_snippets_file='{
  "errneq": {
    "prefix": "errneq",
    "body": [
      "if err != nil {\n    ${0:return err}\n}"
    ],
    "description": "err != nil"
  },
  "erreq": {
    "prefix": "erreq",
    "body": ["if err == nil {\n    $0\n}"],
    "description": "err == nil"
  }
}'
    echo "$go_snippets_file" > ~/.config/nvim/snippets/go.json
    go_dap='

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}
dap.adapters.delve = function(callback, config)
  if config.mode == "remote" and config.request == "attach" then
    callback({
      type = "server",
      host = config.host or "127.0.0.1",
      port = config.port or "38697",
    })
  else
    callback({
      type = "server",
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
        detached = vim.fn.has("win32") == 0,
      },
    })
  end
end'
else
    go_plugins=""
    go_conform=""
    go_lsp=()
    go_inlay_hint=""
    go_neotest=""
    go_treesitter=""
    go_lint=""
    go_snippets=""
    go_dap=""
fi
}

generate_ai() {
read -p "Install AI plugin? (y/n, default: n): " -i "n" -e need_ai
if [[ "$need_ai" == "y" || "$need_ai" == "Y" ]]; then
    read -p "Choose plugin (1 - Windsurf, 2 - Copilot, default: 2): " -i "2" -e ai_plugin_input
    if [[ "$ai_plugin_input" == 1 ]]; then
        ai_plugin='
  {
    "Exafunction/windsurf.nvim",
    config = function()
      require("codeium").setup({
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
        },
      })
    end,
  },'
    else
        ai_plugin='
  { "github/copilot.vim" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "gptlang/lua-tiktoken",
    },
    build = "make tiktoken",
  },'
    fi
else
    ai_plugin=""
fi
}

generate_plugins() {
plugins_init_file_begin='return {
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
'
for lsp in "${frontend_lsp[@]}" "${others_lsp[@]}" "${go_lsp[@]}"; do
    plugins_init_file_begin+="          $lsp"$'\n'
done
plugins_init_file_begin+='        },
      })
    end,
  },
  '
read -r -d '' plugins_init_file << 'EOM'
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.plugins.lspconfig")
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require("config.plugins.conform"),
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("config.plugins.neotest")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("config.plugins.treesitter")
    end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("config.plugins.lint")
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("config.plugins.dap")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dapui").setup()

      local dap, dapui = require("dap"), require("dapui")

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  { "aznhe21/actions-preview.nvim" },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup()
    end,
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      aggressive_mode = false,
      grace_period = 60 * 15,
    },
  },
  {
    "m4xshen/smartcolumn.nvim",
    config = function()
      require("smartcolumn").setup({
        colorcolumn = { "80" },
      })
    end,
  },
  {
    "nvim-focus/focus.nvim",
    version = "*",
    config = function()
      require("focus").setup()
    end,
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 0.75,
      },
    },
  },
  {
    "nvzone/timerly",
    dependencies = "nvzone/volt",
    cmd = "TimerlyToggle",
    config = {
      position = "top-right",
    },
  },
EOM
plugins_init_file+="${frontend_plugins}${others_plugins}${rust_plugins}${go_plugins}${ai_plugin}
}"
echo "${plugins_init_file_begin}${plugins_init_file}" > ~/.config/nvim/lua/plugins/init.lua
}

generate_conform() {
config_conform_file="return {
  formatters_by_ft = {
    ${frontend_conform}${others_conform}${rust_conform}${go_conform}
  },
}"
echo "$config_conform_file" > ~/.config/nvim/lua/config/plugins/conform.lua
}

generate_lspconfig() {
config_lspconfig_file="local lspconfig = require(\"lspconfig\")

vim.lsp.inlay_hint.enable(true)${go_inlay_hint}"
echo "$config_lspconfig_file" > ~/.config/nvim/lua/config/plugins/lspconfig.lua
}

generate_treesitter() {
config_treesitter_file="require(\"nvim-treesitter.configs\").setup({
  ensure_installed = {
    ${frontend_treesitter}${others_treesitter}${rust_treesitter}${go_treesitter}
  },
  sync_install = false,
  auto_install = true,
})"
echo "$config_treesitter_file" > ~/.config/nvim/lua/config/plugins/treesitter.lua
}

generate_neotest() {
config_neotest_file="require(\"neotest\").setup({
  adapters = {
    ${js_neotest}${rust_neotest}${go_neotest}
  },
})"
echo "$config_neotest_file" > ~/.config/nvim/lua/config/plugins/neotest.lua
}

generate_lint() {
config_lint_file="local lint = require(\"lint\")

lint.linters_by_ft = {
  ${others_lint}${js_lint}${go_lint}
}

vim.api.nvim_create_autocmd({ \"BufWritePost\" }, {
  callback = function()
    lint.try_lint()
  end,
})"
echo "$config_lint_file" > ~/.config/nvim/lua/config/plugins/lint.lua
}

generate_snippets() {
mkdir -p ~/.config/nvim/snippets
snippets_package_file="{
  \"name\": \"snippets\",
  \"contributes\": {
    \"snippets\": [$go_snippets
    ]
  }
}"
echo "$snippets_package_file" > ~/.config/nvim/snippets/package.json
}

generate_dap() {
read -r -d '' config_dap_file << 'EOM'
local ok, dap = pcall(require, "dap")

if not ok then
  return
end
EOM
config_dap_file+="

${frontend_dap}${go_dap}"
echo "$config_dap_file" > ~/.config/nvim/lua/config/plugins/dap.lua
}

generate_autocmds() {
echo "$frontend_autocmds" > ~/.config/nvim/lua/config/autocmds.lua
}

generate_keymaps() {
read -r -d '' keymaps_file << 'EOM'
-- https://neovim.io/doc/user/map.html#%3Amap-verbose
-- listing a key map will also display where it was last defined
-- nvim -V1, :verbose map or :verbose map <A-Down>

local set = vim.keymap.set
local del = vim.keymap.del

-- Override keymaps
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Move Lines
del("n", "<A-j>")
set("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
del("n", "<A-k>")
set("n", "<A-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
del("i", "<A-j>")
set("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
del("i", "<A-k>")
set("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
del("v", "<A-j>")
set("v", "<A-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
del("v", "<A-k>")
set("v", "<A-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Comments
set("n", "<C-/>", "gcc", { desc = "Toggle comment line", remap = true })
set("v", "<C-/>", "gc", { desc = "Toggle comment line", remap = true })

-- floating terminal
set("n", "<C-`>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })

-- Terminal Mappings
set("t", "<C-`>", "<cmd>close<cr>", { desc = "Hide Terminal" })
set("t", "<C-x>", "<C-\\><C-n>", { desc = "Escape terminal mode", remap = true })

-- windows
del("n", "<leader>-")
set("n", "<leader>|", "<C-W>s", { desc = "Split Window Below", remap = true })
set("n", "<leader>\\", "<C-W>v", { desc = "Split Window Right", remap = true })

-- LSP
set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
set({ "n", "v" }, "<leader>ca", require("actions-preview").code_actions, { desc = "Code Action" })
set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

-- bufferline.nvim
set("n", "<S-Tab>", "<S-h>", { desc = "Prev Buffer", remap = true })
set("n", "<Tab>", "<S-l>", { desc = "Next Buffer", remap = true })

-- Neotest
set("n", "<leader>t", "", { desc = "+test" })
set("n", "<leader>tt", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run File (Neotest)" })
set("n", "<leader>tT", function()
  require("neotest").run.run(vim.uv.cwd())
end, { desc = "Run All Test Files (Neotest)" })
set("n", "<leader>tr", function()
  require("neotest").run.run()
end, { desc = "Run Nearest (Neotest)" })
set("n", "<leader>tl", function()
  require("neotest").run.run_last()
end, { desc = "Run Last (Neotest)" })
set("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Toggle Summary (Neotest)" })
set("n", "<leader>to", function()
  require("neotest").output.open({ enter = true, auto_close = true })
end, { desc = "Show Output (Neotest)" })
set("n", "<leader>tO", function()
  require("neotest").output_panel.toggle()
end, { desc = "Toggle Output Panel (Neotest)" })
set("n", "<leader>tS", function()
  require("neotest").run.stop()
end, { desc = "Stop (Neotest)" })
set("n", "<leader>tw", function()
  require("neotest").watch.toggle(vim.fn.expand("%"))
end, { desc = "Toggle Watch (Neotest)" })

-- DAP
set("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Breakpoint Condition" })
set("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
set("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Run/Continue" })
set("n", "<leader>da", function()
  require("dap").continue({ before = get_args })
end, { desc = "Run with Args" })
set("n", "<leader>dC", function()
  require("dap").run_to_cursor()
end, { desc = "Run to Cursor" })
set("n", "<leader>dg", function()
  require("dap").goto_()
end, { desc = "Go to Line (No Execute)" })
set("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step Into" })
set("n", "<leader>dj", function()
  require("dap").down()
end, { desc = "Down" })
set("n", "<leader>dk", function()
  require("dap").up()
end, { desc = "Up" })
set("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Run Last" })
set("n", "<leader>do", function()
  require("dap").step_out()
end, { desc = "Step Out" })
set("n", "<leader>dO", function()
  require("dap").step_over()
end, { desc = "Step Over" })
set("n", "<leader>dP", function()
  require("dap").pause()
end, { desc = "Pause" })
set("n", "<leader>dr", function()
  require("dap").repl.toggle()
end, { desc = "Toggle REPL" })
set("n", "<leader>ds", function()
  require("dap").session()
end, { desc = "Session" })
set("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "Terminate" })
set("n", "<leader>dw", function()
  require("dap.ui.widgets").hover()
end, { desc = "Widgets" })
set("n", "<leader>du", function()
  require("dapui").toggle({})
end, { desc = "Dap UI" })
set({ "n", "v" }, "<leader>de", function()
  require("dapui").eval()
end, { desc = "Eval" })

-- Refactoring
set({ "n", "v" }, "<leader>cR", require("refactoring").select_refactor, { desc = "Select Refactor" })

-- Splitting/joining blocks of code
set("n", "<leader>cb", "<cmd>TSJToggle<cr>", { desc = "Splitting/joining blocks of code" })

-- Zen Mode
set("n", "<leader>uz", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })

-- Timerly
set("n", "<leader>T", "<cmd>TimerlyToggle<cr>", { desc = "Toggle Timer" })

-- Markdown
if vim.fn.exists(":RenderMarkdown") > 0 then
  set("n", "<leader>m", "", { desc = "+markdown" })
  set("n", "<leader>mm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle RenderMarkdown" })
  set("n", "<leader>mt", function()
    local current_file = vim.fn.expand("%")
    os.execute("doctoc " .. current_file)
  end, { desc = "Generate Table of Contents" })
end

-- Databases
if vim.fn.exists(":DBUI") > 0 then
  set("n", "<leader>D", "<cmd>DBUIToggle<cr>", { desc = "Toggle DBUI" })
end

-- AI
if vim.fn.exists(":Codeium") > 0 then
  set("n", "<leader>a", "", { desc = "+ai" })
  set("n", "<leader>aa", "<cmd>Codeium Chat<cr>", { desc = "Open Codeium Chat in Browser" })
end
if vim.fn.exists(":CopilotChat") > 0 then
  set({ "n", "v" }, "<leader>a", "", { desc = "+ai" })
  set({ "n", "v" }, "<leader>aa", function()
    return require("CopilotChat").toggle()
  end, { desc = "Toggle (CopilotChat)" })
  set({ "n", "v" }, "<leader>ax", function()
    return require("CopilotChat").reset()
  end, { desc = "Clear (CopilotChat)" })
  set({ "n", "v" }, "<leader>aq", function()
    vim.ui.input({
      prompt = "Quick Chat: ",
    }, function(input)
      if input ~= "" then
        require("CopilotChat").ask(input)
      end
    end)
  end, { desc = "Quick Chat (CopilotChat)" })
  set({ "n", "v" }, "<leader>ap", function()
    require("CopilotChat").select_prompt()
  end, { desc = "Prompt Actions (CopilotChat)" })
  set({ "n", "v" }, "<leader>am", "<cmd>CopilotChatModels<cr>", { desc = "Select Model (CopilotChat)" })
end
EOM
echo "$keymaps_file" > ~/.config/nvim/lua/config/keymaps.lua
}

main() {
generate_frontend
generate_others
generate_rust
generate_go
generate_ai

mkdir -p ~/.config/nvim/lua/config/plugins
generate_plugins
generate_conform
generate_lspconfig
generate_treesitter
generate_neotest
generate_lint
generate_snippets
generate_dap
generate_autocmds
generate_keymaps
}

main