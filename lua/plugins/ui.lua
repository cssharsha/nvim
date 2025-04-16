-- ~/.config/nvim/lua/plugins/ui.lua

return {
    -- == Themes ==
    -- Load individual theme plugin specifications
    require("plugins.themes.catppuccin"),
    require("plugins.themes.gruvbox"), -- Example
    -- require("plugins.your_other_theme"),

    -- == Theme Manager ==
    {
        "zaldih/themery.nvim",
        -- Dependencies ensure themes are loaded before Themery's config runs
        dependencies = {
            "catppuccin/nvim",
            "gruvbox-community/gruvbox", -- Example
            -- Add other theme plugin sources here corresponding to plugins required above
        },
        priority = 1001, -- Ensure it loads after themes but config runs later
        -- The config function now simply calls the dedicated setup function
        config = function()
            require("config.themery").setup()
        end,
    },
    -- Status Line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                    -- section_separators = { left = '', right = '' },
                    -- component_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                -- Add other sections and components as needed
            })
        end,
    },

    -- File Explorer
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false, -- Important: Load immediately for tmux integration
        keys = {
            { "<C-n>", function() require("nvim-tree.api").tree.toggle() end, desc = "Toggle NvimTree" },
            { "<C-e>", function() require("nvim-tree.api").tree.focus() end,  desc = "Focus NvimTree" },
        },
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        opts = {
            git = {
                enable = true,
            },
            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        git = true,
                    },
                },
            },
            view = {
                side = "left",
                width = 30,
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                    window_picker = {
                        enable = true,
                    },
                },
            },
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")
                local opts = { noremap = true, silent = true }

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- File operations
                vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
                vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
                vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
                vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
                vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
                vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))

                -- Existing custom mappings
                vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
                vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
                vim.keymap.set('n', 'sv', api.node.open.vertical, opts('Open: Vertical Split'))
                vim.keymap.set('n', 'sh', api.node.open.horizontal, opts('Open: Horizontal Split'))
                vim.keymap.set('n', 'st', api.node.open.tab, opts('Open: New Tab'))

                -- These are now defined globally in the keys section above
                -- vim.keymap.set('n', '<C-n>', api.tree.toggle, opts('Toggle tree'))
                -- vim.keymap.set('n', '<C-e>', api.tree.focus, opts('Toggle tree'))
            end,
        },
    },

    -- Buffer Line (Tabs)
    {
        "akinsho/bufferline.nvim",
        version = "*", -- Or latest tag
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "tabs",             -- Use actual Vim tabs
                    separator_style = "slant", -- Or 'arrow', 'padded_slant', etc.
                    diagnostics = "nvim_lsp",  -- Show LSP diagnostics
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
                },
            })
        end,
    },

    -- Keymap Helper (shows available keymaps)
    {
        "folke/which-key.nvim",
        event = "VeryLazy", -- Load when needed
        config = function()
            require("which-key").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end
    },

    -- Icons
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- Indent Lines Visualization
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            -- options
            scope = { enabled = true },
        },
    },
}
