-- Configure 'elixir-tools.nvim' for Elixir development support.
-- This plugin provides various Elixir-specific features.

return {
    "elixir-tools/elixir-tools.nvim",
    version = "*", -- Use the latest version
    event = { "BufReadPre", "BufNewFile" }, -- Load when opening or creating Elixir files
    config = function()
        local elixir = require("elixir")

        elixir.setup({
            -- LSP configuration is handled in lsp.lua to avoid conflicts.
            -- elixirls = { enable = false }, -- Uncomment to disable elixirls managed by this plugin

            -- Enable other Elixir Tools features as needed.
            nextls = { enable = true },       -- Features related to Next LS (if used).
            projectionist = { enable = true }, -- Integration with Projectionist (if used).

            -- Keymaps for Elixir Tools commands.
            -- These commands are available regardless of the LSP setup.
            vim.keymap.set("n", "<leader>Fp", ":ElixirFromPipe<CR>",
                { desc = "[E]lixir [F]rom [P]ipe", silent = true }),
            vim.keymap.set("n", "<leader>Tp", ":ElixirToPipe<CR>",
                { desc = "[E]lixir [T]o [P]ipe", silent = true }),
            vim.keymap.set("v", "<leader>Em", ":ElixirExpandMacro<CR>",
                { desc = "[E]lixir [E]xpand [M]acro", silent = true }),
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required dependency for many Lua-based plugins.
        "williamboman/mason.nvim", -- Dependency for managing language servers and tools.
    },
}