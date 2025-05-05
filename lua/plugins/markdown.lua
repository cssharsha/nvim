-- ~/.config/nvim/lua/plugins/markdown.lua
return {
    -- Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_command_for_global = 0
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_open_ip = ""
            vim.g.mkdp_browser = ""
            vim.g.mkdp_echo_preview_url = 0
            vim.g.mkdp_browserfunc = ""
            vim.g.mkdp_preview_options = {
                mkit = {},
                katex = {},
                uml = {},
                maid = {},
                disable_sync_scroll = 0,
                sync_scroll_type = "middle",
                hide_yaml_meta = 1,
                sequence_diagrams = {},
                flowchart_diagrams = {},
                content_editable = false,
                disable_filename = 0,
                toc = {}
            }
            vim.g.mkdp_markdown_css = ""
            vim.g.mkdp_highlight_css = ""
            vim.g.mkdp_port = ""
            vim.g.mkdp_page_title = "${name}"
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_theme = "dark"
        end,
    },

    -- Markdown Syntax Enhancements
    {
        "preservim/vim-markdown",
        ft = { "markdown" },
        dependencies = { "godlygeek/tabular" },
        config = function()
            -- Disable folding
            vim.g.vim_markdown_folding_disabled = 1
            -- Enable TOC auto-update
            vim.g.vim_markdown_toc_autofit = 1
            -- Enable math rendering
            vim.g.vim_markdown_math = 1
            -- Enable YAML frontmatter
            vim.g.vim_markdown_frontmatter = 1
            -- Enable strikethrough
            vim.g.vim_markdown_strikethrough = 1
            -- Don't require .md extension for markdown links
            vim.g.vim_markdown_no_extensions_in_markdown = 1
            -- Auto-write when following a link
            vim.g.vim_markdown_autowrite = 1
            -- Don't conceal syntax
            vim.g.vim_markdown_conceal = 0
            vim.g.vim_markdown_conceal_code_blocks = 0
            -- Support for Obsidian-style wiki links
            vim.g.vim_markdown_wiki_link_ext = 1
        end,
    },

    -- Markdown Table Formatting
    {
        "dhruvasagar/vim-table-mode",
        cmd = { "TableModeToggle", "TableModeEnable" },
        ft = { "markdown" },
        config = function()
            vim.g.table_mode_corner = "|"
            vim.g.table_mode_corner_corner = "+"
            vim.g.table_mode_header_fillchar = "-"
        end,
    },

    -- Obsidian integration is handled in obsidian_keymaps.lua
}
