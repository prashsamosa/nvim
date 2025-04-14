return {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
        { "<C-\\>", desc = "Toggle Terminal" },
        { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (float)" },
        { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal (horizontal)" },
        { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Terminal (vertical)" },
        { "<leader>tl", "<cmd>ToggleTermSendCurrentLine<cr>", desc = "Send current line to terminal" },
        { "<leader>ts", "<cmd>TermSelect<cr>", desc = "Select terminal" },
    },
    opts = {
        open_mapping = [[<C-\>]],
        direction = 'float',
        float_opts = {
            border = 'curved',
            winblend = 0,
        },
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
    },
}
