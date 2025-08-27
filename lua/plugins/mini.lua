return {
    {
        "echasnovski/mini.ai",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.ai").setup()
        end,
    },

    {
        "echasnovski/mini.surround",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup({
                mappings = {
                    add = "gsa",
                    delete = "gsd",
                    replace = "gsr",
                },
            })
        end,
    },

    {
        "echasnovski/mini.pairs",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.pairs").setup()
        end,
    },

    -- Remove mini.indentscope since snacks.indent is better
    -- {
    --     "echasnovski/mini.indentscope",
    --     version = false,
    --     event = { "BufReadPre", "BufNewFile" },
    --     config = function()
    --         require("mini.indentscope").setup({
    --             symbol = "╎",
    --             draw = { animation = require("mini.indentscope").gen_animation.none() },
    --         })
    --     end,
    -- },

    {
        "echasnovski/mini.move",
        version = false,
        keys = {
            { "<A-h>", mode = { "n", "v" } },
            { "<A-j>", mode = { "n", "v" } },
            { "<A-k>", mode = { "n", "v" } },
            { "<A-l>", mode = { "n", "v" } },
        },
        config = function()
            require("mini.move").setup()
        end,
    },

    -- Add missing mini plugins that complement snacks
    {
        "echasnovski/mini.splitjoin",
        version = false,
        keys = { "gS" },
        config = function()
            require("mini.splitjoin").setup({
                mappings = {
                    toggle = "gS",
                },
            })
        end,
    },

    {
        "echasnovski/mini.align",
        version = false,
        keys = { { "ga", mode = { "n", "v" } } },
        config = function()
            require("mini.align").setup()
        end,
    },

    {
        "echasnovski/mini.bracketed",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.bracketed").setup({
                -- Disable some that might conflict
                comment = { suffix = "" },    -- Disable comment navigation
                conflict = { suffix = "" },   -- Disable conflict navigation
                diagnostic = { suffix = "" }, -- We have LSP mappings
                file = { suffix = "f" },
                indent = { suffix = "i" },
                jump = { suffix = "j" },
                location = { suffix = "l" },
                oldfile = { suffix = "o" },
                quickfix = { suffix = "q" },
                treesitter = { suffix = "t" },
                undo = { suffix = "u" },
                window = { suffix = "w" },
                yank = { suffix = "y" },
            })
        end,
    },

    {
        "echasnovski/mini.operators",
        version = false,
        keys = {
            { "g=", desc = "Evaluate" },
            { "gx", desc = "Exchange" },
            { "gm", desc = "Multiply" },
            { "gr", desc = "Replace" },
            { "gs", desc = "Sort" },
        },
        config = function()
            require("mini.operators").setup({
                -- Evaluate text and replace with output
                evaluate = {
                    prefix = "g=",
                },
                -- Exchange text regions
                exchange = {
                    prefix = "gx",
                },
                -- Multiply (duplicate) text
                multiply = {
                    prefix = "gm",
                },
                -- Replace text with register
                replace = {
                    prefix = "gr",
                },
                -- Sort text
                sort = {
                    prefix = "gs",
                },
            })
        end,
    },
}
