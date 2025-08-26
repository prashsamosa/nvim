return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({
                    async = true,
                    lsp_format = "fallback",
                    timeout_ms = 3000,
                })
            end,
            mode = { "n", "v" },
            desc = "Format buffer/selection (Conform)",
        },
        {
            "<leader>F",
            function()
                require("conform").format({
                    async = true,
                    lsp_format = "never",
                    timeout_ms = 3000,
                })
            end,
            mode = { "n", "v" },
            desc = "Format with external tools only",
        },
    },
    opts = function()
        -- Helper function for conditional formatting
        local slow_format_filetypes = { "rust", "go" }

        return {
            formatters_by_ft = {
                bash = { "shfmt" },
                css = { "prettierd", "prettier", stop_after_first = true },
                scss = { "prettierd", "prettier", stop_after_first = true },
                go = { "goimports", "gofumpt" },
                html = { "prettierd", "prettier", stop_after_first = true },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "prettierd", "prettier", stop_after_first = true },
                json = { "prettierd", "prettier", stop_after_first = true },
                jsonc = { "prettierd", "prettier", stop_after_first = true },
                lua = { "stylua" },
                luau = { "stylua" },
                markdown = { "prettierd", "prettier", stop_after_first = true },
                python = { "isort", "black" },
                rust = { "rustfmt", lsp_format = "fallback" },
                sh = { "shfmt" },
                svelte = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                vue = { "prettierd", "prettier", stop_after_first = true },
                yaml = { "prettierd", "prettier", stop_after_first = true },
                yml = { "prettierd", "prettier", stop_after_first = true },
                toml = { "taplo" },
                xml = { "xmlformat" },
                -- Fallback for unknown filetypes
                ["*"] = { "codespell" },
                ["_"] = { "trim_whitespace" },
            },

            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2", "-ci", "-sr" }, -- 2 spaces, switch case indent, simplify redirects
                },
                stylua = {
                    prepend_args = {
                        "--indent-type", "Spaces",
                        "--indent-width", "2",
                        "--column-width", "120",
                        "--line-endings", "Unix",
                    },
                },
                prettierd = {
                    env = {
                        PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/.prettierrc.json"),
                    },
                    condition = function(self, ctx)
                        -- Only use prettierd if prettier config exists
                        return vim.fs.find({
                            ".prettierrc",
                            ".prettierrc.json",
                            ".prettierrc.js",
                            ".prettierrc.mjs",
                            ".prettierrc.cjs",
                            ".prettierrc.yaml",
                            ".prettierrc.yml",
                            ".prettierrc.toml",
                            "prettier.config.js",
                            "prettier.config.mjs",
                            "prettier.config.cjs",
                        }, { path = ctx.filename, upward = true })[1]
                    end,
                },
                black = {
                    prepend_args = { "--fast", "--line-length", "88" },
                },
                isort = {
                    prepend_args = { "--profile", "black", "--multi-line", "3" },
                },
                rustfmt = {
                    options = {
                        default_timeout_ms = 5000,
                    },
                },
            },

            format_on_save = function(bufnr)
                local ft = vim.bo[bufnr].filetype
                local bufname = vim.api.nvim_buf_get_name(bufnr)

                -- Skip formatting for certain conditions
                if vim.tbl_contains({ "sql", "java" }, ft) then
                    return
                end

                -- Skip node_modules and similar directories
                if bufname:match("/node_modules/") or bufname:match("/.git/") then
                    return
                end

                -- Disable format on save for large files
                if vim.fn.getfsize(bufname) > 100000 then -- 100KB
                    return
                end

                -- Use async formatting for slow formatters
                local async = vim.tbl_contains(slow_format_filetypes, ft)

                return {
                    timeout_ms = async and 5000 or 1000,
                    lsp_format = "fallback",
                    async = async,
                }
            end,

            format_after_save = function(bufnr)
                local ft = vim.bo[bufnr].filetype

                -- Only use format_after_save for slow formatters
                if not vim.tbl_contains(slow_format_filetypes, ft) then
                    return
                end

                return { lsp_format = "fallback" }
            end,

            log_level = vim.log.levels.WARN,
            notify_on_error = true,
            notify_no_formatters = false, -- Set to false to reduce noise

            -- Default format options
            default_format_opts = {
                timeout_ms = 3000,
                async = false,
                quiet = false,
                lsp_format = "fallback",
            },
        }
    end,

    init = function()
        -- Use conform for gq formatting
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        -- Add user command for formatting specific lines
        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            require("conform").format({
                async = true,
                lsp_format = "fallback",
                range = range
            })
        end, { range = true, desc = "Format code" })

        -- Add user command for formatting info
        vim.api.nvim_create_user_command("ConformToggle", function()
            if vim.g.disable_autoformat or vim.b.disable_autoformat then
                vim.g.disable_autoformat = false
                vim.b.disable_autoformat = false
                vim.notify("Auto-format enabled", vim.log.levels.INFO)
            else
                vim.g.disable_autoformat = true
                vim.notify("Auto-format disabled", vim.log.levels.INFO)
            end
        end, { desc = "Toggle auto-format" })
    end,
}
