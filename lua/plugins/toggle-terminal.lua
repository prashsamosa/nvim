return {
  'akinsho/toggleterm.nvim', -- Plugin: Toggleable terminal windows
  version = "*", -- Use latest stable version
  opts = {
    -- Configuration
    open_mapping = [[<c-\>]], -- Keybinding to toggle the terminal (Ctrl+\)
    direction = 'float',       -- Open as a floating window
    float_opts = {
      -- Floating window options
      border = 'curved',     -- Use curved borders
    },
  },
}
