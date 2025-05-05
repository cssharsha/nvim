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
        "lewis6991/gitsigns.nvim",                     -- Git signs in the sign column
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
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = false,  -- Ensure it loads regardless of filetype
        -- ft = "markdown", -- Removed to ensure it loads regardless of filetype
        dependencies = {
            -- Required dependencies
            "nvim-lua/plenary.nvim",
            -- Optional, for completion
            "hrsh7th/nvim-cmp",
            -- Optional, for search
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("config.obsidian")
        end,
        -- Add commands to ensure the plugin is loaded
        cmd = {
            "ObsidianOpen",
            "ObsidianNew",
            "ObsidianSearch",
            "ObsidianFollowLink",
            "ObsidianBacklinks",
            "ObsidianToday",
            "ObsidianYesterday",
            "ObsidianTomorrow",
        },
    },
    {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        opts = {
            processor = "magick_cli",
        },
    }
}
