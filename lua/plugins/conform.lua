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
      -- Use goimports instead of gofumpt to handle both formatting and imports
      go = { "goimports" },
      -- Add more specific file types
      sh = { "shfmt" },
      bash = { "shfmt" },
      markdown = { "prettierd" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },

      ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
      timeout_ms = 1000, -- Increased timeout for Go files
      lsp_format = "never", -- Disable LSP formatting to avoid conflicts
    },
    -- Configure specific formatters
    formatters = {
      goimports = {
        prepend_args = { "-local", "github.com/yourusername" }, -- Adjust to your module prefix
      },
      shfmt = {
        prepend_args = { "-i", "2", "-ci" },
      },
    },
  },
}
