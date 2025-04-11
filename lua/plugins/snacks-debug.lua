-- lua/plugins/snacks-debug.lua
return {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {
      debug = {
        -- you can customize behavior here if needed
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
  
      -- 🍿 Debug helpers
      _G.dd = function(...)
        require("snacks.debug").inspect(...)
      end
  
      _G.bt = function()
        require("snacks.debug").backtrace()
      end
  
      vim.print = _G.dd
    end,
  }
  