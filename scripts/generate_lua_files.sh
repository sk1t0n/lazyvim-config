read -p "Install Rust plugins? (y/n): " need_rust
if [[ "$need_rust" == "y" || "$need_rust" == "Y" ]]; then
    rust_plugins="
    {
        'mrcjkb/rustaceanvim',
        version = '^6',
        lazy = false,
    },"
    rust_conform="
        rust = { 'rustfmt' },"
    rust_neotest="
        require 'rustaceanvim.neotest' {
            args = {},
        },"
else
    rust_plugins=""
    rust_conform=""
    rust_neotest=""
fi

plugins_init_file="return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            require 'config.plugins.lspconfig'
        end,
    },
    {
        'stevearc/conform.nvim',
        event = 'BufWritePre',
        opts = require 'config.plugins.conform',
    },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()
            require 'config.plugins.neotest'
        end,
    },$rust_plugins
}"
echo "$plugins_init_file" > ~/.config/nvim/lua/plugins/init.lua

mkdir -p ~/.config/nvim/lua/config/plugins

config_conform_file="local options = {
    formatters_by_ft = {$rust_conform
    },

    format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
    },
}

return options"
echo "$config_conform_file" > ~/.config/nvim/lua/config/plugins/conform.lua

config_lspconfig_file="local servers = {
}

local lspconfig = require 'lspconfig'

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
    }
end

vim.lsp.inlay_hint.enable(true)"
echo "$config_lspconfig_file" > ~/.config/nvim/lua/config/plugins/lspconfig.lua

config_neotest_file="require('neotest').setup {
    adapters = {$rust_neotest
    }
}"
echo "$config_neotest_file" > ~/.config/nvim/lua/config/plugins/neotest.lua
