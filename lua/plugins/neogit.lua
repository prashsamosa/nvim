return {
  "NeogitOrg/neogit", -- The plugin specification: name of the GitHub repository.
  dependencies = { -- List of other plugins that neogit depends on.
      "nvim-lua/plenary.nvim",     -- A Lua utility library for Neovim.
      "sindrets/diffview.nvim",    -- A powerful diff viewer for Neovim, used by neogit.
      "nvim-telescope/telescope.nvim", -- A fuzzy finder framework for Neovim, used by neogit.
  },
  config = true, -- When set to `true`, this tells lazy.nvim to automatically
                 -- call the `config` function of the plugin if it exists.
                 -- In this case, neogit likely provides a default configuration
                 -- that will be loaded. If you needed custom configuration, you
                 -- would typically define a function here like:
                 --
                 -- config = function()
                 --   require('neogit').setup({
                 --     -- Your custom configuration options here
                 --   })
                 -- end,
                 --
                 -- However, since it's just `true`, it implies using neogit's
                 -- default settings.
}