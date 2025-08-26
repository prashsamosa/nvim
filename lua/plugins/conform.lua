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
            jsonc = { "prettierd", "prettier", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
            css = { "prettierd", "prettier", stop_after_first = true },
            scss = { "prettierd", "prettier", stop_after_first = true },
            markdown = { "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
            toml = { "taplo" },
            go = { "goimports", "gofumpt" },
            rust = { "rustfmt" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            zsh = { "shfmt" },
            fish = { "fish_indent" },
            -- Global formatters
            ["*"] = { "codespell" },
            ["_"] = { "trim_whitespace" },
        },

        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
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
            rustfmt = {
                prepend_args = { "--edition", "2021" },
            },
            taplo = {
                args = { "format", "--option", "indent_string=  ", "-" },
            },
        },

        format_on_save = function(bufnr)
            -- Disable for specific filetypes
            local ft = vim.bo[bufnr].filetype
            if vim.tbl_contains({ "sql", "java", "c", "cpp" }, ft) then
                return
            end

            -- Skip large files and node_modules
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if vim.fn.getfsize(bufname) > 100000 or bufname:match("/node_modules/") then
                return
            end

            -- Skip if formatting is globally disabled
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end

            return {
                timeout_ms = 3000,
                lsp_format = "fallback",
                quiet = true, -- Don't show formatting messages
            }
        end,

        format_after_save = {
            lsp_format = "fallback",
        },

        -- Enhanced logging for debugging
        log_level = vim.log.levels.WARN,
        notify_on_error = true,
        notify_no_formatters = false,
    },

    init = function()
        -- Set formatexpr for better integration
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        -- Enhanced Format command with range support
        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() }
                }
            end
            require("conform").format({
                async = true,
                lsp_format = "fallback",
                range = range
            })
        end, {
            range = true,
            desc = "Format code"
        })

        -- Global toggle for auto-formatting
        vim.api.nvim_create_user_command("ConformToggle", function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            local status = vim.g.disable_autoformat and "disabled" or "enabled"
            vim.notify("Auto-format " .. status, vim.log.levels.INFO)
        end, {
            desc = "Toggle auto-format globally"
        })

        -- Buffer-local toggle for auto-formatting
        vim.api.nvim_create_user_command("ConformToggleBuffer", function()
            vim.b.disable_autoformat = not vim.b.disable_autoformat
            local status = vim.b.disable_autoformat and "disabled" or "enabled"
            vim.notify("Auto-format " .. status .. " for this buffer", vim.log.levels.INFO)
        end, {
            desc = "Toggle auto-format for current buffer"
        })

        -- Enhanced keymap for format toggle
        vim.keymap.set("n", "<leader>tf", "<cmd>ConformToggle<cr>", {
            desc = "Toggle auto-format"
        })
        vim.keymap.set("n", "<leader>tF", "<cmd>ConformToggleBuffer<cr>", {
            desc = "Toggle auto-format (buffer)"
        })
    end,
}
