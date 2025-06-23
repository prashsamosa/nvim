return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        {
            "kristijanhusak/vim-dadbod-completion",
            ft = { "sql", "mysql", "plsql" },
            config = function()
                local cmp = require("cmp")
                cmp.setup.buffer({
                    sources = cmp.config.sources({
                        { name = "vim-dadbod-completion" },
                        { name = "buffer" },
                    }),
                })
            end,
        },
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
        "DBUIRenameBuffer",
        "DBUILastQueryInfo",
    },
    init = function()
        local g = vim.g
        local cache_dir = vim.fn.stdpath("cache") .. "/db_ui_queries"

        g.db_ui_use_nerd_fonts = 1
        g.db_ui_auto_execute_table_helpers = 1
        g.db_ui_show_database_icon = 1
        g.db_ui_force_echo_notifications = 1
        g.db_ui_win_position = "left"
        g.db_ui_winwidth = 40
        g.db_ui_disable_mappings = 0
        g.db_ui_tmp_query_location = cache_dir

        g.db_ui_table_helpers = {
            mysql = {
                Count = "select count(1) from {optional_schema}{table}",
                Explain = "explain {last_query}",
            },
            postgresql = {
                Count = "select count(1) from {optional_schema}{table}",
                Explain = "explain (analyze, buffers) {last_query}",
            },
            sqlite = {
                Count = "select count(1) from {table}",
                Explain = "explain query plan {last_query}",
            },
        }

        g.db_ui_icons = {
            expanded = {
                db = "▾ ",
                buffers = "▾ ",
                saved_queries = "▾ ",
                schemas = "▾ ",
                schema = "▾ פּ",
                tables = "▾ 藺",
                table = "▾ ",
            },
            collapsed = {
                db = "▸ ",
                buffers = "▸ ",
                saved_queries = "▸ ",
                schemas = "▸ ",
                schema = "▸ פּ",
                tables = "▸ 藺",
                table = "▸ ",
            },
            saved_query = "",
            new_query = "璘",
            tables = "離",
            buffers = "﬘",
            add_connection = "",
            connection_ok = "✓",
            connection_error = "✕",
        }

        if vim.fn.isdirectory(cache_dir) == 0 then
            vim.fn.mkdir(cache_dir, "p")
        end
    end,
    config = function()
        local map = vim.keymap.set
        local opts = { silent = true }

        map("n", "<leader>Do", "<Cmd>DBUI<CR>", { desc = "Database: Open UI", table.unpack(opts) })
        map("n", "<leader>Du", "<Cmd>DBUIToggle<CR>", { desc = "Database: Toggle UI", table.unpack(opts) })
        map("n", "<leader>Dc", "<Cmd>DBUIClose<CR>", { desc = "Database: Close UI", table.unpack(opts) })
        map("n", "<leader>Df", "<Cmd>DBUIFindBuffer<CR>", { desc = "Database: Find Buffer", table.unpack(opts) })
        map("n", "<leader>Da", "<Cmd>DBUIAddConnection<CR>", { desc = "Database: Add Connection", table.unpack(opts) })
        map("n", "<leader>Dn", "<Cmd>DBUIRenameBuffer<CR>", { desc = "Database: Rename Buffer", table.unpack(opts) })
        map("n", "<leader>Dl", "<Cmd>DBUILastQueryInfo<CR>", { desc = "Database: Last Query Info", table.unpack(opts) })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "sql", "mysql", "plsql" },
            callback = function(event)
                map(
                    "n",
                    "<leader>Dr",
                    "<Cmd>DBUIExecute<CR>",
                    { desc = "Execute Query", buffer = event.buf, table.unpack(opts) }
                )
                map(
                    "v",
                    "<leader>Dr",
                    "<Cmd>DBUIExecute<CR>",
                    { desc = "Execute Selection", buffer = event.buf, table.unpack(opts) }
                )
                map(
                    "n",
                    "<leader>DS",
                    "<Cmd>DBUISaveQuery<CR>",
                    { desc = "Save Query", buffer = event.buf, table.unpack(opts) }
                )

                vim.opt_local.commentstring = "-- %s"
                vim.opt_local.formatoptions:remove("t")
                vim.opt_local.formatoptions:append("croql")
            end,
        })

        vim.api.nvim_create_user_command("DBStatus", function()
            local is_db_buf = vim.fn.bufname("%"):match("dbui://")
            vim.notify(
                is_db_buf and "Connected to database" or "Not in a database buffer",
                is_db_buf and vim.log.levels.INFO or vim.log.levels.WARN
            )
        end, { desc = "Check DB connection status" })
    end,
}
