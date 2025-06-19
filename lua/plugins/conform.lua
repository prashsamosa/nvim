-- Auto-formatting with conform.nvim
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt" },
      javascript = {
        { "prettierd", "prettier", stop_after_first = true },
      },
      typescript = {
        { "prettierd", "prettier", stop_after_first = true },
      },
      go = { "gofumpt" },

      ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
