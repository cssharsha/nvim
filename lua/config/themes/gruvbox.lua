-- lua/themes/gruvbox.lua
-- Returns a list of theme variant tables for Themery
return {
    { name = "Gruvbox Dark (Hard)",  colorscheme = "gruvbox", before = [[ vim.o.background = 'dark'; vim.g.gruvbox_contrast_dark = 'hard' ]] },
    { name = "Gruvbox Light (Hard)", colorscheme = "gruvbox", before = [[ vim.o.background = 'light'; vim.g.gruvbox_contrast_light = 'hard' ]] },
}
