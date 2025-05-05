-- ~/.config/nvim/lua/config/telescope.lua
local telescope = require("telescope")
local actions = require("telescope.actions")
local themes = require("telescope.themes")

telescope.setup({
    defaults = {
        path_display = { "truncate" },
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,                       -- move to prev result
                ["<C-j>"] = actions.move_selection_next,                           -- move to next result
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                ["<C-u>"] = false,                                                 -- clear prompt (default)
                ["<C-d>"] = false,                                                 -- delete (default)
                ["<C-c>"] = actions.close,                                         -- close telescope
                ["<C-n>"] = actions.cycle_history_next,                            -- next history item
                ["<C-p>"] = actions.cycle_history_prev,                            -- prev history item
            },
        },
        sorting_strategy = "ascending", -- display results top->bottom
        layout_config = {
            prompt_position = "top",    -- prompt at the top
            width = 0.8,
            height = 0.8,
            preview_cutoff = 120,
        },
    },
    pickers = {
        -- Default configuration for specific pickers
        commands = {
            theme = "dropdown",
            layout_config = {
                width = 0.7,
                height = 0.6,
            },
            sorting_strategy = "ascending",
        },
        command_history = {
            theme = "dropdown",
            layout_config = {
                width = 0.6,
                height = 0.5,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
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

-- Command pickers
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Find Commands" })
map("n", "<leader>fC", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
map("n", "<leader>f:", "<cmd>Telescope commands<cr>", { desc = "Find Commands" })
-- VS Code style command palette with Ctrl+Shift+P
map({ "n", "i" }, "<C-S-p>", "<cmd>Telescope commands<cr>", { desc = "Command Palette (VS Code style)" })
-- Alternative to command mode with :
map("n", ":", "<cmd>Telescope commands<cr>", { desc = "Command Palette (replace :)" })

-- LSP specific searches
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
map("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace Symbols" })
map("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP References" })
map("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>", { desc = "LSP Implementations" })
map("n", "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", { desc = "LSP Definitions" })

-- Additional useful pickers
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find Keymaps" })
map("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find Marks" })
map("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Find Jumplist" })
map("n", "<leader>ft", "<cmd>Telescope treesitter<cr>", { desc = "Find Treesitter Symbols" })
map("n", "<leader>fv", "<cmd>Telescope vim_options<cr>", { desc = "Find Vim Options" })
map("n", "<leader>fR", "<cmd>Telescope registers<cr>", { desc = "Find Registers" })

-- Create a custom picker for Vim commands
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Function to create a custom command picker with built-in Vim commands
local vim_commands_picker = function(opts)
  opts = opts or {}
  
  -- Common Vim commands to include
  local vim_commands = {
    { name = "w", desc = "Save current buffer" },
    { name = "w!", desc = "Save current buffer forcefully" },
    { name = "q", desc = "Quit current window" },
    { name = "q!", desc = "Quit current window forcefully" },
    { name = "wq", desc = "Save and quit" },
    { name = "wa", desc = "Save all buffers" },
    { name = "wall", desc = "Save all buffers" },
    { name = "qa", desc = "Quit all windows" },
    { name = "qall", desc = "Quit all windows" },
    { name = "wqa", desc = "Save all buffers and quit" },
    { name = "wqall", desc = "Save all buffers and quit" },
    { name = "e", desc = "Edit a file" },
    { name = "edit", desc = "Edit a file" },
    { name = "bn", desc = "Go to next buffer" },
    { name = "bnext", desc = "Go to next buffer" },
    { name = "bp", desc = "Go to previous buffer" },
    { name = "bprevious", desc = "Go to previous buffer" },
    { name = "bd", desc = "Delete current buffer" },
    { name = "bdelete", desc = "Delete current buffer" },
    { name = "sp", desc = "Split window horizontally" },
    { name = "split", desc = "Split window horizontally" },
    { name = "vs", desc = "Split window vertically" },
    { name = "vsplit", desc = "Split window vertically" },
    { name = "tabnew", desc = "Create new tab" },
    { name = "tabn", desc = "Go to next tab" },
    { name = "tabnext", desc = "Go to next tab" },
    { name = "tabp", desc = "Go to previous tab" },
    { name = "tabprevious", desc = "Go to previous tab" },
    { name = "tabc", desc = "Close current tab" },
    { name = "tabclose", desc = "Close current tab" },
    { name = "h", desc = "Open help" },
    { name = "help", desc = "Open help" },
    { name = "noh", desc = "Clear search highlighting" },
    { name = "nohlsearch", desc = "Clear search highlighting" },
    { name = "set number", desc = "Show line numbers" },
    { name = "set nonumber", desc = "Hide line numbers" },
    { name = "set wrap", desc = "Enable line wrapping" },
    { name = "set nowrap", desc = "Disable line wrapping" },
  }
  
  -- Create the picker
  pickers.new(opts, {
    prompt_title = "Vim Commands",
    finder = finders.new_table {
      results = vim_commands,
      entry_maker = function(entry)
        return {
          value = entry.name,
          display = entry.name .. " - " .. entry.desc,
          ordinal = entry.name .. " " .. entry.desc,
        }
      end,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        
        -- Execute the selected command
        vim.cmd(selection.value)
      end)
      return true
    end,
  }):find()
end

-- Add keybinding for the vim commands picker
map("n", "<leader>fV", vim_commands_picker, { desc = "Vim Built-in Commands" })

print("Telescope config loaded")
