return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod",                     lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },

    keys = {
        { "<leader>Do", "<cmd>DBUI<CR>",              desc = "DB: Open" },
        { "<leader>Du", "<cmd>DBUIToggle<CR>",        desc = "DB: Toggle" },
        { "<leader>Da", "<cmd>DBUIAddConnection<CR>", desc = "DB: Add Connection" },
    },

    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.db_ui_win_position = "left"
        vim.g.db_ui_winwidth = 40
    end,

    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "sql", "mysql", "plsql" },
            callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "<leader>Dr", "<cmd>DBUIExecute<CR>",
                    vim.tbl_extend("force", opts, { desc = "Execute Query" }))
                vim.keymap.set("v", "<leader>Dr", "<cmd>DBUIExecute<CR>",
                    vim.tbl_extend("force", opts, { desc = "Execute Selection" }))
            end,
        })
    end,
}
