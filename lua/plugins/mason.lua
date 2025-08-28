-- lua/plugins/mason.lua
return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      -- Automatically install these servers
      ensure_installed = {
        "lua_ls",
        "ts_ls",   -- TypeScript
        "pyright", -- Python
        "gopls",   -- Go
      },
      -- For Neovim 0.11+ with native LSP config, we disable automatic setup
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      -- No need for setup_handlers with native LSP config in 0.11+
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
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
      start_delay = 3000, -- Wait 3 seconds after startup
    },
  },
}
