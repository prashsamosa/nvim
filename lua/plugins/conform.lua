-- Auto-formatting with conform.nvim
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
      desc = "Format buffer",
    },
  },
  opts = function()
    local prettierd_or_prettier = {
      "prettierd",
      "prettier",
      stop_after_first = true,
    }

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

        ["_"]           = { "trim_whitespace" }, -- fallback for all filetypes
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
        -- Disable format on save for certain filetypes
        local ignore_filetypes = { "sql", "java" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        -- Disable autoformat for files in a certain path
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return
        end

        return {
          timeout_ms = 1000,
          lsp_format = "fallback", -- Use LSP formatting as fallback if no formatter configured
        }
      end,

      format_after_save = {
        lsp_format = "fallback",
      },

      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
      notify_no_formatters = true,
    }
  end,

  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
