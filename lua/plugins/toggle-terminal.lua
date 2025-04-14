-- Configure 'toggleterm.nvim' for a toggleable terminal in Neovim.

return {
    "akinsho/toggleterm.nvim",
    version = "*", -- Use the latest version of the plugin.
    keys = {
        { "<C-\\>", desc = "Toggle Terminal" }, -- Default toggle key.
        { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (float)" },
        { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal (horizontal)" },
        { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Terminal (vertical)" },
        { "<leader>tl", "<cmd>ToggleTermSendCurrentLine<cr>", desc = "Send current line to terminal" },
        { "<leader>ts", "<cmd>TermSelect<cr>", desc = "Select terminal" },
    },
    opts = {
        open_mapping = [[<C-\>]], -- Key mapping to open the terminal.
        direction = "float", -- Default terminal direction is floating.
        float_opts = {
            border = "curved", -- Curved borders for the floating terminal.
            winblend = 0, -- Fully opaque floating window.
        },
        size = function(term)
            if term.direction == "horizontal" then
                return 15 -- Height for horizontal terminal.
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4 -- Width for vertical terminal (40% of editor width).
            end
        end,
    },
}