-- lua/plugins/themes/solarized.lua
-- Plugin specification for the Solarized theme

return {
    "ishan9299/nvim-solarized-lua",
    name = "solarized", -- Matches Themery's 'colorscheme'
    lazy = false,
    priority = 1000,
    config = function()
        -- Solarized theme configuration options
        -- These can be overridden by Themery's before hooks
        vim.g.solarized_italics = 1
        vim.g.solarized_visibility = 'normal'
        vim.g.solarized_diffmode = 'normal'
        vim.g.solarized_statusline = 'normal'
        -- Do not set colorscheme here!
    end,
}
