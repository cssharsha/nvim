return {
    {
        name = "VSCode Dark",
        colorscheme = "vscode",
        globalbefore = [[ require('vscode').setup({style = 'dark'}) ]],
    },
    {
        name = "VSCode Light",
        colorscheme = "vscode",
        globalbefore = [[ require('vscode').setup({style = 'light'}) ]],
    },
}