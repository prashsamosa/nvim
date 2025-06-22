-- Auto-formatting with conform.nvim
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      bash        = { "shfmt" },
      css         = { "prettierd" },
      go          = { "goimports" },
      html        = { "prettierd" },
      javascript  = { { "prettierd", "prettier", stop_after_first = true } },
      json        = { "prettierd" },
      lua         = { "stylua" },
      markdown    = { "prettierd" },
      python      = { "isort", "black" },
      rust        = { "rustfmt" },
      sh          = { "shfmt" },
      typescript  = { { "prettierd", "prettier", stop_after_first = true } },
      yaml        = { "prettierd" },

      ["_"]       = { "trim_whitespace" },
    },

    format_on_save = {
      timeout_ms = 1000,
      lsp_format = "never",
    },
  },
}
