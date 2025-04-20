return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt" },
      javascript = {
        "prettierd",
        "prettier",
        stop_after_first = true,
      },
      typescript = {
        "prettierd",
        "prettier",
        stop_after_first = true,
      },

      -- ✅ Go support
      go = { "gofumpt" },

      -- Optional: Uncomment to add more
      -- html = { "prettierd", "prettier" },
      -- css = { "prettierd", "prettier" },
      -- json = { "prettierd", "prettier" },
      -- yaml = { "prettierd", "prettier" },
      -- markdown = { "markdownlint" },

      ["_"] = { "trim_whitespace" },
    },

    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback", -- Let LSP do it unless explicitly disabled (like we did for Go)
    },
  },
}
