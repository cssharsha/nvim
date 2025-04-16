-- lua/plugins/catppuccin.lua
-- Returns the plugin specification for the Catppuccin theme plugin
return {
    "catppuccin/nvim",
    name = "catppuccin", -- Used by Themery's 'colorscheme' field
    lazy = false,        -- Or true if you prefer, Themery dependency might handle it
    priority = 1000,     -- Load before Themery config runs
    config = function()
        -- Configure the Catppuccin plugin itself (integrations, etc.)
        require("catppuccin").setup({
            -- flavour = "mocha", -- Optional default flavour
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                -- Add other integrations
            },
        })
        -- DO NOT call vim.cmd('colorscheme catppuccin') here
    end,
}
