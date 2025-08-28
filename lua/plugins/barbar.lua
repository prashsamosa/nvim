return {
  "romgrk/barbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
  event = "BufReadPost",

  init = function()
    vim.g.barbar_auto_setup = false
    -- Quick buffer navigation
    for i = 1, 9 do
      vim.keymap.set("n", ("<A-%d>"):format(i), ("<cmd>BufferGoto %d<cr>"):format(i))
    end
    vim.keymap.set("n", "<A-0>", "<cmd>BufferLast<cr>")
  end,

  keys = {
    { "<A-,>",      "<cmd>BufferPrevious<cr>",                   desc = "Previous buffer" },
    { "<A-.>",      "<cmd>BufferNext<cr>",                       desc = "Next buffer" },
    { "<A-c>",      "<cmd>BufferClose<cr>",                      desc = "Close buffer" },
    { "<A-p>",      "<cmd>BufferPin<cr>",                        desc = "Pin buffer" },
    { "<leader>bo", "<cmd>BufferCloseAllButCurrentOrPinned<cr>", desc = "Close others" },
  },

  opts = {
    animation = true,
    auto_hide = false,
    clickable = true,
    insert_at_end = true,
    maximum_padding = 1,
    icons = {
      buffer_index = true,
      button = "×",
      filetype = { enabled = true },
      separator = { left = "▎", right = "" },
      gitsigns = {
        added = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },
    },
  },
}
