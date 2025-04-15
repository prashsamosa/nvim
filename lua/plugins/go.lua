-- lua/plugins/go.lua
return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    -- Get LSP capabilities from blink.cmp, as configured in your lsp.lua
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if package.loaded["blink.cmp"] then
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      print("go.nvim: Using capabilities from blink.cmp")
    else
      print("go.nvim: Warning - blink.cmp not loaded, using default LSP capabilities.")
    end

    require("go").setup({
      lsp_cfg = {
        capabilities = capabilities,
      },
      lsp_codelens = true,
      lsp_gofumpt = true,
      lsp_diag_hdlr = true,
      -- format_on_save = false, -- Uncomment if you use conform.nvim for formatting
      -- textobject = false,     -- Uncomment if you want to disable go.nvim's treesitter textobjects
    })

    -- Go-specific keymaps within an autocommand
    local go_augroup = vim.api.nvim_create_augroup("GoUserKeymaps", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "gomod" },
      group = go_augroup,
      callback = function(ev)
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        local map = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, vim.tbl_extend("force", bufopts, { desc = "Go: " .. desc }))
        end

        -- *** Alternate File Switching (Source <-> Test) ***
        map("n", "ga", "<cmd>lua require('go.alternate').switch(true, '')<CR>", "Alternate File")
        map("n", "gv", "<cmd>lua require('go.alternate').switch(true, 'vsplit')<CR>", "Alternate Vertical Split")
        map("n", "gs", "<cmd>lua require('go.alternate').switch(true, 'split')<CR>", "Alternate Horizontal Split")

        -- *** Code Generation & Management (<leader>o for Go "Operations/Organize") ***
        map("n", "<leader>oi", "<cmd>GoImports<CR>", "Imports (add/organize)")
        map("n", "<leader>of", "<cmd>GoFmt<CR>", "Format (gofumpt/golines)")
        map("n", "<leader>ot", "<cmd>GoModTidy<CR>", "Mod Tidy")
        map("n", "<leader>oc", ":lua require('go.comment').gen()<CR>", "Generate Comment Stub")
        map("n", "<leader>os", "<cmd>GoFillStruct<CR>", "Fill Struct")
        map("n", "<leader>or", "<cmd>GoGenReturn<CR>", "Generate Return Values")
        map("n", "<leader>oj", "<cmd>GoJson2Struct<CR>", "JSON to Struct")
        map("n", "<leader>oa", "<cmd>GoAddTag<CR>", "Add Struct Tag")
        map("n", "<leader>od", "<cmd>GoRmTag<CR>", "Remove Struct Tag")
        map("n", "<leader>ol", "<cmd>GoLint<CR>", "Lint (golangci-lint)") -- CHANGED: was <leader>gL
        map("n", "<leader>og", "<cmd>GoGenerate<CR>", "Run Go Generate")   -- CHANGED: was <leader>gG

        -- *** Build & Test ***
        map("n", "<leader>bb", "<cmd>GoBuild %:h<CR>", "Build Package")
        map("n", "<leader>br", "<cmd>GoRun %:h<CR>", "Run Package")
        map("n", "<leader>tp", "<cmd>GoTestPkg<CR>", "Test Package")
        map("n", "<leader>tf", "<cmd>GoTestFunc<CR>", "Test Function (Nearest)")
        map("n", "<leader>tF", "<cmd>GoTestFile<CR>", "Test File")
        map("n", "<leader>tc", "<cmd>GoCoverage -p<CR>", "Test Coverage (Package)")
        map("n", "<leader>tC", "<cmd>GoCoverageToggle<CR>", "Toggle Coverage Display")

        -- *** Debugging (<leader>dg prefix) ***
        map("n", "<leader>dgd", "<cmd>GoDebug<CR>", "Debug (Start/Auto-Detect)")
        map("n", "<leader>dgt", "<cmd>GoDebug -t<CR>", "Debug Test (Nearest/File)")
        map("n", "<leader>dgc", "<cmd>GoDbgContinue<CR>", "Debug Continue")
        map("n", "<leader>dgb", "<cmd>GoBreakToggle<CR>", "Debug Toggle Breakpoint")
        map("n", "<leader>dgx", "<cmd>GoDbgStop<CR>", "Debug Stop")
        map("n", "<leader>dgr", "<cmd>GoDebug -R<CR>", "Debug Restart")

        -- *** Other Go Commands (<leader>g prefix, only non-conflicting) ***
        map("n", "<leader>gh", "<cmd>GoDoc<CR>", "Hover Doc Popup")
        map("n", "<leader>gi", "<cmd>GoImpl<CR>", "Implement Interface")
        map("n", "<leader>gm", "<cmd>GoMockGen<CR>", "Generate Mocks")
      end,
    })

    print("go.nvim configured!")
  end,
  event = { "FileType go", "FileType gomod" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
}