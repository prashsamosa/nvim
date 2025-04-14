-- Configure 'conform.nvim' for a unified code formatting experience.
-- This plugin automates code formatting using various external formatters
-- based on the file type.

return {
    "stevearc/conform.nvim", -- Plugin specification.
    opts = { -- Configuration options for 'conform.nvim'.
        formatters_by_ft = { -- Define formatters to use for each file type.
            lua = { "stylua" }, -- Use 'stylua' for Lua files.

            python = { "isort", "black" }, -- Run 'isort' (imports) then 'black' for Python.
            -- Multiple formatters are run sequentially.

            rust = { "rustfmt" }, -- Use 'rustfmt' for Rust files.

            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            -- For JavaScript and TypeScript, try 'prettierd' first, then 'prettier'.
            -- 'stop_after_first = true' ensures only the first available formatter runs.
        },

        format_on_save = { -- Automatically format files on save.
            timeout_ms = 500, -- Maximum time (in ms) to wait for formatting.
            lsp_format = "fallback", -- Use LSP formatting if available, otherwise fallback to Conform's formatters.
            -- Options:
            -- - "fallback": Use LSP if available, else Conform's formatters.
            -- - true: Always use LSP formatting if available.
            -- - false: Never use LSP formatting, always use Conform's formatters.
        },
    },
}