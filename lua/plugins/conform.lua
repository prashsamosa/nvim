-- Auto-formatting with conform.nvim
return {
  "stevearc/conform.nvim",
  opts = function()
    local prettierd_or_prettier = {
      "prettierd",
      "prettier",
      stop_after_first = true,
    }

    return {
      formatters_by_ft = {
        bash        = { "shfmt" },
        css         = { "prettierd" },
        go          = { "goimports" },
        html        = { "prettierd" },
        javascript  = { prettierd_or_prettier },
        json        = { "prettierd" },
        lua         = { "stylua" },
        markdown    = { "prettierd" },
        python      = { "isort", "black" },
        rust        = { "rustfmt" },
        sh          = { "shfmt" },
        typescript  = { prettierd_or_prettier },
        yaml        = { "prettierd" },

        ["_"]       = { "trim_whitespace" }, -- fallback for all filetypes
      },

      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "never", -- disable LSP formatting to use Conform's
      },
    }
  end,
}
