-- lua/themes/tokyonight.lua
-- Defines Tokyonight variants for Themery

return {
    {
        name = "Tokyonight Night",
        colorscheme = "tokyonight-night",
        before = [[ vim.g.tokyonight_style = "night" ]],
    },
    {
        name = "Tokyonight Storm",
        colorscheme = "tokyonight-storm",
        before = [[ vim.g.tokyonight_style = "storm" ]],
    },
    {
        name = "Tokyonight Day",
        colorscheme = "tokyonight-day",
        before = [[ vim.g.tokyonight_style = "day" ]],
    },
    {
        name = "Tokyonight Moon",
        colorscheme = "tokyonight-moon",
        before = [[ vim.g.tokyonight_style = "moon" ]],
    },
}
