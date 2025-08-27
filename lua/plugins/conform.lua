return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },

    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = { "n", "v" },
            desc = "Format",
        },
    },

    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            -- python = { "isort", "black" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            javascriptreact = { "prettierd", "prettier", stop_after_first = true },
            typescriptreact = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
            go = { "goimports", "gofumpt" },
            rust = { "rustfmt" },
            sql = { "sqlfmt" },
            sh = { "shfmt" },
            python = { "ruff_format", "ruff_fix" }, -- Modern Python formatter
            c = { "clang-format" },
            cpp = { "clang-format" },
            markdown = { "markdownlint", "prettier", stop_after_first = true },
            ["_"] = { "trim_whitespace" },
        },

        format_on_save = function(bufnr)
            local ft = vim.bo[bufnr].filetype
            if vim.tbl_contains({ "sql" }, ft) then
                return
            end

            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if vim.fn.getfsize(bufname) > 100000 or bufname:match("/node_modules/") then
                return
            end

            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end

            return { timeout_ms = 3000, lsp_format = "fallback" }
        end,
    },

    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        vim.api.nvim_create_user_command("ConformToggle", function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            local status = vim.g.disable_autoformat and "disabled" or "enabled"
            vim.notify("Auto-format " .. status, vim.log.levels.INFO)
        end, { desc = "Toggle auto-format" })
    end,
}
