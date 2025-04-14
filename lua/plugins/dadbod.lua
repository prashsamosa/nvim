-- Configure 'vim-dadbod-ui' for database interaction within Neovim.
-- This plugin provides a UI for managing database connections and running queries.

return {
    "kristijanhusak/vim-dadbod-ui", -- Plugin specification on GitHub.
    dependencies = {
        { "tpope/vim-dadbod", lazy = true }, -- Core database connectivity plugin by tpope, loaded only when needed.
        {
            "kristijanhusak/vim-dadbod-completion",
            ft = { "sql", "mysql", "plsql" }, -- Autocompletion for SQL and related filetypes.
            lazy = true,                     -- Loaded only when editing SQL-like files.
        },
    },
    cmd = { -- Neovim commands provided by the vim-dadbod-ui plugin.
        "DBUI",              -- Open the main Dadbod UI window.
        "DBUIToggle",        -- Toggle the visibility of the Dadbod UI window.
        "DBUIAddConnection", -- Command to add a new database connection through the UI.
        "DBUIFindBuffer",    -- Find a Neovim buffer associated with a specific database connection.
    },
    init = function()
        -- Global configuration settings for vim-dadbod-ui.
        vim.g.db_ui_use_nerd_fonts = 1 -- Enable the use of Nerd Fonts for potentially better-looking icons in the UI.
    end,
    config = function()
        -- Set up keybindings for the plugin
        vim.keymap.set("n", "<leader>du", "<Cmd>DBUIToggle<CR>", { desc = "Toggle DB UI" })
        vim.keymap.set("n", "<leader>dr", "<Cmd>DBUIFindBuffer<CR>", { desc = "Find DB buffer" })
    end,
    -- No explicit `config` function was needed initially as the plugin is primarily driven by commands and global variables.
}
