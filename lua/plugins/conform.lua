-- This file configures the 'conform.nvim' plugin, which provides a unified
-- interface for running code formatters across different programming languages.
-- It allows you to define which formatters to use for specific file types
-- and can automatically format your code on save.

return {
    "stevearc/conform.nvim", -- The plugin specification: name of the GitHub repository.
    opts = { -- Configuration options for the 'conform.nvim' plugin.
        formatters_by_ft = { -- A table that maps file types to the formatters
                             -- that should be used for them. The keys are file
                             -- type names (e.g., "lua", "python"), and the values
                             -- are tables of formatter names.
            lua = { "stylua" }, -- For Lua files, use the "stylua" formatter.
            -- Conform will run multiple formatters sequentially.
            python = { "isort", "black" }, -- For Python files, first run "isort"
                                          -- (for sorting imports) and then "black"
                                          -- (for code formatting).
            -- You can customize some of the format options for the filetype
            -- (see `:help conform.format` for more details).
            rust = { "rustfmt" }, -- For Rust files, use the "rustfmt" formatter.
            -- Conform will run the first available formatter in the list and
            -- stop if `stop_after_first` is set to true. This is useful when
            -- you have multiple formatters that can handle a file type, but you
            -- only want to use one (e.g., prefer a faster one if available).
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = { -- Configuration for automatically formatting files when
                           -- they are saved.
            -- These options will be passed to the `conform.format()` function.
            timeout_ms = 500, -- The maximum time (in milliseconds) to wait for the
                              -- formatting process to complete. If it takes longer,
                              -- it will be interrupted.
            lsp_format = "fallback", -- Determines how LSP (Language Server Protocol)
                                     -- formatting interacts with Conform.
                                     -- - "fallback": If an LSP server provides formatting
                                     --   capabilities, Conform will use that first. If not,
                                     --   it will use the formatters defined in
                                     --   `formatters_by_ft`.
                                     -- - true: Always use LSP formatting if available.
                                     -- - false: Never use LSP formatting, always use
                                     --   Conform's formatters.
        },
    },
}