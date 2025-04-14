-- Configure 'which-key.nvim' for displaying keybinding hints in a popup.

return {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load lazily.
  
    init = function()
      -- Timeout options for multi-key mappings.
      vim.o.timeout = true
      vim.o.timeoutlen = 500 -- Wait 500ms for next key.
    end,
  
    opts = {
      -- Custom configuration can go here.
      -- Empty table uses default settings.
    },
  }