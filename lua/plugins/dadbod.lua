-- This file configures the 'vim-dadbod-ui' plugin for Neovim, which provides
-- a user interface for interacting with databases. It depends on 'vim-dadbod'
-- for the core database connectivity and can optionally use
-- 'vim-dadbod-completion' for autocompletion in SQL buffers.

return {
    "kristijanhusak/vim-dadbod-ui", -- The plugin specification: name of the GitHub repository.
    dependencies = { -- Define the plugin's dependencies.
        { "tpope/vim-dadbod", lazy = true }, -- 'vim-dadbod' is the core plugin for database
                                            -- connections. It's marked as `lazy = true`, meaning
                                            -- lazy.nvim will only load it when it's needed.
        { "kristijanhusak/vim-dadbod-completion", -- 'vim-dadbod-completion' provides autocompletion
          ft = { "sql", "mysql", "plsql" },      -- for SQL-like filetypes.
          lazy = true },                       -- It's also lazy-loaded and only for
                                            -- specific filetypes.
    },
    cmd = { -- Define commands that this plugin makes available in Neovim.
        "DBUI",             -- Opens the main Dadbod UI window.
        "DBUIToggle",       -- Toggles the Dadbod UI window (open/close).
        "DBUIAddConnection", -- Adds a new database connection.
        "DBUIFindBuffer",    -- Finds a buffer associated with a database connection.
    },
    init = function() -- Initialization function that runs when the plugin is loaded.
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1 -- Configures Dadbod UI to use Nerd Fonts
                                     -- for icons, if available. This improves
                                     -- the visual appearance of the UI.
    end,
}