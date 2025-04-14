-- Configure various 'mini.nvim' utility plugins by echasnovski.
-- These plugins provide enhanced functionalities for text editing, workflow, and UI.

return {
    -- Core mini.nvim library (foundation for other mini.* plugins).
    {
        "echasnovski/mini.nvim",
        version = false, -- Always use the latest version.
    },

    -- Smart code commenting.
    {
        "echasnovski/mini.comment",
        version = false,
        lazy = false,
        opts = {
            options = {
                custom_commentstring = nil,
                ignore_blank_line = false,
                start_of_line = false,
                pad_comment_parts = true,
            },
            mappings = {
                comment = "gc",
                comment_line = "gcc",
                comment_visual = "gc",
                textobject = "gc",
            },
            hooks = {
                pre = function() end,
                post = function() end,
            },
        },
        desc = "Smart code commenting using mini.comment",
    },

    -- Enhanced text objects.
    {
        "echasnovski/mini.ai",
        version = false,
        config = function()
            require("mini.ai").setup()
        end,
    },

    -- Surround management.
    {
        "echasnovski/mini.surround",
        version = false,
        config = function()
            require("mini.surround").setup()
        end,
    },

    -- Text editing operators.
    {
        "echasnovski/mini.operators",
        version = false,
        config = function()
            require("mini.operators").setup()
        end,
    },

    -- Matching pair handling.
    {
        "echasnovski/mini.pairs",
        version = false,
        config = function()
            require("mini.pairs").setup()
        end,
    },

    -- Bracketed text navigation.
    {
        "echasnovski/mini.bracketed",
        version = false,
        config = function()
            require("mini.bracketed").setup()
        end,
    },

    -- Buffer removal.
    {
        "echasnovski/mini.bufremove",
        version = false,
        config = function()
            vim.keymap.set("n", "<leader>mb", function()
                require("mini.bufremove").delete(0, false)
            end, { desc = "Mini delete buffer" })

            vim.keymap.set("n", "<leader>mB", function()
                require("mini.bufremove").delete(0, true)
            end, { desc = "Mini force delete buffer" })
        end,
    },

    -- File explorer.
    {
        "echasnovski/mini.files",
        version = false,
        config = function()
            require("mini.files").setup()
            vim.keymap.set("n", "<leader>me", function()
                require("mini.files").open()
            end, { desc = "Mini file explorer" })
        end,
    },

    -- Fuzzy picker.
    {
        "echasnovski/mini.pick",
        version = false,
        config = function()
            require("mini.pick").setup()
            vim.keymap.set("n", "<leader>mp", function()
                require("mini.pick").builtin.files()
            end, { desc = "Mini pick files" })

            vim.keymap.set("n", "<leader>mg", function()
                require("mini.pick").builtin.grep_live()
            end, { desc = "Mini grep live" })
        end,
    },

    -- Notifications.
    {
        "echasnovski/mini.notify",
        version = false,
        event = "VeryLazy",
        config = function()
            local has_winblend = pcall(function()
                local win_id = vim.api.nvim_open_win(0, false, {
                    relative = "editor", width = 1, height = 1, row = 0, col = 0, style = "minimal", winblend = 0
                })
                vim.api.nvim_win_close(win_id, true)
                return true
            end)

            local config = {
                window = {
                    config = {
                        border = "rounded",
                        width = 60,
                    },
                },
                content = {
                    default_timeout_ms = 5000,
                },
                lsp_progress = {
                    enable = true,
                    duration_ms = 500,
                },
            }

            if has_winblend then
                config.window.config.winblend = 0
            end

            require("mini.notify").setup(config)
            vim.notify = require("mini.notify").make_notify()
        end,
    },

    -- Session management.
    {
        "echasnovski/mini.sessions",
        version = false,
        lazy = false,
        config = function()
            require("mini.sessions").setup({
                autoread = true,
                autowrite = true,
                directory = vim.fn.stdpath("data") .. "/sessions",
                file = "Session.vim",
                force = { read = false, write = true, delete = false },
                verbose = { read = false, write = true, delete = true },
            })

            vim.keymap.set("n", "<leader>ms", function()
                require("mini.sessions").write(nil)
            end, { desc = "Write Session" })

            vim.keymap.set("n", "<leader>mr", function()
                require("mini.sessions").read(nil)
            end, { desc = "Read Last Session" })

            vim.keymap.set("n", "<leader>md", function()
                require("mini.sessions").delete(nil)
            end, { desc = "Delete Last Session" })
        end,
    },

    -- Indentation scope lines.
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = "VeryLazy",
        config = function()
            local indentscope = require("mini.indentscope")
            indentscope.setup({
                draw = {
                    delay = 100,
                    animation = indentscope.gen_animation.linear({ easing = "in", duration = 20, unit = "step" }),
                    predicate = function(scope) return not scope.body.is_incomplete end,
                    priority = 2,
                },
                mappings = {
                    object_scope = "ii",
                    object_scope_with_border = "ai",
                    goto_top = "[i",
                    goto_bottom = "]i",
                },
                options = {
                    border = "both",
                    indent_at_cursor = true,
                    n_lines = 10000,
                    try_as_border = false,
                },
                symbol = "╎",
            })
        end,
    },
}
