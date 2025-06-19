-- Database UI with vim-dadbod-ui
return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql" },
      lazy = true,
    },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
  config = function()
    local map = vim.keymap.set
    map("n", "<leader>du", "<Cmd>DBUIToggle<CR>", { desc = "Toggle DB UI" })
    map("n", "<leader>dr", "<Cmd>DBUIFindBuffer<CR>", { desc = "Find DB buffer" })
    map("n", "<leader>da", "<Cmd>DBUIAddConnection<CR>", { desc = "Add DB Connection" })
    map("n", "<leader>dc", "<Cmd>DBUIClose<CR>", { desc = "Close DB UI" })
    map("n", "<leader>do", "<Cmd>DBUI<CR>", { desc = "Open DB UI" })
  end,
}
