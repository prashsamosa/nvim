return {
  'akinsho/toggleterm.nvim', -- The plugin specification: name of the GitHub repository.
  version = "*",             -- Use the latest stable version of the plugin.
  opts = {                  -- Configuration options for toggleterm.nvim.
      open_mapping = [[<c-\>]], -- Key mapping to open/close the terminal window (Ctrl+\).
      direction = 'float',     -- Open the terminal in a floating window.
      float_opts = {          -- Options for the floating terminal window.
          border = 'curved',   -- Use a curved border for the floating window.
      },
  }
}