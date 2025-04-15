-- ~/.config/nvim/lua/config/telescope.lua
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    path_display = { "truncate" },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
  },
  pickers = {
    -- Default configuration for specific pickers
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    -- file_browser = { ... } -- if using the file browser extension
  },
})

-- Load extensions
pcall(telescope.load_extension, "fzf")
-- pcall(telescope.load_extension, "file_browser")

-- Telescope Keymaps
local map = vim.keymap.set
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Fuzzy Find in Buffer" })
map("n", "<leader>fr", "<cmd>Telescope resume<cr>", { desc = "Resume Last Search" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Show Diagnostics" })

-- LSP specific searches
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
map("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace Symbols" })
map("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP References" })
map("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP Implementations" })
map("n", "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", { desc = "LSP Definitions" })

print("Telescope config loaded")
