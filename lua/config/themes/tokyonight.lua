-- lua/themes/tokyonight.lua
-- Defines Tokyonight variants for Themery

return {
    {
        name = "Tokyonight Night",
        colorscheme = "tokyonight-night",
        globalbefore = [[ vim.g.tokyonight_style = "night" ]],
    },
    {
        name = "Tokyonight Storm",
        colorscheme = "tokyonight-storm",
        globalbefore = [[ vim.g.tokyonight_style = "storm" ]],
    },
    {
        name = "Tokyonight Day",
        colorscheme = "tokyonight-day",
        globalbefore = [[ vim.g.tokyonight_style = "day" ]],
    },
    {
        name = "Tokyonight Moon",
        colorscheme = "tokyonight-moon",
        globalbefore = [[ vim.g.tokyonight_style = "moon" ]],
    },
}
