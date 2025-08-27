-- lua/plugins/barbar.lua
return {
    "romgrk/barbar.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "lewis6991/gitsigns.nvim",
    },
    event = "BufReadPost",

    -- IMPORTANT: disable barbar's auto-setup, lazy.nvim will call setup with opts
    init = function()
        vim.g.barbar_auto_setup = false

        -- Alt+[1-9] = jump to buffer
        for i = 1, 9 do
            vim.keymap.set("n", ("<A-%d>"):format(i), ("<cmd>BufferGoto %d<cr>"):format(i))
        end
        -- Alt+0 = last buffer
        vim.keymap.set("n", "<A-0>", "<cmd>BufferLast<cr>")
    end,

    keys = {
        { "<A-,>",      "<cmd>BufferPrevious<cr>",                   desc = "Prev buffer" },
        { "<A-.>",      "<cmd>BufferNext<cr>",                       desc = "Next buffer" },
        { "<A-S-,>",    "<cmd>BufferMovePrevious<cr>",               desc = "Move buffer left" },
        { "<A-S-.>",    "<cmd>BufferMoveNext<cr>",                   desc = "Move buffer right" },
        { "<A-p>",      "<cmd>BufferPin<cr>",                        desc = "Pin buffer" },
        { "<leader>bO", "<cmd>BufferCloseAllButCurrentOrPinned<cr>", desc = "Close all but current/pinned" },
    },

    opts = {
        animation = true,
        auto_hide = true,
        clickable = true,
        insert_at_end = true,
        maximum_padding = 1,
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
