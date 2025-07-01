return {
    {
        name = "Ayu Dark",
        colorscheme = "ayu", -- This is the command Themery will use (vim.cmd('colorscheme ayu'))
        globalbefore = [[ vim.g.ayucolor = "dark" ]],
        globalafter = [[ vim.g.ayucolor = "dark" ]],
    },
    {
        name = "Ayu Light",
        colorscheme = "ayu",
        globalbefore = [[ vim.g.ayucolor = "light" ]],
        globalafter = [[ vim.g.ayucolor = "light" ]],
    },
    {
        name = "Ayu Mirage",
        colorscheme = "ayu",
        globalbefore = [[ vim.g.ayucolor = "mirage" ]],
        globalafter = [[ vim.g.ayucolor = "mirage" ]],
    },
}
