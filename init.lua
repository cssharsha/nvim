-- ~/.config/nvim/init.lua

-- Load core configurations first
require("core.options")
require("core.keymaps")               -- Load keymaps before plugins
require("core.lazy")                  -- Load lazy.nvim and plugins
require("core.theme")                 -- Load theme configuration

print("Neovim configuration loaded!") -- For debugging
