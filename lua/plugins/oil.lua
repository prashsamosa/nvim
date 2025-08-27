return {
    "stevearc/oil.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",

    opts = {
        default_file_explorer = true,
        delete_to_trash = true,           -- Safer file deletion
        skip_confirm_for_simple_edits = true, -- Better UX
        float = {
            padding = 2,
            max_width = 100,
            max_height = 30,
            border = "rounded",
        },
        -- view_options = { show_hidden = true },
        view_options = {
            show_hidden = true,
            natural_order = true, -- Better file sorting
            case_insensitive = false,
        },
    },

    config = function(_, opts)
        require("oil").setup(opts)
        vim.keymap.set("n", "-", function() require("oil").open_float() end, { desc = "Open File Manager" })
    end,
}
