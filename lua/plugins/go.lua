return {
  "ray-x/go.nvim",
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    -- Check for blink.cmp capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_blink_cmp = pcall(require, "blink.cmp")

    if has_blink_cmp then
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
    end

    -- Check for LuaSnip
    local has_luasnip = pcall(require, "luasnip")

    -- Setup go.nvim
    require("go").setup({
      -- LSP Configuration
      lsp_cfg = false, -- Let lspconfig handle LSP setup
      lsp_codelens = true,
      lsp_inlay_hints = {
        enable = true,
        only_current_line = false,
        only_current_line_autocmd = "CursorHold",
        show_variable_name = true,
        show_parameter_hints = true,
        parameter_hints_prefix = "󰊕 ",
        other_hints_prefix = "=> ",
      },

      -- Diagnostic Configuration
      diagnostic = {
        hdlr = false, -- Let other diagnostic handlers manage this
        underline = true,
        virtual_text = { space = 0, prefix = "■" },
        signs = true,
        update_in_insert = false,
      },

      -- Tool Configuration
      test_runner = "go",
      run_in_floaterm = false,
      build_tags = "",

      -- UI Configuration
      icons = {
        breakpoint = "🔴",
        currentpos = "➤",
      },

      -- Integration
      trouble = true,
      luasnip = has_luasnip,
    })

    -- Create autocommand for Go-specific keymaps
    local go_augroup = vim.api.nvim_create_augroup("GoKeymaps", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "gomod" },
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
        map("n", "<leader>ot", "<cmd>GoModTidy<CR>", "Go mod tidy")

        -- Code Generation
        map("n", "<leader>gc", "<cmd>GoCmt<CR>", "Generate comment")
        map("n", "<leader>gs", "<cmd>GoFillStruct<CR>", "Fill struct")
        map("n", "<leader>gr", "<cmd>GoGenReturn<CR>", "Generate return")
        map("n", "<leader>gj", "<cmd>GoJson2Struct<CR>", "JSON to struct")
        map("n", "<leader>gI", "<cmd>GoImpl<CR>", "Implement interface")

        -- Struct Tags
        map({ "n", "v" }, "<leader>gta", "<cmd>GoAddTag<CR>", "Add struct tags")
        map({ "n", "v" }, "<leader>gtr", "<cmd>GoRmTag<CR>", "Remove struct tags")

        -- Build & Run
        map("n", "<leader>bb", "<cmd>GoBuild<CR>", "Build package")
        map("n", "<leader>br", "<cmd>GoRun<CR>", "Run package")
        map("n", "<leader>gx", "<cmd>GoRun %<CR>", "Run current file")

        -- Testing
        map("n", "<leader>tp", "<cmd>GoTestPkg<CR>", "Test package")
        map("n", "<leader>tf", "<cmd>GoTestFunc<CR>", "Test function")
        map("n", "<leader>tF", "<cmd>GoTestFile<CR>", "Test file")
        map("n", "<leader>gat", "<cmd>GoAddTest<CR>", "Add test")
        map("n", "<leader>get", "<cmd>GoAddExpTest<CR>", "Add example test")

        -- Coverage
        map("n", "<leader>tc", "<cmd>GoCoverage<CR>", "Show coverage")
        map("n", "<leader>tC", "<cmd>GoCoverageToggle<CR>", "Toggle coverage")
        map("n", "<leader>gcb", "<cmd>GoCoverageBrowser<CR>", "Coverage browser")

        -- Code Quality
        map("n", "<leader>gL", "<cmd>GoLint<CR>", "Lint code")
        map("n", "<leader>gV", "<cmd>GoVet<CR>", "Vet code")

        -- Documentation
        map("n", "<leader>gD", "<cmd>GoDoc<CR>", "Show documentation")
        map("n", "<leader>gDb", "<cmd>GoDocBrowser<CR>", "Documentation browser")

        -- Code Generation
        map("n", "<leader>gG", "<cmd>GoGenerate<CR>", "Run go generate")
        map("n", "<leader>gm", "<cmd>GoMockGen<CR>", "Generate mocks")
      end,
    })
  end,
}
