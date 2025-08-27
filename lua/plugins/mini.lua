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
                evaluate = { prefix = "g=" },
                exchange = { prefix = "gx" },
                multiply = { prefix = "gm" },
                replace = { prefix = "gr" },
                sort = { prefix = "gs" },
            })
        end,
    },

    {
        "echasnovski/mini.sessions",
        version = false,
        lazy = false,
        config = function()
            require("mini.sessions").setup({
                autoread = false,
                autowrite = true,
                directory = vim.fn.stdpath('data') .. '/sessions/',
                file = 'Session.vim',
            })
        end,
        keys = {
            -- Fixed: Reorganized session keys to avoid conflicts with snacks scratch
            { "<leader>ss", function() require("mini.sessions").write() end,                                          desc = "Save Session" },
            { "<leader>sr", function() require("mini.sessions").read() end,                                           desc = "Read Session" },
            { "<leader>sd", function() require("mini.sessions").delete() end,                                         desc = "Delete Session" },
            { "<leader>sl", function() require("mini.sessions").select() end,                                         desc = "Select Session" },
            { "<leader>sc", function() require("mini.sessions").write(vim.fn.input("Session name: ")) end,            desc = "Save Named Session" },
            { "<leader>s.", function() require("mini.sessions").write(vim.fn.fnamemodify(vim.fn.getcwd(), ":t")) end, desc = "Save Dir Session" },
        },
    },
}
