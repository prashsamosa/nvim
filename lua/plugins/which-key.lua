return {
  "folke/which-key.nvim", -- Plugin: which-key.nvim (for keybinding hints)
  event = "VeryLazy",       -- Load lazily (on demand)

  init = function()
    -- Initialization function
    vim.o.timeout = true       -- Enable key sequence timeouts
    vim.o.timeoutlen = 500    -- Timeout length in milliseconds (ms)
    --  This sets how long Neovim waits for subsequent keys
    --  in a multi-key mapping.
  end,

  opts = {
    -- Configuration options
    --  This table is where you would add custom configuration
    --  for the 'which-key.nvim' plugin.  If you leave it empty,
    --  it will use its default settings.  Refer to the plugin's
    --  documentation for available options.
  },
}
