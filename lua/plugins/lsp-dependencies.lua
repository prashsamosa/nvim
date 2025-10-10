-- ================================================================================================
-- TITLE : LSP Dependencies (Neovim 0.11+ Native LSP)
-- ABOUT : Only the dependencies needed for native LSP setup
-- ================================================================================================

return {
  -- Mason for installing LSP servers, formatters, and linters
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  -- EFM Language Server formatter/linter configs
  {
    "creativenull/efmls-configs-nvim",
    dependencies = { "mason-org/mason.nvim" },
  },
}
