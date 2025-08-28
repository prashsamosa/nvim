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
      "neovim/nvim-lspconfig", -- Still needed for server configurations
    },
    opts = {
      -- Automatically install these servers
      ensure_installed = {
        "lua_ls",
        "ts_ls",   -- TypeScript
        "pyright", -- Python
        "gopls",   -- Go
      },
      -- Automatically enable installed servers
      automatic_enable = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- This will automatically enable servers installed by Mason
      -- No need for manual vim.lsp.enable() calls
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
