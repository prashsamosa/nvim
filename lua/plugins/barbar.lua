return {
  "romgrk/barbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
  },
  lazy = true,
  event = "BufReadPost",

  init = function()
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map("n", "<A-,>", "<cmd>BufferPrevious<cr>", opts)
    map("n", "<A-.>", "<cmd>BufferNext<cr>", opts)
    map("n", "<A-S-,>", "<cmd>BufferMovePrevious<cr>", opts)
    map("n", "<A-S-.>", "<cmd>BufferMoveNext<cr>", opts)

    for i = 1, 9 do
      map("n", ("<A-%d>"):format(i), ("<cmd>BufferGoto %d<cr>"):format(i), opts)
    end
    map("n", "<A-0>", "<cmd>BufferLast<cr>", opts)

    map("n", "<A-p>", "<cmd>BufferPin<cr>", opts)
    map("n", "<leader>bO", "<cmd>BufferCloseAllButCurrentOrPinned<cr>", opts)
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
        added = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },
      inactive = {
        filetype = { enabled = false },
      },
    },
  },
}
