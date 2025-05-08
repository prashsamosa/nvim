-- Configure conform.nvim for automatic formatting on save
return {
  "stevearc/conform.nvim",
  opts = {
    -- Configure formatters per filetype
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt" },
      javascript = {
        "prettierd",
        "prettier",
        stop_after_first = true, -- Stop after the first available formatter
      },
      typescript = {
        "prettierd",
        "prettier",
        stop_after_first = true,
      },

      -- ✅ Go support
      go = { "gofumpt" },

      -- Optional: Enable if needed
      -- html = { "prettierd", "prettier" },
      -- css = { "prettierd", "prettier" },
      -- json = { "prettierd", "prettier" },
      -- yaml = { "prettierd", "prettier" },
      -- markdown = { "markdownlint" },

      -- Fallback for any filetype
      ["_"] = { "trim_whitespace" },
    },

    -- Auto format on save
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback", -- Use LSP formatting if available, else fallback to formatter
    },
  },
}
