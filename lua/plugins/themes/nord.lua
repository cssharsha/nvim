-- lua/plugins/nord.lua
-- Plugin specification for the Nord theme

return {
    "shaunsingh/nord.nvim", -- Lua version
    -- or "arcticicestudio/nord-vim" for the Vimscript version
    name = "nord",          -- Matches Themery's 'colorscheme'
    lazy = false,
    priority = 1000,
    config = function()
        -- Configure Nord if needed (check plugin docs for options)
        -- require('nord').setup({ }) -- If using shaunsingh/nord.nvim and it has a setup function
        -- vim.g.nord_bold = false -- Example Vimscript option if using arcticicestudio/nord-vim
        -- Do not set colorscheme here!
    end,
}
