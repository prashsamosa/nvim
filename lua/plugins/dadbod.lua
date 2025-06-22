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

  -- Lazy-load only when needed
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },

  -- Nerd font support for icons
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,

  config = function()
    local map = vim.keymap.set

    -- Database UI keybindings (using <leader>D prefix to avoid conflicts with debug)
    map("n", "<leader>Do", "<Cmd>DBUI<CR>",              { desc = "Open DB UI" })
    map("n", "<leader>Du", "<Cmd>DBUIToggle<CR>",        { desc = "Toggle DB UI" })
    map("n", "<leader>DCc", "<Cmd>DBUIClose<CR>",         { desc = "Close DB UI" })
    map("n", "<leader>Dr", "<Cmd>DBUIFindBuffer<CR>",    { desc = "Find DB Buffer" })
    map("n", "<leader>Da", "<Cmd>DBUIAddConnection<CR>", { desc = "Add DB Connection" })
  end,
}
