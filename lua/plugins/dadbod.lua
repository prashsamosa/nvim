return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod",                     lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },

    keys = {
        { "<leader>Do", "<cmd>DBUI<CR>",              desc = "Database: Open UI" },
        { "<leader>Du", "<cmd>DBUIToggle<CR>",        desc = "Database: Toggle UI" },
        { "<leader>Da", "<cmd>DBUIAddConnection<CR>", desc = "Database: Add Connection" },
        { "<leader>Df", "<cmd>DBUIFindBuffer<CR>",    desc = "Database: Find Buffer" },
    },

    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.db_ui_show_database_icon = 1
        vim.g.db_ui_win_position = "left"
        vim.g.db_ui_winwidth = 40
        vim.g.db_ui_tmp_query_location = vim.fn.stdpath("cache") .. "/db_ui_queries"

        vim.g.db_ui_icons = {
            expanded = { db = "▾ ", buffers = "▾ ", schemas = "▾ ", tables = "▾ 藺", table = "▾ " },
            collapsed = { db = "▸ ", buffers = "▸ ", schemas = "▸ ", tables = "▸ 藺", table = "▸ " },
        }
    end,

    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "sql", "mysql", "plsql" },
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }
                vim.keymap.set("n", "<leader>Dr", "<cmd>DBUIExecute<CR>",
                    vim.tbl_extend("force", opts, { desc = "Execute Query" }))
                vim.keymap.set("v", "<leader>Dr", "<cmd>DBUIExecute<CR>",
                    vim.tbl_extend("force", opts, { desc = "Execute Selection" }))
            end,
        })
    end,
}
