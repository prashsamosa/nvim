return {
  "folke/which-key.nvim", -- The plugin specification: name of the GitHub repository.
  event = "VeryLazy",      -- Load this plugin lazily, only when needed, to improve startup time.
  init = function()        -- Initialization function that runs when the plugin is loaded.
      vim.o.timeout = true     -- Enable timeout for key sequences.
      vim.o.timeoutlen = 500   -- Set the timeout length for key sequences to 500 milliseconds.
                               -- This determines how long Neovim waits for subsequent keys
                               -- in a multi-key mapping.
  end,
  opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      -- This 'opts' table is where you would put any custom configuration
      -- for the 'which-key.nvim' plugin. If you leave it empty, it will
      -- use its default settings. To customize it, you would refer to
      -- the plugin's documentation for available options.
  },
}