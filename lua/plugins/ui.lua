-- ~/.config/nvim/lua/plugins/ui.lua

return {
    -- == Themes ==
    -- Load individual theme plugin specifications
    require("plugins.themes.catppuccin"),
    require("plugins.themes.gruvbox"),
    require("plugins.themes.tokyonight"),
    require("plugins.themes.nord"),
    require("plugins.themes.kanagawa"),
    require("plugins.themes.ayu"),
    {
        "folke/zen-mode.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            { "<localleader>z", ":ZenMode<CR>", mode = "n", desc = "Zenmode" }
        }
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            })
        end
    },
    -- == Theme Manager ==
    {
        "zaldih/themery.nvim",
        -- Dependencies ensure themes are loaded before Themery's config runs
        dependencies = {
            "catppuccin/nvim",
            "gruvbox-community/gruvbox",
            -- "folke/tokyonight",
            -- "shaunsingh/nord",
            -- "rebelot/kanagawa",
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
                    theme = "everforest",
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
            update_focused_file = {
                enable = true,
                update_root = false, -- Optional: set to true if you want the tree root to change to the file's directory
            },
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

    -- Searchbox - Floating search UI
    {
        "VonHeikemen/searchbox.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim"
        },
        config = function()
            local searchbox = require("searchbox")

            -- Key mappings for Searchbox
            local map = vim.keymap.set
            local opts = { noremap = true, silent = true }

            -- Basic search
            map("n", "<leader>s", function() searchbox.match_all() end,
                { desc = "Search in buffer", unpack(opts) })

            -- Search and replace
            map("n", "<leader>r", function() searchbox.replace() end,
                { desc = "Search and replace", unpack(opts) })

            -- Search word under cursor
            map("n", "<leader>sw", function() searchbox.match_all({ default_text = vim.fn.expand("<cword>") }) end,
                { desc = "Search word under cursor", unpack(opts) })

            -- Search in selection (visual mode)
            map("v", "<leader>s", function() searchbox.match_all({ visual_mode = true }) end,
                { desc = "Search in selection", unpack(opts) })

            -- Replace in selection (visual mode)
            map("v", "<leader>r", function() searchbox.replace({ visual_mode = true }) end,
                { desc = "Replace in selection", unpack(opts) })

            -- Search with regex
            map("n", "<leader>sr", function() searchbox.match_all({ regex = true }) end,
                { desc = "Search with regex", unpack(opts) })

            -- Replace with regex
            map("n", "<leader>rr", function() searchbox.replace({ regex = true }) end,
                { desc = "Replace with regex", unpack(opts) })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter", -- Load plugin when entering insert mode
        opts = {
            -- Configure options here if needed, e.g.:
            -- check_ts = true, -- Enable treesitter integration (recommended)
            -- ts_config = {
            --   lua = {'string'},
            --   javascript = {'template_string'},
            --   java = false, -- Turn off for java
            -- }
            -- For default options, just `opts = {}` or omit `opts` works too
        },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            -- Optional: If you use nvim-cmp, configure autopairs integration
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end,
    },
}
