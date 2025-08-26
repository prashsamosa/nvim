return {
    { "echasnovski/mini.nvim", version = false },

    {
        "echasnovski/mini.ai",
        version = false,
        event = "VeryLazy",
        config = function()
            local ai = require("mini.ai")
            ai.setup({
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
                },
            })
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
                    find = "gsf",
                    find_left = "gsF",
                    highlight = "gsh",
                    replace = "gsr",
                    update_n_lines = "gsn",
                },
            })
        end,
    },

    {
        "echasnovski/mini.pairs",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.pairs").setup({
                modes = { insert = true, command = true, terminal = false },
            })
        end,
    },

    {
        "echasnovski/mini.bracketed",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.bracketed").setup({
                buffer = { suffix = "b" },
                comment = { suffix = "c" },
                diagnostic = { suffix = "d" },
                file = { suffix = "f" },
                quickfix = { suffix = "q" },
            })
        end,
    },

    {
        "echasnovski/mini.indentscope",
        version = false,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("mini.indentscope").setup({
                draw = { delay = 100, animation = require("mini.indentscope").gen_animation.none() },
                mappings = {
                    object_scope = "ii",
                    object_scope_with_border = "ai",
                    goto_top = "[i",
                    goto_bottom = "]i",
                },
                symbol = "╎",
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "help", "dashboard", "lazy", "mason", "notify", "snacks_dashboard" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
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
            require("mini.move").setup({
                mappings = {
                    left = "<A-h>",
                    right = "<A-l>",
                    down = "<A-j>",
                    up = "<A-k>",
                    line_left = "<A-h>",
                    line_right = "<A-l>",
                    line_down = "<A-j>",
                    line_up = "<A-k>",
                },
            })
        end,
    },

    {
        "echasnovski/mini.splitjoin",
        version = false,
        keys = { "gS" },
        config = function()
            require("mini.splitjoin").setup({ mappings = { toggle = "gS" } })
        end,
    },
}
