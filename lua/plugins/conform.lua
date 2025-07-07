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
      mode = "",
      desc = "Format buffer (Conform)",
    },
  },
  opts = function()
    local prettierd_or_prettier = { "prettierd", "prettier", stop_after_first = true }
    return {
      formatters_by_ft = {
        bash            = { "shfmt" },
        css             = { "prettierd" },
        go              = { "goimports", "gofumpt" },
        html            = { "prettierd" },
        javascript      = { prettierd_or_prettier },
        javascriptreact = { prettierd_or_prettier },
        json            = { "prettierd" },
        lua             = { "stylua" },
        markdown        = { "prettierd" },
        python          = { "isort", "black" },
        rust            = { "rustfmt" },
        sh              = { "shfmt" },
        svelte          = { "prettierd" },
        typescript      = { prettierd_or_prettier },
        typescriptreact = { prettierd_or_prettier },
        yaml            = { "prettierd" },
        [""]            = { "trim_whitespace" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        prettierd = {
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/.prettierrc.json"),
          },
        },
      },
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        local name = vim.api.nvim_buf_get_name(bufnr)
        -- Added name check to prevent errors on buffers without a name (e.g., [No Name])
        if vim.tbl_contains({ "sql", "java" }, ft) or (name and name:match("/node_modules/")) then
          return
        end
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
      notify_no_formatters = true,
    }
  end,
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
