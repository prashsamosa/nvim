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
            desc = "Format buffer/selection",
        },
    },

    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            javascriptreact = { "prettierd", "prettier", stop_after_first = true },
            typescriptreact = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
            css = { "prettierd", "prettier", stop_after_first = true },
            markdown = { "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
            go = { "goimports", "gofumpt" },
            rust = { "rustfmt" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            ["*"] = { "codespell" },
            ["_"] = { "trim_whitespace" },
        },

        formatters = {
            stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } },
            shfmt = { prepend_args = { "-i", "2", "-ci" } },
            black = { prepend_args = { "--fast", "--line-length", "88" } },
            isort = { prepend_args = { "--profile", "black" } },
        },

        format_on_save = function(bufnr)
            local ft = vim.bo[bufnr].filetype
            if vim.tbl_contains({ "sql", "java" }, ft) then return end

            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if vim.fn.getfsize(bufname) > 100000 or bufname:match("/node_modules/") then return end

            return { timeout_ms = 3000, lsp_format = "fallback" }
        end,
    },

    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = { start = { args.line1, 0 }, ["end"] = { args.line2, end_line:len() } }
            end
            require("conform").format({ async = true, lsp_format = "fallback", range = range })
        end, { range = true, desc = "Format code" })

        vim.api.nvim_create_user_command("ConformToggle", function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            vim.notify("Auto-format " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
        end, { desc = "Toggle auto-format" })
    end,
}
