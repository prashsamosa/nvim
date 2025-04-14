return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit", -- Load only when the command is used
    keys = {
        { "<leader>gn", "<cmd>Neogit<CR>", desc = "Open Neogit" },
    },
    opts = {
        kind = "split", -- Open in split view
        signs = {
            section = { "", "" }, -- No signs for sections
            item = { "▸", "▾" }, -- Nicer item symbols
        },
        integrations = {
            diffview = true, -- Use diffview for diffs
            telescope = true, -- Use telescope for fuzzy finding
        },
        disable_commit_confirmation = true, -- Don't confirm commits
        disable_context_highlighting = false, -- Keep context highlighting
        disable_signs = false, -- Keep signs
        telescope_sorter = function()
            return require("telescope").extensions.fzf.native_fzf_sorter()
        end,
        -- Match your Github theme colors
        sections = {
            -- customize section separator colors
            unstaged = {
                folded = false, -- Start with unstaged section unfolded
            },
            staged = {
                folded = false, -- Start with staged section unfolded
            },
        },
    },
}