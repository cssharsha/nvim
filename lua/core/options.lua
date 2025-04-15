-- ~/.config/nvim/lua/core/options.lua
local opt = vim.opt -- Use local variable for options

-- Line Numbers
opt.relativenumber = true -- Show relative line numbers
opt.number = true         -- Shows absolute line number on cursor line

-- Tabs & Indentation
opt.tabstop = 4        -- 4 spaces for tabs (prettier default)
opt.shiftwidth = 4     -- 4 spaces for autoindent
opt.expandtab = true   -- Use spaces instead of tabs
opt.autoindent = true  -- Indent new lines automatically

-- Search Settings
opt.ignorecase = true  -- Ignore case when searching
opt.smartcase = true   -- Overrides ignorecase if search pattern contains uppercase letters

-- Appearance
opt.termguicolors = true -- Enable true color support
opt.background = "dark" -- Or "light" depending on your theme
opt.signcolumn = "yes"  -- Always show the sign column

-- Behavior
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.mouse = "a"           -- Enable mouse support in all modes
opt.splitright = true     -- Open vertical splits to the right
opt.splitbelow = true     -- Open horizontal splits below
opt.wrap = false          -- Disable line wrapping

-- Performance
opt.updatetime = 250 -- Decrease update time
opt.timeoutlen = 300 -- Time to wait for key sequence (leader keys)

-- Backup/Swap files
opt.swapfile = false
opt.backup = false

-- Define the desired path for the undo directory
local undo_path = vim.fn.stdpath("data") .. "/undodir"

-- Set Neovim's actual 'undodir' option using the path string
opt.undodir = undo_path

-- Enable persistent undo
opt.undofile = true

-- Ensure the undo directory exists
-- Check if the directory exists first
if vim.fn.isdirectory(undo_path) == 0 then
  -- Directory does not exist, try to create it
  print("Attempting to create undo directory:", undo_path) -- Optional: Keep for one more test run
  vim.fn.mkdir(undo_path, "p")
end
