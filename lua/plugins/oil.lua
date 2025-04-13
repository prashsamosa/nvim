return {
  "stevearc/oil.nvim", -- The plugin specification: name of the GitHub repository.
  opts = { -- Configuration options for oil.nvim.
      default_file_explorer = true, -- Use oil as the default file explorer when
                                   -- opening directories (e.g., with `:edit .`).
      float = { -- Configuration for the floating window mode of oil.
          padding = 2,      -- Padding around the floating window.
          max_width = 100,  -- Maximum width of the floating window.
          max_height = 30, -- Maximum height of the floating window.
          border = "rounded", -- Border style for the floating window.
          win_options = { -- Window options for the floating window.
              winblend = 0, -- Transparency level of the floating window (0 is opaque).
          },
      },
      view_options = { -- Options for the oil view.
          show_hidden = true, -- Show hidden files and directories (dotfiles).
      },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional dependency for file icons.
  config = function(_, opts) -- Configuration function that runs when the plugin is loaded.
      require("oil").setup(opts) -- Call the setup function of oil.nvim with the provided options.

      -- Set a keymap to open oil in a floating window.
      vim.keymap.set("n", "-", function()
          require("oil").open_float() -- Open the oil file manager in a floating window.
      end, { desc = "Open Oil File Manager (float)", silent = true })
  end,
}