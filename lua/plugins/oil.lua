return {
    "stevearc/oil.nvim", -- Plugin: oil.nvim (A modern and customizable file explorer, intended as a replacement for netrw).
    opts = {
        default_file_explorer = true, -- When a directory is opened (e.g., using `:e .`), use oil.nvim instead of the default netrw.
        float = {                     -- Configuration options for the floating oil.nvim window.
            padding = 2,               -- Padding around the floating window.
            max_width = 100,           -- Maximum width of the floating window (in characters).
            max_height = 30,           -- Maximum height of the floating window (in lines).
            border = "rounded",        -- Use rounded borders for the floating window.
            win_options = {            -- Window options specifically for the floating window.
                winblend = 0,          -- Set the `winblend` option to 0, making the floating window fully opaque (no transparency).
            },
        },
        view_options = {
            show_hidden = true,      -- Show hidden files and directories (those starting with a dot, e.g., `.git`).
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional dependency: nvim-web-devicons for displaying file icons in the explorer.
    config = function(_, opts)
        require("oil").setup(opts) -- Call the setup function for oil.nvim with the provided options.

        -- Keymap to open oil.nvim in a floating window.
        vim.keymap.set("n", "-", function()
            require("oil").open_float() -- Call the function to open oil.nvim in a floating window.
        end, { desc = "Open Oil File Manager (float)", silent = true }) -- Description for which-key and prevent command echo.
    end,
}