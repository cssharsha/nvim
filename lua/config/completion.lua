-- ~/.config/nvim/lua/config/completion.lua
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- Load snippets
require("luasnip.loaders.from_vscode").lazy_load()
-- Load custom snippets (optional)
-- require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })

luasnip.config.setup({})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    -- Keybindings for completion
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- Select next item
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- Select previous item
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),                                        -- Scroll backward in documentation
        ["<C-f>"] = cmp.mapping.scroll_docs(4),                                         -- Scroll forward in documentation
        ["<C-Space>"] = cmp.mapping.complete(),                                         -- Trigger completion
        ["<C-e>"] = cmp.mapping.abort(),                                                -- Abort completion
        ["<CR>"] = cmp.mapping.confirm({ select = true }),                              -- Confirm selection

        -- Snippet navigation
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }), -- i = insert mode, s = select mode
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    -- Completion sources
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "nvim_lua" }, -- Source for Neovim Lua API
    }),
    -- Formatting with lspkind icons
    formatting = {
        format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
                -- Get the kind icon and text for the completion item
                vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
                return vim_item
            end,
        }),
    },
    -- Command line completion
    cmdline = {
        ["/"] = { -- Search command line
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "buffer" },
            }),
        },
        [":"] = { -- Command line
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
                { name = "cmdline" },
            }),
        },
    },
})

print("Nvim-cmp config loaded")
