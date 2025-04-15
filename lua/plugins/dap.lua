-- ~/.config/nvim/lua/plugins/dap.lua
return {
  -- Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Installs DAP servers
      { "jay-babu/mason-nvim-dap.nvim", dependencies = "mason.nvim" },

      -- UI for DAP
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },

      -- Virtual text for variable values
      { "theHamsta/nvim-dap-virtual-text", opts = {} },

      -- Python specific DAP configuration helper
      { "mfussenegger/nvim-dap-python", dependencies = "nvim-dap" },
    },
    config = function()
      require("config.dap")
    end,
  },
}
