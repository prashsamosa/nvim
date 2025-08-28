vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME }
      },
      hint = { enable = true },
    },
  },
})

vim.lsp.enable("lua_ls")
