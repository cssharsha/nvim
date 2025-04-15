-- ~/.config/nvim/lua/plugins/lsp.lua
return {
    -- *** Central Mason Setup ***
    -- This block configures Mason itself and lists ALL tools to install.
    {
        "williamboman/mason.nvim",
        lazy = false, -- Load Mason early, before other plugins need its tools
        config = function()
            require("mason").setup({
                ui = { border = "rounded" },
                -- Define ALL tools needed by Mason here
                ensure_installed = {
                    -- LSPs (can still be listed here, mason-lspconfig will also ensure them)
                    "clangd",
                    "pyright",
                    "lua_ls",
                    -- -- DAPs (add any others needed by your dap.lua)
                    -- "cppdbg",
                    -- "debugpy",
                    -- Linters (add any others needed by your lint.lua)
                    "ruff",
                    "cpplint",
                    "luacheck",
                    "shellcheck",
                    -- Formatters (add any others needed by your conform.lua)
                    "stylua",
                    "clang-format",
                    "black",
                    "isort",
                    -- Add other tools like typescript-language-server, eslint_d, prettier if you use them
                },
            })
        end,
    },

    -- Mason-LSPconfig bridge (depends on mason)
    -- Connects Mason installations to nvim-lspconfig
    { "williamboman/mason-lspconfig.nvim", dependencies = { "mason.nvim" } },

    -- Mason-DAP bridge (depends on mason)
    -- Connects Mason installations to nvim-dap
    -- {
    --     "jay-babu/mason-nvim-dap.nvim",
    --     dependencies = { "mason.nvim" },
    --     opts = { automatic_installation = false }, -- Let the central mason config handle installs
    -- },

    -- LSP Configuration Manager (depends on mason bridges)
    -- Configures the actual LSPs after they are installed
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason.nvim",                       -- Explicit dependency is good practice
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} }, -- LSP status notifications
            { "folke/neodev.nvim", opts = {} }, -- Extra features for lua dev
        },
        config = function()
            -- Defer the LSP server setup to config/lsp.lua
            require("config.lsp")
            -- Note: config/lsp.lua uses mason-lspconfig to set up servers.
            -- The ensure_installed list there primarily applies to LSPs.
            -- The list in mason.setup above ensures ALL tool types are installed.
        end,
    },
}
