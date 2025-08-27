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

    {
        "echasnovski/mini.indentscope",
        version = false,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("mini.indentscope").setup({
                symbol = "╎",
                draw = { animation = require("mini.indentscope").gen_animation.none() },
            })
        end,
    },

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
}
