return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gn", "<cmd>Neogit<CR>", desc = "Open Neogit" },
  },
  opts = {
    kind = "split",
    signs = {
      section = { "", "" },
      item = { "▸", "▾" },
    },
    integrations = {
      diffview = true,
      telescope = true,
    },
    disable_commit_confirmation = true,
    disable_context_highlighting = false,
    disable_signs = false,
    telescope_sorter = function()
      return require("telescope").extensions.fzf.native_fzf_sorter()
    end,
    sections = {
      unstaged = { folded = false },
      staged = { folded = false },
    },
    -- colors = {
    --   added = "#A3BE8C",
    --   modified = "#EBCB8B",
    --   removed = "#BF616A",
    -- },
  },
}
