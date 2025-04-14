-- Configure 'vim-dadbod-ui' for database interaction within Neovim.
-- This plugin provides a UI for managing database connections and running queries.

return {
    "kristijanhusak/vim-dadbod-ui", -- Plugin specification.
    dependencies = {
        { "tpope/vim-dadbod", lazy = true }, -- Core database connectivity, lazy-loaded.
        {
            "kristijanhusak/vim-dadbod-completion",
            ft = { "sql", "mysql", "plsql" }, -- Autocompletion for SQL-like filetypes, lazy-loaded.
            lazy = true,
        },
    },
    cmd = { -- Neovim commands provided by the plugin.
        "DBUI",              -- Open the main Dadbod UI.
        "DBUIToggle",        -- Toggle the Dadbod UI window.
        "DBUIAddConnection", -- Add a new database connection.
        "DBUIFindBuffer",    -- Find a buffer associated with a connection.
    },
    init = function()
        -- Configuration
        vim.g.db_ui_use_nerd_fonts = 1 -- Use Nerd Fonts for improved UI icons.
    end,
}