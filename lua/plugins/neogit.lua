-- Configure Neogit: A Git interface within Neovim.

return {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",     -- Required: Lua utility library.
      "sindrets/diffview.nvim",    -- Optional: Enhanced diff viewing.
      "nvim-telescope/telescope.nvim", -- Optional: Fuzzy finding within Neogit.
    },
    cmd = "Neogit", -- Load only when the `Neogit` command is executed.
    keys = {
      { "<leader>gn", "<cmd>Neogit<CR>", desc = "Open Neogit" }, -- Keybinding to open Neogit.
    },
    opts = {
      kind = "split", -- Open Neogit in a split window ("split", "tab", "float").
      signs = {
        section = { "", "" }, -- No signs for section headers.
        item = { "▸", "▾" }, -- Collapsed/expanded states for items.
      },
      integrations = {
        diffview = true,  -- Enable diffview.nvim integration.
        telescope = true, -- Enable telescope.nvim integration.
      },
      disable_commit_confirmation = true, -- Skip commit confirmation prompts.
      disable_context_highlighting = false, -- Keep context highlighting in diff views.
      disable_signs = false,                -- Ensure signs are displayed.
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter() -- Use the faster native FZF sorter in Telescope.
      end,
      sections = {
        unstaged = { folded = false }, -- Unfold "Unstaged changes" by default.
        staged = { folded = false },   -- Unfold "Staged changes" by default.
      },
      -- Uncomment and customize colors if needed.
      -- colors = {
      --   added = "#A3BE8C",
      --   modified = "#EBCB8B",
      --   removed = "#BF616A",
      -- },
    },
  }