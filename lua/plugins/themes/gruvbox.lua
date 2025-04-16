-- lua/plugins/gruvbox.lua
-- Returns the plugin specification for the Gruvbox theme plugin
return {
    "gruvbox-community/gruvbox",
    name = "gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
        -- Configure Gruvbox itself if needed
        -- vim.g.gruvbox_italic = true
        -- DO NOT call vim.cmd('colorscheme gruvbox') here
    end,
}
