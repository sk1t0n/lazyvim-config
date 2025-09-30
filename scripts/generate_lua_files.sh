read -p "Install Rust plugins? (y/n): " need_rust
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
    rust_conform='rust = { "rustfmt" },'
    rust_neotest='require("rustaceanvim.neotest")({
      args = {},
    }),'
    rust_treesitter='"rust",'
else
    rust_plugins=""
    rust_conform=""
    rust_neotest=""
    rust_treesitter=""
fi

read -p "Install Go plugins? (y/n): " need_go
if [[ "$need_go" == "y" || "$need_go" == "Y" ]]; then
    go_plugins='
  {
    "fredrikaverpil/neotest-golang",
    version = "*",
    build = function()
      vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
    end,
  },'
    go_conform='go = { "gofmt", "goimports", "golines" },'
    go_lsp='"gopls",
  "golangci_lint_ls",'
    go_inlay_hint="lspconfig.gopls.setup({
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
    go_neotest='require("neotest-golang")({
      runner = "gotestsum",
    }),'
    go_treesitter='"go",
  "gomod",
  "gosum",
  "gotmpl",
  "gowork",'
    treesitter_gotmpl_injections='((text) @injection.content
 (#set! injection.language "html")
 (#set! injection.combined))'
    mkdir -p ~/.config/nvim/queries/gotmpl
    echo "$treesitter_gotmpl_injections" > ~/.config/nvim/queries/gotmpl/injections.scm
    go_lint='go = { "golangcilint" },'
    go_snippets='{
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
else
    go_plugins=""
    go_conform=""
    go_lsp=""
    go_inlay_hint=""
    go_neotest=""
    go_treesitter=""
    go_lint=""
    go_snippets=""
fi

read -r -d '' plugins_init_file << 'EOM'
return {
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
EOM
plugins_init_file+="${rust_plugins}${go_plugins}
}"
echo "$plugins_init_file" > ~/.config/nvim/lua/plugins/init.lua

mkdir -p ~/.config/nvim/lua/config/plugins

config_conform_file="local options = {
  formatters_by_ft = {
    $rust_conform
    $go_conform
  },
}

return options"
echo "$config_conform_file" > ~/.config/nvim/lua/config/plugins/conform.lua

config_lspconfig_file="local servers = {
  $go_lsp
}

local lspconfig = require(\"lspconfig\")

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  })
end

vim.lsp.inlay_hint.enable(true)

$go_inlay_hint"

echo "$config_lspconfig_file" > ~/.config/nvim/lua/config/plugins/lspconfig.lua

config_neotest_file="require(\"neotest\").setup({
  adapters = {
    $rust_neotest
    $go_neotest
  },
})"
echo "$config_neotest_file" > ~/.config/nvim/lua/config/plugins/neotest.lua

config_treesitter_file="require(\"nvim-treesitter\").install({
  $rust_treesitter
  $go_treesitter
})"
echo "$config_treesitter_file" > ~/.config/nvim/lua/config/plugins/treesitter.lua

config_lint_file="local lint = require(\"lint\")

lint.linters_by_ft = {
  $go_lint
}

vim.api.nvim_create_autocmd({ \"BufWritePost\" }, {
  callback = function()
    lint.try_lint()
  end,
})"
echo "$config_lint_file" > ~/.config/nvim/lua/config/plugins/lint.lua

mkdir -p ~/.config/nvim/snippets

snippets_package_file="{
  \"name\": \"snippets\",
  \"contributes\": {
    \"snippets\": [
      $go_snippets
    ]
  }
}"
echo "$snippets_package_file" > ~/.config/nvim/snippets/package.json

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

-- windows
del("n", "<leader>-")
set("n", "<leader>|", "<C-W>s", { desc = "Split Window Below", remap = true })
set("n", "<leader>\\", "<C-W>v", { desc = "Split Window Right", remap = true })

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
EOM
echo "$keymaps_file" > ~/.config/nvim/lua/config/keymaps.lua
