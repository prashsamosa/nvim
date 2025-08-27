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
            lsp_cfg = false,
            lsp_gofumpt = true,
            lsp_codelens = true,
            lsp_inlay_hints = { enable = true },
            dap_debug = false,
            luasnip = false,   -- We use blink.cmp
            gofmt = "gofumpt",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "go", "gomod", "gosum", "gotmpl" },
            callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "<leader>ga", "<cmd>GoAlt<CR>",
                    vim.tbl_extend("force", opts, { desc = "Go: Alt file" }))
                vim.keymap.set("n", "<leader>gi", "<cmd>GoImports<CR>",
                    vim.tbl_extend("force", opts, { desc = "Go: Imports" }))
                vim.keymap.set("n", "<leader>gb", "<cmd>GoBuild<CR>",
                    vim.tbl_extend("force", opts, { desc = "Go: Build" }))
                vim.keymap.set("n", "<leader>gr", "<cmd>GoRun %<CR>", vim.tbl_extend("force", opts, { desc = "Go: Run" }))
                vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<CR>", vim.tbl_extend("force", opts, { desc = "Go: Test" }))
            end,
        })
    end,
}
