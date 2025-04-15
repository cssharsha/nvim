-- ~/.config/nvim/lua/core/keymaps.lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key to Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic Neovim navigation and editing improvements
-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move selected lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selected line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selected line up" })

-- Keep cursor centered when moving half pages
-- Adding some stuff to make sure
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Keep cursor centered when searching
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Terminal Mode Navigation
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Enter Normal mode from Terminal" })
map("t", "jk", "<C-\\><C-n>", { desc = "Enter Normal mode from Terminal" }) -- quick escape

-- Clear search highlighting
map("n", "<leader>ch", ":noh<CR>", { desc = "Clear Search Highlight" })

-- Easier window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- Resize windows
map("n", "<leader>=", "<C-w>=", { desc = "Resize windows equally" })
map("n", "<leader>-", "<C-w>-", { desc = "Decrease window height" })
map("n", "<leader>+", "<C-w>+", { desc = "Increase window height" })
map("n", "<leader><", "<C-w><", { desc = "Decrease window width" })
map("n", "<leader>>", "<C-w>>", { desc = "Increase window width" })

-- Buffer Navigation
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close current buffer" })

print("Core keymaps loaded") -- For debugging
