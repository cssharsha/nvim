-- lua/plugins/tokyonight.lua
-- Plugin specification for the Tokyonight theme

return {
    "folke/tokyonight.nvim",
    name = "tokyonight", -- Matches Themery's 'colorscheme'
    lazy = false,
    priority = 1000,
    opts = {
        -- -- style = "storm", -- Or night, day, moon - Optional default style
        -- transparent = false,    -- Enable this to disable background color
        -- terminal_colors = true, -- Configure terminal colors
        -- styles = {
        --     -- Style to be applied to different syntax groups
        --     comments = { italic = true },
        --     keywords = { italic = true },
        --     -- Background styles. Can be "dark", "transparent" or "normal"
        --     sidebars = "dark", -- style for sidebars, see below
        --     floats = "dark",   -- style for floating windows
        -- },
        -- -- Add other Tokyonight options here
    },
    config = function(_, opts)
        -- Apply the options passed in 'opts'
        require("tokyonight").setup(opts)
        -- Do not set colorscheme here!
    end,
}
