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
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local ok, blink = pcall(require, "blink.cmp")
        if ok then
            capabilities = blink.get_lsp_capabilities(capabilities)
        end

        require("go").setup({
            lsp_cfg = false,
            lsp_gofumpt = true,
            lsp_codelens = true,
            lsp_inlay_hints = { enable = true },
            go_capabilities = capabilities,
            gofmt = "gofumpt",
            max_line_len = 120,
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "go", "gomod", "gosum", "gotmpl" },
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }
                local map = function(m, l, r, d)
                    vim.keymap.set(m, l, r, vim.tbl_extend("force", opts, { desc = "Go: " .. d }))
                end

                map("n", "<leader>ga", "<cmd>GoAlt<CR>", "Alternate file")
                map("n", "<leader>gi", "<cmd>GoImports<CR>", "Organize imports")
                map("n", "<leader>gm", "<cmd>GoModTidy<CR>", "Mod tidy")
                map("n", "<leader>gs", "<cmd>GoFillStruct<CR>", "Fill struct")
                map("n", "<leader>gI", "<cmd>GoImpl<CR>", "Implement interface")
                map("n", "<leader>gb", "<cmd>GoBuild<CR>", "Build package")
                map("n", "<leader>gx", "<cmd>GoRun %<CR>", "Run current file")
                map("n", "<leader>gta", "<cmd>GoTest<CR>", "Test all")
                map("n", "<leader>gtf", "<cmd>GoTestFunc<CR>", "Test function")
                map("n", "<leader>gtc", "<cmd>GoCoverage<CR>", "Show coverage")
                map("n", "<leader>gv", "<cmd>GoVet<CR>", "Go vet")
            end,
        })
    end,
}
