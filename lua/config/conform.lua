local M = {}

M.setup = function()
  local conform = require("conform")

  conform.setup({
    -- Map filetypes to formatters
    formatters_by_ft = {
      lua = { "stylua" },
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
      stylua = {}, -- Use default settings
      ["clang-format"] = {
        -- Check standard locations for .clang-format or _clang-format files
        -- Uses the default clang-format binary found in PATH
        -- You can specify args or prepend_args if needed
      },
    },

    -- Set up format-on-save
    format_on_save = {
      timeout_ms = 500, -- Max time to wait for formatter
      lsp_fallback = true, -- Fallback to LSP formatting if conform fails
    },
  })

  -- Optional: setup a keymap to format manually
  -- vim.keymap.set({ "n", "v" }, "<leader>lf", function()
  --   conform.format({ async = true, lsp_fallback = true })
  -- end, { desc = "Format buffer" })

  print("Conform config loaded")
end

return M