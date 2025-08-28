return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format code",
    },
    {
      "<leader>cF",
      "<cmd>ConformToggle<cr>",
      desc = "Toggle format on save",
    },
  },

  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      go = { "goimports", "gofumpt" },
      python = { "ruff_format", "ruff_fix" },
      ["_"] = { "trim_whitespace" },
    },

    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 3000, lsp_format = "fallback" }
    end,
  },

  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    -- Add toggle command
    vim.api.nvim_create_user_command("ConformToggle", function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      local status = vim.g.disable_autoformat and "disabled" or "enabled"
      vim.notify("Format on save " .. status, vim.log.levels.INFO)
    end, { desc = "Toggle format on save" })
  end,
}
