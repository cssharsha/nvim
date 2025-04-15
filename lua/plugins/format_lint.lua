-- ~/.config/nvim/lua/plugins/format_lint.lua
return {
  -- Formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- Run formatter before saving
    cmd = { "ConformInfo" },
    dependencies = { "mason.nvim" }, -- To install formatters
    config = function()
      require("config.conform")
    end,
  },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" }, -- Lint on save, load, and leaving insert mode
    dependencies = { "mason.nvim" }, -- To install linters
    config = function()
      require("config.lint")
    end,
  },
}
