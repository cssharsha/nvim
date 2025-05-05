-- ~/.config/nvim/lua/core/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- Import plugin specifications from the plugins directory
        { import = "plugins.ui" },
        { import = "plugins.lsp" },
        { import = "plugins.completion" },
        { import = "plugins.treesitter" },
        { import = "plugins.format_lint" },
        { import = "plugins.ai" },
        { import = "plugins.dap" },
        { import = "plugins.utils" },
        { import = "plugins.markdown" },
        -- Add any other plugin spec files here
    },
    -- Configure lazy.nvim options
    install = { colorscheme = { "catppuccin" } }, -- Automatically set colorscheme after install
    checker = { enabled = true, notify = false }, -- Check for updates daily
    change_detection = { notify = false },        -- Don't notify on config changes
    performance = {
        rtp = {
            disabled_plugins = { -- List built-in plugins you don't use
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

require("config.markdown")
print("Lazy.nvim setup complete") -- For debugging
