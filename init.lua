require("config.lazy")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local ok, lsp = pcall(require, "config.lsp")
    if ok and lsp.setup then
      lsp.setup()
    else
      vim.notify("Failed to load LSP configuration", vim.log.levels.WARN)
    end
  end,
})
