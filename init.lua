require("config.lazy")



-- Initialize LSP after lazy is loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("lsp").setup()
  end,
})
