return {
    "stevearc/oil.nvim", -- Modern file explorer to replace netrw.
    opts = {
        default_file_explorer = true, -- Use oil as the default when opening directories.
        float = {
            padding = 2,
            max_width = 100,
            max_height = 30,
            border = "rounded",
            win_options = {
                winblend = 0, -- Make the floating window opaque.
            },
        },
        view_options = {
            show_hidden = true, -- Show dotfiles.
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional: For file icons.
    config = function(_, opts)
        require("oil").setup(opts)

        -- Keymap to open oil in a floating window.
        vim.keymap.set("n", "-", function()
            require("oil").open_float()
        end, { desc = "Open Oil File Manager (float)", silent = true })
    end,
}