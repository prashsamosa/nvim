return {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" }, -- Load for Elixir files
    config = function()
        local elixir = require("elixir")

        elixir.setup({
            -- Let lsp.lua handle elixirls configuration
            -- elixirls = { enable = false }, -- Or simply remove the elixirls table

            -- Keep other elixir-tools features if needed
            nextls = { enable = true },        -- Example: If you use Next LS features
            projectionist = { enable = true }, -- Example: If you use projectionist features

            -- Keymaps for elixir-tools commands (can also be set globally if preferred)
            -- These commands are provided by elixir-tools regardless of LSP setup
            vim.keymap.set("n", "<leader>Fp", ":ElixirFromPipe<CR>", { desc = "[E]lixir [F]rom [P]ipe", silent = true }),
            vim.keymap.set("n", "<leader>Tp", ":ElixirToPipe<CR>", { desc = "[E]lixir [T]o [P]ipe", silent = true }),
            vim.keymap.set("v", "<leader>Em", ":ElixirExpandMacro<CR>",
            { desc = "[E]lixir [E]xpand [M]acro", silent = true }),
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- Add mason.nvim as a dependency if elixir-tools needs it for installation checks
        "williamboman/mason.nvim",
    },
}
