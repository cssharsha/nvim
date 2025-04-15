-- ~/.config/nvim/lua/config/conform.lua
local conform = require("conform")

conform.setup({
    -- Map filetypes to formatters
    formatters_by_ft = {
        lua = { "stylua" },
        python = function(bufnr)
            -- Use ruff format if a ruff config file exists, otherwise use isort + black
            if vim.fs.find({ "ruff.toml", "pyproject.toml" }, { upward = true })[1] then
                return { "ruff_format" }
            else
                return { "isort", "black" }
            end
        end,
        c = { "clang-format" },
        cpp = { "clang-format" },
        -- Add more formatters as needed
        -- javascript = { "prettier" },
        -- typescript = { "prettier" },
        -- html = { "prettier" },
        -- css = { "prettier" },
        -- json = { "prettier" },
        -- yaml = { "prettier" },
        -- markdown = { "prettier" },
    },

    -- Options for formatters
    formatters = {
        stylua = { args = { "--config-path", vim.fn.stdpath("config") .. "/stylua.toml" } }, -- Example custom args
        ["clang-format"] = {
            -- Check standard locations for .clang-format or _clang-format files
            -- Uses the default clang-format binary found in PATH
            -- You can specify args or prepend_args if needed
        },
        black = {},
        isort = {},
        ruff_format = {},
        -- prettier = {
        --   args = { "--config-path", vim.fn.stdpath("config") .. "/prettierrc.json" }, -- Example
        -- }
    },

    -- Set up format-on-save
    format_on_save = {
        timeout_ms = 500,    -- Max time to wait for formatter
        lsp_fallback = true, -- Fallback to LSP formatting if conform fails
    },

    -- Optional: setup a keymap to format manually
    -- vim.keymap.set({ "n", "v" }, "<leader>lf", function()
    --   conform.format({ async = true, lsp_fallback = true })
    -- end, { desc = "Format buffer" })
})

-- Ensure required formatters are installed via Mason
-- require("mason").setup({})                                                      -- Ensure mason is setup if not done elsewhere
-- require("mason-registry").update()                                              -- Update registry in case it's stale
--
-- local ensure_installed = { "stylua", "clang-format", "black", "isort", "ruff" } -- Add prettier etc. if needed
-- vim.notify("Ensuring formatters are installed: " .. table.concat(ensure_installed, ", "))
-- require("mason.api.core.install").ensure_installed(ensure_installed)

print("Conform config loaded")
