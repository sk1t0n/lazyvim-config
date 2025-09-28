read -p "Install Rust plugins? (y/n): " need_rust
if [[ "$need_rust" == "y" || "$need_rust" == "Y" ]]; then
    rust_plugins='
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
  },'
    rust_conform='
    rust = { "rustfmt" },'
    rust_neotest='
    require("rustaceanvim.neotest")({
      args = {},
    }),'
else
    rust_plugins=""
    rust_conform=""
    rust_neotest=""
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
EOM
plugins_init_file+="$rust_plugins
}"
echo "$plugins_init_file" > ~/.config/nvim/lua/plugins/init.lua

mkdir -p ~/.config/nvim/lua/config/plugins

config_conform_file="local options = {
  formatters_by_ft = {$rust_conform
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = \"fallback\",
  },
}

return options"
echo "$config_conform_file" > ~/.config/nvim/lua/config/plugins/conform.lua

config_lspconfig_file='local servers = {
}

local lspconfig = require "lspconfig"

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  }
end

vim.lsp.inlay_hint.enable(true)'
echo "$config_lspconfig_file" > ~/.config/nvim/lua/config/plugins/lspconfig.lua

config_neotest_file="require(\"neotest\").setup({
  adapters = {$rust_neotest
  },
})"
echo "$config_neotest_file" > ~/.config/nvim/lua/config/plugins/neotest.lua

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
EOM
echo "$keymaps_file" > ~/.config/nvim/lua/config/keymaps.lua
