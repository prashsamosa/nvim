return {
  "ray-x/go.nvim",
  ft = { "go", "gomod", "gosum", "gotmpl" },
  build = ":lua require('go.install').update_all_sync()",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },

  config = function()
    require("go").setup({
      lsp_cfg = false, -- We handle LSP separately
      lsp_gofumpt = true,
      lsp_codelens = true,
      lsp_inlay_hints = { enable = true },
      dap_debug = false,
      luasnip = false, -- We use blink.cmp
      gofmt = "gofumpt",
      -- Enhanced settings
      lsp_document_formatting = false, -- Let conform.nvim handle formatting
      lsp_keymaps = false, -- We define our own keymaps
      diagnostic = false, -- Let LSP handle diagnostics
      trouble = false, -- We don't have trouble.nvim
      textobjects = true, -- Enable Go textobjects
      test_runner = "go", -- Use plain go test
      -- Performance optimizations
      lsp_on_attach = false, -- We handle this in lsp.lua
      gopls_cmd = nil, -- Use system gopls
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "gomod", "gosum", "gotmpl" },
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "<leader>ga", "<cmd>GoAlt<CR>", vim.tbl_extend("force", opts, { desc = "Go: Alt file" }))
        vim.keymap.set("n", "<leader>gi", "<cmd>GoImports<CR>", vim.tbl_extend("force", opts, { desc = "Go: Imports" }))
        vim.keymap.set("n", "<leader>gb", "<cmd>GoBuild<CR>", vim.tbl_extend("force", opts, { desc = "Go: Build" }))
        vim.keymap.set("n", "<leader>gr", "<cmd>GoRun %<CR>", vim.tbl_extend("force", opts, { desc = "Go: Run" }))
        vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<CR>", vim.tbl_extend("force", opts, { desc = "Go: Test" }))
        vim.keymap.set(
          "n",
          "<leader>gT",
          "<cmd>GoTestFile<CR>",
          vim.tbl_extend("force", opts, { desc = "Go: Test File" })
        )
        vim.keymap.set(
          "n",
          "<leader>gf",
          "<cmd>GoFillStruct<CR>",
          vim.tbl_extend("force", opts, { desc = "Go: Fill Struct" })
        )
        vim.keymap.set(
          "n",
          "<leader>ge",
          "<cmd>GoIfErr<CR>",
          vim.tbl_extend("force", opts, { desc = "Go: Add if err" })
        )
      end,
    })
  end,
}
