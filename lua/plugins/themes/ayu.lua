return {
    "ayu-theme/ayu-vim",
    name = "ayu",    -- This name is used by lazy.nvim
    lazy = false,    -- Load it on startup so Themery can find it
    priority = 1000, -- Ensure it loads before Themery config
    -- No specific 'config' function is typically needed here for a Vimscript colorscheme,
    -- as settings like the ayu variant (dark, light, mirage) will be handled
    -- by Themery's 'before' hook.
}
