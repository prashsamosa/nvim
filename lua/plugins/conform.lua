-- Auto-formatting with conform.nvim
return {
  "stevearc/conform.nvim",
  opts = {
    -- Formatters by filetype
    formatters_by_ft = {
      lua         = { "stylua" },
      python      = { "isort", "black" },
      rust        = { "rustfmt" },
      go          = { "goimports" }, -- Handles imports and formatting

      javascript  = {
        { "prettierd", "prettier", stop_after_first = true },
      },
      typescript  = {
        { "prettierd", "prettier", stop_after_first = true },
      },

      sh          = { "shfmt" },
      bash        = { "shfmt" },
      markdown    = { "prettierd" },
      json        = { "prettierd" },
      yaml        = { "prettierd" },
      html        = { "prettierd" },
      css         = { "prettierd" },

      -- Fallback for any filetype
      ["_"]       = { "trim_whitespace" },
    },

    -- Format on save settings
    format_on_save = {
      timeout_ms = 1000,         -- Increased for slower formatters like Go
      lsp_format = "never",      -- Disable LSP formatting to avoid conflicts
    },

    -- Individual formatter configuration
  },
}
