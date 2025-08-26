-- lua/plugins/conform.lua - Optimized for Neovim 0.11

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
            stylua = {
                prepend_args = {
                    "--indent-type", "Spaces",
                    "--indent-width", "2",
                    "--column-width", "120",
                },
            },
            shfmt = {
                prepend_args = { "-i", "2", "-ci" },
            },
            black = {
                prepend_args = { "--fast", "--line-length", "88" },
            },
            isort = {
                prepend_args = { "--profile", "black" },
            },
        },

        format_on_save = function(bufnr)
            -- Disable for certain filetypes
            local ft = vim.bo[bufnr].filetype
            if vim.tbl_contains({ "sql", "java" }, ft) then
                return
            end

            -- Skip large files
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if vim.fn.getfsize(bufname) > 100000 then
                return
            end

            -- Skip node_modules and .git directories
            if bufname:match("/node_modules/") or bufname:match("/.git/") then
                return
            end

            return {
                timeout_ms = 3000,
                lsp_format = "fallback",
            }
        end,

        default_format_opts = {
            timeout_ms = 3000,
            async = false,
            quiet = false,
            lsp_format = "fallback",
        },
    },

    init = function()
        -- Use conform for gq formatting
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        -- Format command
        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            require("conform").format({ async = true, lsp_format = "fallback", range = range })
        end, { range = true, desc = "Format code" })

        -- Toggle auto-format
        vim.api.nvim_create_user_command("ConformToggle", function()
            if vim.g.disable_autoformat then
                vim.g.disable_autoformat = false
                vim.notify("Auto-format enabled", vim.log.levels.INFO)
            else
                vim.g.disable_autoformat = true
                vim.notify("Auto-format disabled", vim.log.levels.INFO)
            end
        end, { desc = "Toggle auto-format" })
    end,
}
