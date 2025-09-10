-- lua/plugins/themes/melange.lua
-- Plugin specification for the Melange theme

return {
    "savq/melange-nvim",
    name = "melange", -- Matches Themery's 'colorscheme'
    lazy = false,
    priority = 1000,
    config = function()
        -- Melange doesn't require setup function
        -- Light/dark mode is controlled by vim.o.background
        -- Do not set colorscheme here!
    end,
}
