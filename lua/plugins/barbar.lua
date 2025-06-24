-- Bufferline configuration using barbar.nvim
return {
  "romgrk/barbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
  },
  lazy = false, -- Consider setting to true and adding an event like "VeryLazy" if startup perf matters

  init = function()
    vim.g.barbar_auto_setup = false

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Navigation
    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
    map("n", "<A-S-,>", "<Cmd>BufferMovePrevious<CR>", opts)
    map("n", "<A-S-.>", "<Cmd>BufferMoveNext<CR>", opts)

    -- Jump to buffer 1–9, 0 = last
    for i = 1, 9 do
      map("n", ("<A-%d>"):format(i), ("<Cmd>BufferGoto %d<CR>"):format(i), opts)
    end
    map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

    -- Tab-like operations (visual/UI focused)
    map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
    map("n", "<leader>bC", "<Cmd>BufferClose<CR>", opts)
    map("n", "<leader>bO", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", opts)
  end,

  opts = {
    auto_hide = true,
    clickable = true,
    insert_at_end = true,
    icons = {
      buffer_index = true,
      button = "×",
      filetype = {
        enabled = true,
        custom_colors = false,
      },
      separator = {
        left = "▎",
        right = "",
      },
      gitsigns = {
        added   = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },
      inactive = {
        filetype = { enabled = false },
      },
    },
  },
}
