return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
        opts = require("config.ai_ollama").opts,
        disabled_tools = { "python" },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick",         -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua",              -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua",        -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                    -- Customize rendering options to work with Obsidian
                    render_options = {
                        -- Properly handle Obsidian-style wiki links
                        wiki_link_pattern = "%[%[(.-)%]%]",
                        wiki_link_replacement = function(text)
                            return "🔗 " .. text
                        end,
                        -- Handle Obsidian callouts
                        callout_pattern = "> %[!(%w+)%]",
                        callout_replacement = function(callout_type)
                            local icons = {
                                note = "📝",
                                info = "ℹ️",
                                tip = "💡",
                                warning = "⚠️",
                                danger = "🚨",
                                question = "❓",
                                example = "📋",
                                quote = "💬",
                                summary = "📌",
                                success = "✅",
                                failure = "❌",
                                bug = "🐛",
                                todo = "📌",
                            }
                            return icons[string.lower(callout_type)] or "📌"
                        end,
                    },
                },
                ft = { "markdown", "Avante" },
            },
        }
    }
}
