return {
    "nvim-lualine/lualine.nvim", -- Lualine is a statusline plugin
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- For the file icons in the statusline.
      "catppuccin/nvim"         -- Catppuccin theme.
    },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin" -- Use the catppuccin theme.
        }
      })
    end
  }
  