return {
    "stevearc/oil.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",

    opts = {
        default_file_explorer = true,
        float = {
            padding = 2,
            max_width = 100,
            max_height = 30,
            border = "rounded",
        },
        view_options = { show_hidden = true },
    },

    config = function(_, opts)
        require("oil").setup(opts)
        vim.keymap.set("n", "-", function() require("oil").open_float() end, { desc = "Open File Manager" })
    end,
}
