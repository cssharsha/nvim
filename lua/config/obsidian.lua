local obsidian = require("obsidian")

obsidian.setup({
    workspaces = {
        {
            -- Always modify when going to a new vault
            name = "Notes",
            path = "~/Documents/Notes/Notes",
        }
    },
    -- Specify the exact path to ripgrep executable
    finder = "telescope.nvim",
    search = {
        -- Use the full path to ripgrep
        command = "/opt/homebrew/bin/rg",
        args = {
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
    },
    -- Markdown compatibility settings
    ui = {
        enable = true,
        update_debounce = 200,
        -- Highlight Obsidian-specific syntax
        highlight_text = true,
        -- Don't override markdown syntax highlighting
        highlight_markdown = false,
        -- Highlight wiki links
        highlight_wiki_links = true,
    },
    -- Ensure compatibility with markdown plugins
    disable_frontmatter = false,
    -- Markdown features
    wiki_link_func = function(opts)
        if opts.id == nil then
            return string.format("[[%s]]", opts.label)
        elseif opts.label ~= opts.id then
            return string.format("[[%s|%s]]", opts.id, opts.label)
        else
            return string.format("[[%s]]", opts.id)
        end
    end,
    -- Completion settings
    completion = {
        nvim_cmp = true,
        min_chars = 2,
        new_notes_location = "current_dir",
        prepend_note_id = true,
    },
    mappings = {
        ["<leader>of"] = {
            action = function()
                return obsidian.util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>od"] = {
            action = function()
                return obsidian.util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
    },
    note_frontmatter_func = function(note)
        local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = "", project = "" }

        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
                out[k] = v
            end
        end
        return out
    end,
    templates = {
        subdir = "Templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
        tags = "",
    },
})

-- Load Obsidian keymaps
pcall(require, "config.obsidian_keymaps")

-- Emit event that Obsidian is loaded
vim.defer_fn(function()
    vim.api.nvim_exec_autocmds("User", { pattern = "ObsidianLoaded" })
end, 100)

print("Obsidian config loaded")
