-- Configure 'oil.nvim': A modern and customizable file explorer, intended as a replacement for netrw.

return {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true, -- Use oil.nvim instead of netrw when opening directories.
      float = {                     -- Configuration for the floating oil.nvim window.
        padding = 2,               -- Padding around the floating window.
        max_width = 100,           -- Maximum width of the floating window.
        max_height = 30,           -- Maximum height of the floating window.
        border = "rounded",        -- Rounded borders for the floating window.
        win_options = {             -- Window options for the floating window.
          winblend = 0,            -- Make the floating window fully opaque.
        },
      },
      view_options = {
        show_hidden = true,      -- Show hidden files and directories.
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional: File icons.
    config = function(_, opts)
      require("oil").setup(opts) -- Setup oil.nvim with the provided options.
  
      -- Keymap to open oil.nvim in a floating window.
      vim.keymap.set("n", "-", function()
        require("oil").open_float() -- Open oil.nvim in a floating window.
      end, { desc = "Open Oil File Manager (float)", silent = true })
    end,
  }