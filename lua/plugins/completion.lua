return {
    -- Autocompletion Engine
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- Snippet Engine & Snippet Sources
            { "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, -- Requires make
            "saadparwaiz1/cmp_luasnip",                        -- Snippets source for nvim-cmp
            "rafamadriz/friendly-snippets",                    -- Useful snippets

            -- Adds LSP completion capabilities
            "hrsh7th/cmp-nvim-lsp",

            -- Adds other completion sources
            "hrsh7th/cmp-buffer", -- Buffer completions
            "hrsh7th/cmp-path", -- Path completions
            "hrsh7th/cmp-cmdline", -- Command line completions
            "hrsh7th/cmp-nvim-lua", -- Lua Neovim API completions

            -- Adds vscode-like pictograms
            "onsails/lspkind.nvim",
        },
        config = function()
            require("config.completion")
        end,
    },
}
