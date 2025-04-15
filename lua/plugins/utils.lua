-- ~/.config/nvim/lua/plugins/utils.lua
return {
    -- Fuzzy Finder (Telescope)
    {
        "nvim-telescope/telescope.nvim",
        -- cmd = "Telescope",
        version = "*", -- Or latest release tag
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- Optional: Preview dependencies
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            -- Optional: File browser integration
            -- "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            require("config.telescope")
        end,
    },

    -- Commenting plugin
    { "numToStr/Comment.nvim", opts = {} },

    -- Git integration
    { "tpope/vim-fugitive",    cmd = { "Git", "G" } }, -- Essential Git commands
    {
        "lewis6991/gitsigns.nvim",                -- Git signs in the sign column
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                -- Configuration options...
                signs = {
                    add = { text = "▎" },
                    change = { text = "▎" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
            })
        end,
    },
}
