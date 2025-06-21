return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "L3MON4D3/LuaSnip", 
  },
  config = function()
    -- Get capabilities for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if package.loaded["blink.cmp"] then
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      vim.notify("Using capabilities from blink.cmp", vim.log.levels.INFO, { title = "go.nvim" })
    else
      vim.notify("blink.cmp not loaded, using default LSP capabilities", vim.log.levels.WARN, { title = "go.nvim" })
    end

    -- Check if LuaSnip is available
    local luasnip_available = pcall(require, "luasnip")
    if luasnip_available then
      vim.notify("LuaSnip module loaded successfully", vim.log.levels.INFO, { title = "go.nvim" })
    else
      vim.notify("LuaSnip module not available, snippets disabled", vim.log.levels.WARN, { title = "go.nvim" })
    end

    -- Setup go.nvim
    require("go").setup({
      -- Disable go.nvim's LSP management since we handle it in lspconfig
      lsp_cfg = false,
      -- Keep other LSP features enabled
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

      -- Diagnostics
      diagnostic = {
        hdlr = false, -- Let LSP handle diagnostics
        underline = true,
        virtual_text = { space = 0, prefix = "■" },
        signs = true,
        update_in_insert = false,
      },

      -- Test configuration
      test_runner = "go",
      run_in_floaterm = false,

      -- Build tags
      build_tags = "",

      -- Icons
      icons = {
        breakpoint = "🧘",
        currentpos = "🏃",
      },

      -- Trouble integration
      trouble = true,

      -- Luasnip integration - only enable if available
      luasnip = luasnip_available,
    })

    -- Go-specific keymaps
    local augroup = vim.api.nvim_create_augroup("GoUserKeymaps", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "go", "gomod" },
      group = augroup,
      callback = function(ev)
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        local map = function(mode, keys, cmd, desc)
          vim.keymap.set(mode, keys, cmd, vim.tbl_extend("force", bufopts, { desc = "Go: " .. desc }))
        end

        -- File operations
        map("n", "<leader>ga", "<cmd>GoAlt<CR>", "Alternate File")
        map("n", "<leader>gvs", "<cmd>GoAltV<CR>", "Alternate Vertical")
        map("n", "<leader>ghs", "<cmd>GoAltS<CR>", "Alternate Horizontal")

        -- Code generation and formatting
        map("n", "<leader>oi", "<cmd>GoImports<CR>", "Go Imports")
        map("n", "<leader>of", "<cmd>GoFmt<CR>", "Go Format")
        map("n", "<leader>ot", "<cmd>GoModTidy<CR>", "Go Mod Tidy")
        map("n", "<leader>gc", "<cmd>GoCmt<CR>", "Generate Comment")
        map("n", "<leader>gs", "<cmd>GoFillStruct<CR>", "Fill Struct")
        map("n", "<leader>gr", "<cmd>GoGenReturn<CR>", "Generate Return")
        map("n", "<leader>gj", "<cmd>GoJson2Struct<CR>", "JSON to Struct")

        -- Tags (Fixed keymap conflicts)
        map("n", "<leader>gta", "<cmd>GoAddTag<CR>", "Add Tags")
        map("n", "<leader>gtr", "<cmd>GoRmTag<CR>", "Remove Tags")
        map("v", "<leader>gta", "<cmd>GoAddTag<CR>", "Add Tags")
        map("v", "<leader>gtr", "<cmd>GoRmTag<CR>", "Remove Tags")

        -- Build and run
        map("n", "<leader>bb", "<cmd>GoBuild<CR>", "Go Build")
        map("n", "<leader>br", "<cmd>GoRun<CR>", "Go Run")
        map("n", "<leader>gx", "<cmd>GoRun %<CR>", "Run Current File")

        -- Testing (Fixed keymap conflicts)
        map("n", "<leader>tp", "<cmd>GoTestPkg<CR>", "Test Package")
        map("n", "<leader>tf", "<cmd>GoTestFunc<CR>", "Test Function")
        map("n", "<leader>tF", "<cmd>GoTestFile<CR>", "Test File")
        map("n", "<leader>gat", "<cmd>GoAddTest<CR>", "Add Test")
        map("n", "<leader>get", "<cmd>GoAddExpTest<CR>", "Add Example Test")

        -- Coverage
        map("n", "<leader>tc", "<cmd>GoCoverage<CR>", "Coverage")
        map("n", "<leader>tC", "<cmd>GoCoverageToggle<CR>", "Toggle Coverage")
        map("n", "<leader>gcb", "<cmd>GoCoverageBrowser<CR>", "Coverage Browser")

        -- Linting and checking
        map("n", "<leader>gL", "<cmd>GoLint<CR>", "Go Lint")
        map("n", "<leader>gV", "<cmd>GoVet<CR>", "Go Vet")

        -- Documentation and interfaces
        map("n", "<leader>gD", "<cmd>GoDoc<CR>", "Go Doc")
        map("n", "<leader>gDb", "<cmd>GoDocBrowser<CR>", "Go Doc Browser")
        map("n", "<leader>gI", "<cmd>GoImpl<CR>", "Implement Interface")

        -- Code generation
        map("n", "<leader>gg", "<cmd>GoGenerate<CR>", "Go Generate")
        map("n", "<leader>gm", "<cmd>GoMockGen<CR>", "Generate Mocks")
      end,
    })

    vim.notify("go.nvim configured successfully", vim.log.levels.INFO, { title = "go.nvim" })
  end,
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
}
