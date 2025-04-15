-- ~/.config/nvim/lua/config/lsp.lua
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local map = vim.keymap.set
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Setup language servers.
local servers = {
  clangd = {}, -- C/C++
  pyright = {}, -- Python
  lua_ls = { -- Lua language server configuration
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
  -- Add other servers here, e.g.:
  -- tsserver = {}, -- Typescript
  -- gopls = {}, -- Go
  -- rust_analyzer = {}, -- Rust
  -- bashls = {}, -- Bash
}

-- Global LSP settings and keymaps
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- LSP Keymaps (using <leader>l prefix)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  map("n", "gD", vim.lsp.buf.declaration, opts)             -- Go to Declaration
  map("n", "gd", vim.lsp.buf.definition, opts)             -- Go to Definition
  map("n", "K", vim.lsp.buf.hover, opts)                   -- Show Hover Documentation
  map("n", "gi", vim.lsp.buf.implementation, opts)         -- Go to Implementation
  map("n", "<C-k>", vim.lsp.buf.signature_help, opts)      -- Show Signature Help
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts) -- Add Workspace Folder
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts) -- Remove Workspace Folder
  map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts) -- List Workspace Folders
  map("n", "<leader>D", vim.lsp.buf.type_definition, opts) -- Go to Type Definition
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)          -- Rename Symbol
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- Code Action
  map("n", "gr", vim.lsp.buf.references, opts)             -- Show References
  map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts) -- Format Code (Fallback, prefer conform.nvim)

  -- Diagnostics Keymaps (using <leader>d prefix)
  map("n", "[d", vim.diagnostic.goto_prev, opts)           -- Go to Previous Diagnostic
  map("n", "]d", vim.diagnostic.goto_next, opts)           -- Go to Next Diagnostic
  map("n", "<leader>de", vim.diagnostic.open_float, opts)  -- Show Diagnostic in Float
  map("n", "<leader>dq", vim.diagnostic.setloclist, opts) -- Add Diagnostics to Location List

  -- Set other LSP options based on client capabilities
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.format({ bufnr = bufnr, async = true }) end,
    })
  end
end

-- nvim-cmp capabilities
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Ensure Mason LSPs are installed
mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

-- Configure each LSP server
mason_lspconfig.setup_handlers({
  function(server_name) -- Default handler
    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
  ["lua_ls"] = function() -- Custom handler for lua_ls
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = servers.lua_ls.settings,
    })
  end,
  -- Add custom handlers for other servers if needed
})

-- Configure LSP diagnostics appearance
vim.diagnostic.config({
  virtual_text = true, -- Show diagnostics inline
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Diagnostic signs
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

print("LSP config loaded")
