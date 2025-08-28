vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gosum", "gotmpl" },
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
      completeUnimported = true,
      codelenses = { generate = true, test = true, tidy = true },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        parameterNames = true,
      },
    },
  },
})

vim.lsp.enable("gopls")

-- Go-specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gosum", "gotmpl" },
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    local set = vim.keymap.set

    set("n", "<leader>gi", "<cmd>!goimports -w %<CR>", vim.tbl_extend("force", opts, { desc = "Go imports" }))
    set("n", "<leader>gt", "<cmd>!go test<CR>", vim.tbl_extend("force", opts, { desc = "Go test" }))
    set("n", "<leader>gr", "<cmd>!go run %<CR>", vim.tbl_extend("force", opts, { desc = "Go run" }))
  end,
})
