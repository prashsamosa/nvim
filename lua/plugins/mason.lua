return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  opts = {
    ui = { border = "rounded" },
  },

  config = function(_, opts)
    require("mason").setup(opts)
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Language servers
        "lua-language-server",
        "typescript-language-server",
        "pyright",
        "gopls",

        -- Formatters
        "stylua",
        "prettierd",
        "goimports",
        "gofumpt",
        "ruff",

        -- Linters/Tools
        "eslint_d",
        "shellcheck",
      },
      auto_update = false,
      run_on_start = true,
    })
  end,
}
