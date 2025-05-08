-- Configure 'vim-dadbod-ui' for database interaction within Neovim.
-- This plugin provides a UI for managing database connections and running queries.

return {
  "kristijanhusak/vim-dadbod-ui",        -- Plugin specification on GitHub.
  dependencies = {
    { "tpope/vim-dadbod", lazy = true }, -- Core database connectivity plugin by tpope (lazy-loaded).
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql" }, -- Autocompletion for SQL, MySQL, and PL/SQL filetypes (lazy-loaded).
      lazy = true,
    },
  },
  cmd = {                -- Neovim commands provided by vim-dadbod-ui:
    "DBUI",              -- Open the main Dadbod UI window.
    "DBUIToggle",        -- Toggle the visibility of the Dadbod UI window.
    "DBUIAddConnection", -- Add a new database connection through the UI.
    "DBUIFindBuffer",    -- Find a Neovim buffer associated with a database connection.
  },
  init = function()
    -- Global configuration settings for vim-dadbod-ui.
    vim.g.db_ui_use_nerd_fonts = 1 -- Enable Nerd Fonts for icons in the Dadbod UI.
  end,
  config = function()
    -- Keybindings for vim-dadbod-ui
    vim.keymap.set("n", "<leader>du", "<Cmd>DBUIToggle<CR>", { desc = "Toggle DB UI" })             -- Toggle Dadbod UI
    vim.keymap.set("n", "<leader>dr", "<Cmd>DBUIFindBuffer<CR>", { desc = "Find DB buffer" })       -- Find associated DB buffer
    vim.keymap.set("n", "<leader>da", "<Cmd>DBUIAddConnection<CR>", { desc = "Add DB Connection" }) -- Add a new DB connection
    vim.keymap.set("n", "<leader>dc", "<Cmd>DBUIClose<CR>", { desc = "Close DB UI" })               -- Close the DB UI window
    vim.keymap.set("n", "<leader>do", "<Cmd>DBUI<CR>", { desc = "Open DB UI" })                     -- Open the DB UI window
  end,
}
