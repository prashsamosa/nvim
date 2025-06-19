return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    { "mfussenegger/nvim-dap", lazy = true },
    { "leoluz/nvim-dap-go", lazy = true },
    { "rcarriga/nvim-dap-ui", lazy = true },
    {
      "theHamsta/nvim-dap-virtual-text",
      lazy = true,
      config = function()
        require("nvim-dap-virtual-text").setup({})
      end,
    },
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if package.loaded["blink.cmp"] then
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      vim.notify("Using capabilities from blink.cmp", vim.log.levels.INFO, { title = "go.nvim" })
    else
      vim.notify("blink.cmp not loaded, using default LSP capabilities", vim.log.levels.WARN, { title = "go.nvim" })
    end

    require("go").setup({
      lsp_cfg = { capabilities = capabilities },
      lsp_codelens = true,
      lsp_gofumpt = true,
      diagnostic = { hdlr = true },
    })

    -- Setup dap-go
    local ok_dap_go, dap_go = pcall(require, "dap-go")
    if ok_dap_go then
      dap_go.setup()
    end

    -- Setup dap-ui safely
    local dap_status, dap = pcall(require, "dap")
    local dapui_status, dapui = pcall(require, "dapui")
    if dap_status and dapui_status then
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    else
      vim.notify("nvim-dap or nvim-dap-ui not found", vim.log.levels.WARN, { title = "go.nvim" })
    end

    -- Setup dap-virtual-text if available
    local vt_ok, vt = pcall(require, "nvim-dap-virtual-text")
    if vt_ok then
      vt.setup({})
    end

    -- Go keymaps
    local augroup = vim.api.nvim_create_augroup("GoUserKeymaps", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "gomod" },
      group = augroup,
      callback = function(ev)
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        local map = function(mode, keys, cmd, desc)
          vim.keymap.set(mode, keys, cmd, vim.tbl_extend("force", bufopts, { desc = "Go: " .. desc }))
        end

        -- Alternate Files
        map("n", "<leader>ga", "<cmd>lua require('go.alternate').switch(true, '')<CR>", "Alternate File")
        map("n", "<leader>gv", "<cmd>lua require('go.alternate').switch(true, 'vsplit')<CR>", "Alternate VSplit")
        map("n", "<leader>gx", "<cmd>lua require('go.alternate').switch(true, 'split')<CR>", "Alternate Split")

        -- Tools
        map("n", "<leader>oi", "<cmd>GoImports<CR>", "Imports")
        map("n", "<leader>of", "<cmd>GoFmt<CR>", "Format")
        map("n", "<leader>ot", "<cmd>GoModTidy<CR>", "Mod Tidy")
        map("n", "<leader>oc", "<cmd>lua require('go.comment').gen()<CR>", "Comment Stub")
        map("n", "<leader>os", "<cmd>GoFillStruct<CR>", "Fill Struct")
        map("n", "<leader>or", "<cmd>GoGenReturn<CR>", "Gen Return")
        map("n", "<leader>oj", "<cmd>GoJson2Struct<CR>", "JSON → Struct")
        map("n", "<leader>oa", "<cmd>GoAddTag<CR>", "Add Tag")
        map("n", "<leader>od", "<cmd>GoRmTag<CR>", "Remove Tag")
        map("n", "<leader>ol", "<cmd>GoLint<CR>", "Lint")
        map("n", "<leader>og", "<cmd>GoGenerate<CR>", "Go Generate")

        -- Build & Test
        map("n", "<leader>bb", "<cmd>GoBuild %:h<CR>", "Build")
        map("n", "<leader>br", "<cmd>GoRun %:h<CR>", "Run")
        map("n", "<leader>tp", "<cmd>GoTestPkg<CR>", "Test Pkg")
        map("n", "<leader>tf", "<cmd>GoTestFunc<CR>", "Test Func")
        map("n", "<leader>tF", "<cmd>GoTestFile<CR>", "Test File")
        map("n", "<leader>tc", "<cmd>GoCoverage -p<CR>", "Coverage")
        map("n", "<leader>tC", "<cmd>GoCoverageToggle<CR>", "Toggle Coverage")

        -- DAP
        map("n", "<leader>dgd", "<cmd>lua require('dap').continue()<CR>", "Continue")
        map("n", "<leader>dgt", "<cmd>lua require('dap').step_over()<CR>", "Step Over")
        map("n", "<leader>dgi", "<cmd>lua require('dap').step_into()<CR>", "Step Into")
        map("n", "<leader>dgo", "<cmd>lua require('dap').step_out()<CR>", "Step Out")
        map("n", "<leader>dgb", "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Breakpoint")
        map("n", "<leader>dgx", "<cmd>lua require('dap').terminate()<CR>", "Terminate")
        map("n", "<leader>drs", "<cmd>lua require('dap').repl.open()<CR>", "REPL Open")
        map("n", "<leader>drr", "<cmd>lua require('dap').run()<CR>", "Run")
        map("n", "<leader>dra", "<cmd>lua require('dap').attach()<CR>", "Attach")

        -- Misc
        map("n", "<leader>gh", "<cmd>GoDoc<CR>", "Hover Doc")
        map("n", "<leader>gi", "<cmd>GoImpl<CR>", "Impl Interface")
        map("n", "<leader>gm", "<cmd>GoMockGen<CR>", "Generate Mocks")
      end,
    })

    vim.notify("go.nvim fully configured", vim.log.levels.INFO, { title = "go.nvim" })
  end,
  event = { "FileType go", "FileType gomod" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
}
