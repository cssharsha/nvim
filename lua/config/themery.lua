-- lua/plugins/themery.lua
-- Contains the configuration logic for themery.nvim

-- Define a local module table
local M = {}

-- Helper function to load and aggregate theme variants
local function aggregate_theme_variants()
    -- Define which theme definition modules to load from lua/themes/
    local theme_definition_modules = {
        "config.themes.catppuccin",
        "config.themes.gruvbox",
        -- Add "themes.your_other_theme" here
    }

    local all_variants = {}
    for _, module_name in ipairs(theme_definition_modules) do
        local ok, variants = pcall(require, module_name)
        if ok and type(variants) == "table" then
            for _, variant in ipairs(variants) do
                table.insert(all_variants, variant)
            end
        else
            vim.notify("Failed to load theme definitions from: " .. module_name, vim.log.levels.WARN)
        end
    end
    return all_variants
end

-- The main setup function to be called by the plugin manager's config
M.setup = function()
    -- Ensure the themery plugin is available before setting it up
    local themery_ok, themery = pcall(require, "themery")
    if not themery_ok then
        vim.notify("Themery plugin not found. Cannot configure.", vim.log.levels.ERROR)
        return
    end

    -- Get the aggregated list of theme variants
    local theme_variants = aggregate_theme_variants()

    -- Configure Themery
    themery.setup({
        themes = theme_variants,
        livePreview = true,
        -- Add other themery options if needed
    })

    -- Add keybinding for Themery
    vim.keymap.set("n", "<leader>th", ":Themery<CR>", { desc = "Theme Selector", silent = true })

    -- Optional: Apply a default theme via Themery on startup
    -- This is generally better than setting vim.cmd('colorscheme') directly,
    -- as it uses Themery's 'before' hooks correctly.
    -- Replace "Catppuccin Mocha" with your desired default name from the variants list.
    -- pcall(vim.cmd, 'Themery Catppuccin Mocha')
end

-- Return the module table
return M
