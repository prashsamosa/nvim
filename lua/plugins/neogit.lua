return {
  "NeogitOrg/neogit", -- Feature-rich Git client within Neovim.
  dependencies = {
      "nvim-lua/plenary.nvim",     -- Lua utility library.
      "sindrets/diffview.nvim",     -- Powerful diff viewer used by neogit.
      "nvim-telescope/telescope.nvim", -- Fuzzy finder framework used by neogit.
  },
  config = true, -- Automatically load neogit's default configuration.
  -- To customize neogit, you would replace `true` with a configuration function:
  -- config = function()
  --   require('neogit').setup({
  --     -- Your custom configuration options here
  --   })
  -- end,
  -- For example, to change the default mappings or enable specific features.
  -- See `:h neogit.txt` for available configuration options.
}