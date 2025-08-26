return {
    "romgrk/barbar.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "lewis6991/gitsigns.nvim",
    },
    event = "BufReadPost",

    keys = {
        { "<A-,>",      "<cmd>BufferPrevious<cr>" },
        { "<A-.>",      "<cmd>BufferNext<cr>" },
        { "<A-S-,>",    "<cmd>BufferMovePrevious<cr>" },
        { "<A-S-.>",    "<cmd>BufferMoveNext<cr>" },
        { "<A-p>",      "<cmd>BufferPin<cr>" },
        { "<leader>bO", "<cmd>BufferCloseAllButCurrentOrPinned<cr>" },
    },

    init = function()
        for i = 1, 9 do
            vim.keymap.set("n", ("<A-%d>"):format(i), ("<cmd>BufferGoto %d<cr>"):format(i))
        end
        vim.keymap.set("n", "<A-0>", "<cmd>BufferLast<cr>")
    end,

    opts = {
        auto_hide = true,
        clickable = true,
        insert_at_end = true,
        icons = {
            buffer_index = true,
            button = "×",
            filetype = { enabled = true },
            separator = { left = "▎", right = "" },
            gitsigns = {
                added = { enabled = true, icon = "+" },
                changed = { enabled = true, icon = "~" },
                deleted = { enabled = true, icon = "-" },
            },
        },
    },
}
