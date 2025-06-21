return {
  "ray-x/go.nvim",
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
  dependencies = {
    "ray-x/guihua.lua", -- UI helper
    "neovim/nvim-lspconfig", -- for LSP
    "nvim-treesitter/nvim-treesitter", -- syntax parsing
    "L3MON4D3/LuaSnip", -- snippet engine
  },
  config = function()
    -- LSP capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if package.loaded["blink.cmp"] then
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      vim.notify("Using capabilities from blink.cmp", vim.log.levels.INFO, { title = "go.nvim" })
    else
      vim.notify("blink.cmp not loaded, using default LSP capabilities", vim.log.levels.WARN, { title = "go.nvim" })
    end

    -- LuaSnip availability
    local has_luasnip, _ = pcall(require, "luasnip")
    vim.notify(
      has_luasnip and "LuaSnip module loaded successfully" or "LuaSnip not available, snippets disabled",
      has_luasnip and vim.log.levels.INFO or vim.log.levels.WARN,
      { title = "go.nvim" }
    )

    -- go.nvim setup
    require("go").setup({
      lsp_cfg = false, -- disable internal LSP setup
      lsp_codelens = true,
      lsp_gofumpt = true,
      lsp_inlay_hints = {
        enable = true,
        only_current_line = false,
        only_current_line_autocmd = "CursorHold",
        show_variable_name = true,
        parameter_hints_prefix = "󰊕 ",
        show_parameter_hints = true,
        other_hints_prefix = "=> ",
      },
      diagnostic = {
        hdlr = false, -- use native LSP diagnostics
        underline = true,
        virtual_text = { space = 0, prefix = "■" },
        signs = true,
        update_in_insert = false,
      },
      test_runner = "go",
      run_in_floaterm = false,
      build_tags = "",
      icons = {
        breakpoint = "🧘",
        currentpos = "🏃",
      },
      trouble = true,
      luasnip = has_luasnip,
    })

    -- Filetype-specific keymaps for Go
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "gomod" },
      group = vim.api.nvim_create_augroup("GoUserKeymaps", { clear = true }),
      callback = function(ev)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            desc = "Go: " .. desc,
            noremap = true,
            silent = true,
            buffer = ev.buf,
          })
        end

        -- File switching
        map("n", "<leader>ga", "<cmd>GoAlt<CR>", "Alternate File")
        map("n", "<leader>gvs", "<cmd>GoAltV<CR>", "Alternate Vertical")
        map("n", "<leader>ghs", "<cmd>GoAltS<CR>", "Alternate Horizontal")

        -- Formatting & Imports
        map("n", "<leader>oi", "<cmd>GoImports<CR>", "Imports")
        map("n", "<leader>of", "<cmd>GoFmt<CR>", "Format")
        map("n", "<leader>ot", "<cmd>GoModTidy<CR>", "Mod Tidy")

        -- Generation
        map("n", "<leader>gc", "<cmd>GoCmt<CR>", "Generate Comment")
        map("n", "<leader>gs", "<cmd>GoFillStruct<CR>", "Fill Struct")
        map("n", "<leader>gr", "<cmd>GoGenReturn<CR>", "Generate Return")
        map("n", "<leader>gj", "<cmd>GoJson2Struct<CR>", "JSON to Struct")

        -- Struct Tags
        map("n", "<leader>gta", "<cmd>GoAddTag<CR>", "Add Tags")
        map("n", "<leader>gtr", "<cmd>GoRmTag<CR>", "Remove Tags")
        map("v", "<leader>gta", "<cmd>GoAddTag<CR>", "Add Tags (Visual)")
        map("v", "<leader>gtr", "<cmd>GoRmTag<CR>", "Remove Tags (Visual)")

        -- Build & Run
        map("n", "<leader>bb", "<cmd>GoBuild<CR>", "Build")
        map("n", "<leader>br", "<cmd>GoRun<CR>", "Run")
        map("n", "<leader>gx", "<cmd>GoRun %<CR>", "Run Current File")

        -- Testing
        map("n", "<leader>tp", "<cmd>GoTestPkg<CR>", "Test Package")
        map("n", "<leader>tf", "<cmd>GoTestFunc<CR>", "Test Function")
        map("n", "<leader>tF", "<cmd>GoTestFile<CR>", "Test File")
        map("n", "<leader>gat", "<cmd>GoAddTest<CR>", "Add Test")
        map("n", "<leader>get", "<cmd>GoAddExpTest<CR>", "Add Example Test")

        -- Coverage
        map("n", "<leader>tc", "<cmd>GoCoverage<CR>", "Show Coverage")
        map("n", "<leader>tC", "<cmd>GoCoverageToggle<CR>", "Toggle Coverage")
        map("n", "<leader>gcb", "<cmd>GoCoverageBrowser<CR>", "Coverage Browser")

        -- Linting
        map("n", "<leader>gL", "<cmd>GoLint<CR>", "Lint")
        map("n", "<leader>gV", "<cmd>GoVet<CR>", "Vet")

        -- Docs & Interfaces
        map("n", "<leader>gD", "<cmd>GoDoc<CR>", "Go Doc")
        map("n", "<leader>gDb", "<cmd>GoDocBrowser<CR>", "Go Doc Browser")
        map("n", "<leader>gI", "<cmd>GoImpl<CR>", "Implement Interface")

        -- Generation
        map("n", "<leader>gG", "<cmd>GoGenerate<CR>", "Generate")
        map("n", "<leader>gm", "<cmd>GoMockGen<CR>", "Generate Mocks")
      end,
    })

    vim.notify("go.nvim configured successfully", vim.log.levels.INFO, { title = "go.nvim" })
  end,
}
