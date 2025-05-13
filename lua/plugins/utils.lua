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
        'jmbuhr/otter.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {},
    },
    {
        "quarto-dev/quarto-nvim",
        ft = { "quarto", "markdown" },
        dependencies = {
            "jmbuhr/otter.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("config.quarto")
        end
    },
    {
        "GCBallesteros/jupytext.nvim",
        opts = {
            style = "hydrogen",
            output_extension = "auto", -- Default extension. Don't change unless you know what you are doing
            force_ft = nil,            -- Default filetype. Don't change unless you know what you are doing
            custom_language_formatting = {},
        },
        -- Depending on your nvim distro or config you may need to make the loading not lazy
        -- lazy=false,
    },
    {
        "benlubas/molten-nvim",
        lazy = false,
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- these are examples, not defaults. Please see the readme
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
        end,
        keys = {
            { "<localleader>mi", ":MoltenInit<CR>",                  mode = "n", desc = "Initialize the plugin" },
            { "<localleader>mo", ":MoltenEvaluateOperator<CR>",      mode = "n", desc = "run operator selection" },
            { "<localleader>ml", ":MoltenEvaluateLine<CR>",          mode = "n", desc = "evaluate line" },
            { "<localleader>mr", ":MoltenReevaluateCell<CR>",        mode = "n", desc = "re-evaluate cell" },
            { "<localleader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", mode = "v", desc = "evaluate visual selection" },
        },
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { "magick" },
        },
    },
    {
        "3rd/image.nvim",
        version = "1.1.0",
        -- build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        opts = {
            -- processor = "magick_cli",
        },
        config = function()
            require('image').setup({
                integrations = {
                    markdown = {
                        resolve_image_path = function(document_path, image_path, fallback)
                            -- document_path is the path to the file that contains the image
                            -- image_path is the potentially relative path to the image. for
                            -- markdown it's `![](this text)`

                            -- you can call the fallback function to get the default behavior
                            return fallback(document_path, image_path)
                        end,
                    }
                },
                backend = "kitty",                        -- Kitty will provide the best experience, but you need a compatible terminal
                max_width = 100,                          -- tweak to preference
                max_height = 12,                          -- ^
                max_height_window_percentage = math.huge, -- this is necessary for a good experience
                max_width_window_percentage = math.huge,
                window_overlap_clear_enabled = true,
                window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            })
        end
    }
}
