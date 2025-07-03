-- lua/plugins/go.lua

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
        local go = require("go")
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        local ok, cmp = pcall(require, "blink.cmp")
        if ok then
            capabilities = cmp.get_lsp_capabilities(capabilities)
        end

        go.setup({
            lsp_cfg = false, -- LSP is globally configured
            lsp_gofumpt = true,
            lsp_codelens = true,
            lsp_inlay_hints = {
                enable = true,
                only_current_line = false,
                parameter_hints_prefix = "󰊕 ",
                other_hints_prefix = "=> ",
                show_parameter_hints = true,
                show_variable_name = true,
            },
            go_capabilities = capabilities,
            test_runner = "go",
            test_timeout = "30s",
            gofmt = "gofumpt",
            max_line_len = 120,
            test_env = {},
            coverage = { sign = "█", sign_covered = "█" },
        })

        local aug = vim.api.nvim_create_augroup("GoKeymaps", { clear = true })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "go", "gomod", "gosum", "gotmpl" },
            group = aug,
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true, noremap = true }
                local map = function(m, l, r, d)
                    vim.keymap.set(m, l, r, vim.tbl_extend("force", opts, { desc = "Go: " .. d }))
                end

                -- Common Go actions
                map("n", "<leader>ga", "<cmd>GoAlt<CR>", "Alternate file")
                map("n", "<leader>oi", "<cmd>GoImports<CR>", "Organize imports")
                map("n", "<leader>om", "<cmd>GoModTidy<CR>", "Mod tidy")

                -- Generate
                map("n", "<leader>gs", "<cmd>GoFillStruct<CR>", "Fill struct")
                map("n", "<leader>gj", "<cmd>GoJson2Struct<CR>", "JSON → struct")
                map("n", "<leader>gI", "<cmd>GoImpl<CR>", "Implement interface")

                -- Tags
                map({ "n", "v" }, "<leader>gta", "<cmd>GoAddTag<CR>", "Add tags")
                map({ "n", "v" }, "<leader>gtr", "<cmd>GoRmTag<CR>", "Remove tags")

                -- Run / Build
                map("n", "<leader>bb", "<cmd>GoBuild<CR>", "Build")
                map("n", "<leader>gx", "<cmd>GoRun %<CR>", "Run file")

                -- Testing
                map("n", "<leader>ta", "<cmd>GoTest<CR>", "Test all")
                map("n", "<leader>tf", "<cmd>GoTestFunc<CR>", "Test function")
                map("n", "<leader>tp", "<cmd>GoTestPkg<CR>", "Test package")
                map("n", "<leader>gat", "<cmd>GoAddTest<CR>", "Add test")

                -- Coverage
                map("n", "<leader>tc", "<cmd>GoCoverage<CR>", "Coverage")
                map("n", "<leader>tC", "<cmd>GoCoverageToggle<CR>", "Toggle coverage")

                -- Lint / Docs
                map("n", "<leader>gv", "<cmd>GoVet<CR>", "Go vet")
                map("n", "<leader>gd", "<cmd>GoDoc<CR>", "Documentation")

                -- DAP support (if loaded)
                if package.loaded["dap-go"] then
                    map("n", "<leader>gdt", "<cmd>lua require('dap-go').debug_test()<CR>", "Debug test")
                end
            end,
        })

        -- Custom user commands
        vim.api.nvim_create_user_command("GoWorkspace", function()
            vim.cmd("GoModTidy | GoImports | GoGenerate")
        end, { desc = "Go: Workspace maintenance" })

        vim.api.nvim_create_user_command("GoQuickTest", function()
            vim.cmd("GoTestPkg -short")
        end, { desc = "Go: Quick test" })

        vim.api.nvim_create_user_command("GoBenchmark", function()
            vim.cmd("GoTest -bench=.")
        end, { desc = "Go: Benchmark" })
    end,
}
