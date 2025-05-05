-- ~/.config/nvim/lua/config/obsidian_keymaps.lua
-- Obsidian-specific keymaps and integrations with markdown plugins

-- Wait until Obsidian is loaded
vim.api.nvim_create_autocmd("User", {
    pattern = "ObsidianLoaded",
    callback = function()
        -- Set up keymaps specifically for markdown files
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
                -- Preview current note with markdown-preview
                vim.keymap.set("n", "<leader>op", function()
                    vim.cmd("MarkdownPreviewToggle")
                end, { buffer = true, desc = "Toggle Markdown Preview" })
                
                -- Format tables
                vim.keymap.set("n", "<leader>ot", function()
                    vim.cmd("TableModeToggle")
                end, { buffer = true, desc = "Toggle Table Mode" })
                
                -- Obsidian-specific keymaps
                vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { buffer = true, desc = "New Obsidian Note" })
                vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { buffer = true, desc = "Open in Obsidian" })
                vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { buffer = true, desc = "Search Obsidian Notes" })
                vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { buffer = true, desc = "Show Backlinks" })
                vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianFollowLink<CR>", { buffer = true, desc = "Follow Link" })
                vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { buffer = true, desc = "Open Today's Note" })
                vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<CR>", { buffer = true, desc = "Open Yesterday's Note" })
                vim.keymap.set("n", "<leader>om", "<cmd>ObsidianTomorrow<CR>", { buffer = true, desc = "Open Tomorrow's Note" })
                
                -- Toggle checkbox
                vim.keymap.set("n", "<leader>ox", function()
                    local obsidian = require("obsidian")
                    return obsidian.util.toggle_checkbox()
                end, { buffer = true, desc = "Toggle Checkbox" })
                
                -- Follow link under cursor
                vim.keymap.set("n", "<leader>of", function()
                    local obsidian = require("obsidian")
                    return obsidian.util.gf_passthrough()
                end, { buffer = true, expr = true, desc = "Follow Link Under Cursor" })
            end,
        })
    end,
})

print("Obsidian keymaps loaded")
