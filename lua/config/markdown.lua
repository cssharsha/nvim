-- ~/.config/nvim/lua/config/markdown.lua
-- Markdown-specific settings

-- Set up markdown filetype detection
vim.filetype.add({
    extension = {
        md = "markdown",
        markdown = "markdown",
        mdown = "markdown",
        mkd = "markdown",
        mkdn = "markdown",
    },
})

-- Markdown-specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        -- Enable spell checking
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"

        -- Set wrap for markdown files
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true

        -- Don't auto-indent when pressing o or O
        vim.opt_local.autoindent = false
        vim.opt_local.smartindent = false

        -- Set conceallevel to 0 to show all syntax
        vim.opt_local.conceallevel = 0

        -- Set textwidth for automatic formatting
        vim.opt_local.textwidth = 80

        -- Enable auto-formatting of paragraphs
        vim.opt_local.formatoptions:append("a")

        -- Disable automatic comment insertion
        vim.opt_local.formatoptions:remove("c")
        vim.opt_local.formatoptions:remove("r")
        vim.opt_local.formatoptions:remove("o")

        -- Set tab settings
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
    end,
})

-- Add markdown-specific keymaps
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        -- Headings
        vim.keymap.set("n", "<leader>m1", "^i# <Esc>", { buffer = true, desc = "Heading 1" })
        vim.keymap.set("n", "<leader>m2", "^i## <Esc>", { buffer = true, desc = "Heading 2" })
        vim.keymap.set("n", "<leader>m3", "^i### <Esc>", { buffer = true, desc = "Heading 3" })
        vim.keymap.set("n", "<leader>m4", "^i#### <Esc>", { buffer = true, desc = "Heading 4" })
        vim.keymap.set("n", "<leader>m5", "^i##### <Esc>", { buffer = true, desc = "Heading 5" })

        -- Formatting
        vim.keymap.set("v", "<leader>mb", "c**<C-r>\"**<Esc>", { buffer = true, desc = "Bold" })
        vim.keymap.set("v", "<leader>mi", "c*<C-r>\"*<Esc>", { buffer = true, desc = "Italic" })
        vim.keymap.set("v", "<leader>mc", "c`<C-r>\"`<Esc>", { buffer = true, desc = "Code" })
        vim.keymap.set("v", "<leader>ml", "c[<C-r>\"]()<Esc>h", { buffer = true, desc = "Link" })

        -- Lists
        vim.keymap.set("n", "<leader>mu", "^i- <Esc>", { buffer = true, desc = "Unordered List Item" })
        vim.keymap.set("n", "<leader>mo", "^i1. <Esc>", { buffer = true, desc = "Ordered List Item" })
        vim.keymap.set("n", "<leader>mt", "^i- [ ] <Esc>", { buffer = true, desc = "Task Item" })

        -- Preview
        vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { buffer = true, desc = "Toggle Preview" })

        -- Table mode
        vim.keymap.set("n", "<leader>mT", "<cmd>TableModeToggle<CR>", { buffer = true, desc = "Toggle Table Mode" })
    end,
})

require("quarto").activate()

print("Markdown config loaded")
