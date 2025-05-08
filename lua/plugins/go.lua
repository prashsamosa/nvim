return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "mfussenegger/nvim-dap",           -- for DAP support
    "leoluz/nvim-dap-go",              -- Go debug adapter
    "rcarriga/nvim-dap-ui",            -- Optional: A UI for nvim-dap
    "theHamsta/nvim-dap-virtual-text", -- Optional: Display variable values inline
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if package.loaded["blink.cmp"] then
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      vim.notify("go.nvim: Using capabilities from blink.cmp", vim.log.levels.INFO, { title = "go.nvim" })
    else
      vim.notify("go.nvim: Warning - blink.cmp not loaded, using default LSP capabilities.", vim.log.levels.WARN,
      { title = "go.nvim" })
    end

    require("go").setup({
      lsp_cfg = {
        capabilities = capabilities,
      },
      lsp_codelens = true,
      lsp_gofumpt = true,
      diagnostic = {
        hdlr = true,
      },
    })

    -- Setup nvim-dap-go
    require("dap-go").setup()

    -- Optional: Setup nvim-dap-ui
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Optional: Setup nvim-dap-virtual-text
    require("dap-virtual-text").setup()

    local go_augroup = vim.api.nvim_create_augroup("GoUserKeymaps", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "gomod" },
      group = go_augroup,
      callback = function(ev)
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        local map = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, vim.tbl_extend("force", bufopts, { desc = "Go: " .. desc }))
        end

        -- Alternate File Switching (using <leader>ga, <leader>gv, <leader>gs to avoid conflicts)
        map("n", "<leader>ga", "<cmd>lua require('go.alternate').switch(true, '')<CR>", "Alternate File")
        map("n", "<leader>gv", "<cmd>lua require('go.alternate').switch(true, 'vsplit')<CR>", "Alternate Vertical Split")
        map("n", "<leader>gs", "<cmd>lua require('go.alternate').switch(true, 'split')<CR>", "Alternate Horizontal Split")

        -- Code Generation & Management
        map("n", "<leader>oi", "<cmd>GoImports<CR>", "Imports (add/organize)")
        map("n", "<leader>of", "<cmd>GoFmt<CR>", "Format (gofumpt/golines)")
        map("n", "<leader>ot", "<cmd>GoModTidy<CR>", "Mod Tidy")
        map("n", "<leader>oc", ":lua require('go.comment').gen()<CR>", "Generate Comment Stub")
        map("n", "<leader>os", "<cmd>GoFillStruct<CR>", "Fill Struct")
        map("n", "<leader>or", "<cmd>GoGenReturn<CR>", "Generate Return Values")
        map("n", "<leader>oj", "<cmd>GoJson2Struct<CR>", "JSON to Struct")
        map("n", "<leader>oa", "<cmd>GoAddTag<CR>", "Add Struct Tag")
        map("n", "<leader>od", "<cmd>GoRmTag<CR>", "Remove Struct Tag")
        map("n", "<leader>ol", "<cmd>GoLint<CR>", "Lint (golangci-lint)")
        map("n", "<leader>og", "<cmd>GoGenerate<CR>", "Run Go Generate")

        -- Build & Test
        map("n", "<leader>bb", "<cmd>GoBuild %:h<CR>", "Build Package")
        map("n", "<leader>br", "<cmd>GoRun %:h<CR>", "Run Package")
        map("n", "<leader>tp", "<cmd>GoTestPkg<CR>", "Test Package")
        map("n", "<leader>tf", "<cmd>GoTestFunc<CR>", "Test Function (Nearest)")
        map("n", "<leader>tF", "<cmd>GoTestFile<CR>", "Test File")
        map("n", "<leader>tc", "<cmd>GoCoverage -p<CR>", "Test Coverage (Package)")
        map("n", "<leader>tC", "<cmd>GoCoverageToggle<CR>", "Toggle Coverage Display")

        -- DAP (Debugging)
        map("n", "<leader>dgd", "<cmd>lua require('dap').continue()<CR>", "Debug Continue (Auto Detect)")
        map("n", "<leader>dgt", "<cmd>lua require('dap').step_over()<CR>", "Debug Step Over")
        map("n", "<leader>dgi", "<cmd>lua require('dap').step_into()<CR>", "Debug Step Into")
        map("n", "<leader>dgo", "<cmd>lua require('dap').step_out()<CR>", "Debug Step Out")
        map("n", "<leader>dgb", "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Debug Toggle Breakpoint")
        map("n", "<leader>dgx", "<cmd>lua require('dap').terminate()<CR>", "Debug Stop")
        map("n", "<leader>drs", "<cmd>lua require('dap').repl.open()<CR>", "Debug REPL Open")
        map("n", "<leader>drr", "<cmd>lua require('dap').run()<CR>", "Debug Run (Start)")
        map("n", "<leader>dra", "<cmd>lua require('dap').attach()<CR>", "Debug Attach")

        -- Other Go Commands (prefixing with <leader>g to avoid conflicts with LSP)
        map("n", "<leader>gh", "<cmd>GoDoc<CR>", "Hover Doc Popup")
        map("n", "<leader>gi", "<cmd>GoImpl<CR>", "Implement Interface")
        map("n", "<leader>gm", "<cmd>GoMockGen<CR>", "Generate Mocks")
      end,
    })

    vim.notify("go.nvim configured with DAP!", vim.log.levels.INFO, { title = "go.nvim" })
  end,
  event = { "FileType go", "FileType gomod" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
}
