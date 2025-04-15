-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Required command to install/update parsers
    event = { "BufReadPost", "BufNewFile" }, -- Load Treesitter when opening files
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- Additional text objects
    },
    config = function()
      require("config.treesitter")
    end,
  },
}
