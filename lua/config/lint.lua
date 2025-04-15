-- ~/.config/nvim/lua/config/lint.lua
local lint = require("lint")

lint.linters_by_ft = {
  python = { "ruff" }, -- Or {'flake8'}, {'pylint'}
  c = { "cpplint" },   -- Or {'clang-tidy'}
  cpp = { "cpplint" }, -- Or {'clang-tidy'}
  lua = { "luacheck" },
  bash = { "shellcheck" },
  -- Add more linters
  -- javascript = {'eslint_d'},
  -- typescript = {'eslint_d'},
}

-- Configure nvim-lint autocmds
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})

-- Optional: Keymap to trigger linting manually
-- vim.keymap.set('n', '<leader>ll', function()
--   lint.try_lint()
-- end, { desc = 'Trigger linting' })

-- Ensure required linters are installed via Mason
require("mason").setup({})
require("mason-registry").update()

-- local ensure_installed = { "ruff", "cpplint", "luacheck", "shellcheck" } -- Add eslint_d, clang-tidy etc. if needed
-- vim.notify("Ensuring linters are installed: " .. table.concat(ensure_installed, ", "))
-- require("mason.api.core.install").ensure_installed(ensure_installed)


print("Nvim-lint config loaded")
