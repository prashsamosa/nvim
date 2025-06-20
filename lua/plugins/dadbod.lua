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

  -- Key mappings and additional setup
  config = function()
    local map = vim.keymap.set
    local opts = { desc = "" }

    -- DB UI actions
    map("n", "<leader>do", "<Cmd>DBUI<CR>",         { desc = "Open DB UI" })
    map("n", "<leader>du", "<Cmd>DBUIToggle<CR>",   { desc = "Toggle DB UI" })
    map("n", "<leader>dc", "<Cmd>DBUIClose<CR>",    { desc = "Close DB UI" })
    map("n", "<leader>dr", "<Cmd>DBUIFindBuffer<CR>", { desc = "Find DB Buffer" })
    map("n", "<leader>da", "<Cmd>DBUIAddConnection<CR>", { desc = "Add DB Connection" })
  end,
}
