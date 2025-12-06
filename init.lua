-- ~/.config/nvim/init.lua
--
-- Load core configurations first
require("core.options")
require("core.keymaps") -- Load keymaps before plugins
require("core.lazy") -- Load lazy.nvim and plugins
-- Sync C/C++ indent with nearest .clang-format
require("config.clangfmt_indent").setup()

print("Neovim configuration loaded!") -- For debugging
