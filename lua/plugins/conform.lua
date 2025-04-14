-- Configure 'conform.nvim' for a unified code formatting experience.
-- This plugin automates formatting using external formatters based on filetype.

return {
  "stevearc/conform.nvim",
  opts = {
    -- Filetype-specific formatter definitions
    formatters_by_ft = {
      lua = { "stylua" },

      python = { "isort", "black" },

      rust = { "rustfmt" },

      javascript = {
        "prettierd",
        "prettier",
        stop_after_first = true, -- Use only the first formatter that succeeds.
      },
      typescript = {
        "prettierd",
        "prettier",
        stop_after_first = true, -- Use only the first formatter that succeeds.
      },

      -- Optional: Add formatters for common front-end/backend stacks (uncomment to enable)
      -- html = { "prettierd", "prettier" },
      -- css = { "prettierd", "prettier" },
      -- json = { "prettierd", "prettier" },
      -- yaml = { "prettierd", "prettier" },
      -- markdown = { "markdownlint" },

      -- Fallback for unmatched filetypes: trim trailing whitespace
      ["_"] = { "trim_whitespace" },
    },

    -- Auto-format on save settings
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback", -- Use LSP formatter if available, otherwise fallback to configured formatters.
    },
  },
}