return {
  "ray-x/go.nvim",
  ft = { "go", "gomod", "gosum", "gotmpl" },
  build = ':lua require("go.install").update_all_sync()',
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    -- Get LSP capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_blink_cmp = pcall(require, "blink.cmp")

    if has_blink_cmp then
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
    end

    -- Setup go.nvim with improved configuration
    require("go").setup({
      -- LSP Configuration
      lsp_cfg = false,    -- Let lspconfig handle LSP setup
      lsp_gofumpt = true, -- Use gofumpt for formatting
      lsp_codelens = true,
      lsp_inlay_hints = {
        enable = true,
        only_current_line = false,
        other_hints_prefix = "=> ",
        parameter_hints_prefix = "󰊕 ",
        show_parameter_hints = true,
        show_variable_name = true,
      },

      -- Diagnostic Configuration
      diagnostic = {
        hdlr = false, -- Let other diagnostic handlers manage this
        underline = true,
        virtual_text = { space = 0, prefix = "●" },
        signs = true,
        update_in_insert = false,
      },

      -- Tool Configuration
      test_runner = "go",
      run_in_floaterm = false,
      build_tags = "",
      textobjects = true,
      test_efm = true,
      verbose = false,

      -- UI Configuration
      icons = {
        breakpoint = "🔴",
        currentpos = "➤",
      },

      -- Integration settings
      trouble = true,
      luasnip = pcall(require, "luasnip"),
      dap_debug = false, -- Disable DAP integration if not using

      -- Formatting (handled by conform.nvim)
      gofmt = 'gofumpt',
      max_line_len = 120,
      comment_placeholder = '   ',

      -- Test configuration
      test_timeout = '30s',
      test_env = {},

      -- Coverage
      coverage = {
        sign = "█",
        sign_covered = "█",
      },
    })

    -- Create autocommand for Go-specific keymaps
    local go_augroup = vim.api.nvim_create_augroup("GoKeymaps", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "gomod", "gosum", "gotmpl" },
      group = go_augroup,
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true, noremap = true }

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = "Go: " .. desc }))
        end

        -- File Navigation
        map("n", "<leader>ga", "<cmd>GoAlt<CR>", "Alternate file")
        map("n", "<leader>gvs", "<cmd>GoAltV<CR>", "Alternate vertical split")
        map("n", "<leader>ghs", "<cmd>GoAltS<CR>", "Alternate horizontal split")

        -- Code Organization
        map("n", "<leader>oi", "<cmd>GoImports<CR>", "Organize imports")
        map("n", "<leader>om", "<cmd>GoModTidy<CR>", "Go mod tidy")
       

        -- Code Generation
        map("n", "<leader>gc", "<cmd>GoCmt<CR>", "Generate comment")
        map("n", "<leader>gs", "<cmd>GoFillStruct<CR>", "Fill struct")
        map("n", "<leader>gr", "<cmd>GoGenReturn<CR>", "Generate return")
        map("n", "<leader>gj", "<cmd>GoJson2Struct<CR>", "JSON to struct")
        map("n", "<leader>gI", "<cmd>GoImpl<CR>", "Implement interface")
        map("n", "<leader>gG", "<cmd>GoGenerate<CR>", "Run go generate")
        map("n", "<leader>gm", "<cmd>GoMockGen<CR>", "Generate mocks")

        -- Struct Tags
        map({ "n", "v" }, "<leader>gta", "<cmd>GoAddTag<CR>", "Add struct tags")
        map({ "n", "v" }, "<leader>gtr", "<cmd>GoRmTag<CR>", "Remove struct tags")
        map({ "n", "v" }, "<leader>gtc", "<cmd>GoAddTag json<CR>", "Add JSON tags")
        map({ "n", "v" }, "<leader>gty", "<cmd>GoAddTag yaml<CR>", "Add YAML tags")

        -- Build & Run
        map("n", "<leader>bb", "<cmd>GoBuild<CR>", "Build package")
        map("n", "<leader>br", "<cmd>GoRun<CR>", "Run package")
        map("n", "<leader>gx", "<cmd>GoRun %<CR>", "Run current file")
        map("n", "<leader>bs", "<cmd>GoStop<CR>", "Stop running process")

        -- Testing
        map("n", "<leader>tp", "<cmd>GoTestPkg<CR>", "Test package")
        map("n", "<leader>tf", "<cmd>GoTestFunc<CR>", "Test function")
        map("n", "<leader>tF", "<cmd>GoTestFile<CR>", "Test file")
        map("n", "<leader>ta", "<cmd>GoTest<CR>", "Test all")
        map("n", "<leader>tv", "<cmd>GoTestPkg -v<CR>", "Test package verbose")
        map("n", "<leader>gat", "<cmd>GoAddTest<CR>", "Add test")
        map("n", "<leader>get", "<cmd>GoAddExpTest<CR>", "Add example test")

        -- Coverage
        map("n", "<leader>tc", "<cmd>GoCoverage<CR>", "Show coverage")
        map("n", "<leader>tC", "<cmd>GoCoverageToggle<CR>", "Toggle coverage")
        map("n", "<leader>tcb", "<cmd>GoCoverageBrowser<CR>", "Coverage browser")

        -- Code Quality
        map("n", "<leader>gl", "<cmd>GoLint<CR>", "Lint code")
        map("n", "<leader>gv", "<cmd>GoVet<CR>", "Vet code")
        map("n", "<leader>ge", "<cmd>GoErrCheck<CR>", "Error check")

        -- Documentation
        map("n", "<leader>gd", "<cmd>GoDoc<CR>", "Show documentation")
        map("n", "<leader>gdb", "<cmd>GoDocBrowser<CR>", "Documentation browser")

        -- Refactoring
        map("n", "<leader>gn", "<cmd>GoRename<CR>", "Rename symbol")
        map("n", "<leader>gf", "<cmd>GoFreevars<CR>", "Free variables")
        map("n", "<leader>go", "<cmd>GoChannelPeers<CR>", "Channel peers")

        -- Quick fixes
        map("n", "<leader>gqf", "<cmd>GoFixPlurals<CR>", "Fix plurals")
        map("n", "<leader>gqi", "<cmd>GoIfErr<CR>", "Add if err != nil")

        -- Debugging (if DAP is enabled)
        if package.loaded.dap then
          map("n", "<leader>gdt", "<cmd>lua require'dap-go'.debug_test()<CR>", "Debug test")
          map("n", "<leader>gdl", "<cmd>lua require'dap-go'.debug_last_test()<CR>", "Debug last test")
        end
      end,
    })

    -- Additional Go-specific autocommands
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      group = go_augroup,
      callback = function()
        -- Auto-organize imports on save (if not handled by conform.nvim)
        if not package.loaded.conform then
          require("go.format").goimport()
        end
      end,
    })

    -- Auto-run tests on save (optional, uncomment if desired)
    -- vim.api.nvim_create_autocmd("BufWritePost", {
    --   pattern = "*_test.go",
    --   group = go_augroup,
    --   callback = function()
    --     vim.cmd("GoTestFunc")
    --   end,
    -- })

    -- Set up custom commands for better workflow
    vim.api.nvim_create_user_command("GoWorkspace", function()
      vim.cmd("GoModTidy")
      vim.cmd("GoImports")
      vim.cmd("GoGenerate")
    end, { desc = "Run Go workspace maintenance" })

    vim.api.nvim_create_user_command("GoQuickTest", function()
      vim.cmd("GoTestPkg -short")
    end, { desc = "Run quick tests" })

    vim.api.nvim_create_user_command("GoBenchmark", function()
      vim.cmd("GoTest -bench=.")
    end, { desc = "Run benchmarks" })
  end,
}
