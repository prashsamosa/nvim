-- Configure various 'mini.nvim' utility plugins by echasnovski.

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
        lazy = false, -- Load immediately as commenting is frequently used.
        opts = {
            options = {
                ignore_blank_line = false,
                start_of_line = false,
                pad_comment_parts = true,
            },
            mappings = {
                comment = "gc", -- Toggle comment for the current line or selection.
                comment_line = "gcc", -- Comment out the current line.
                textobject = "gc", -- Comment text objects (e.g., `gcip` for inner paragraph).
            },
        },
        desc = "Smart code commenting using mini.comment",
    },

    -- Enhanced text objects.
    {
        "echasnovski/mini.ai",
        version = false,
        config = function()
            require("mini.ai").setup() -- Additional and improved text objects.
        end,
    },

    -- Surround management.
    {
        "echasnovski/mini.surround",
        version = false,
        config = function()
            require("mini.surround").setup() -- Easy manipulation of surrounding characters.
        end,
    },

    -- Text editing operators.
    {
        "echasnovski/mini.operators",
        version = false,
        config = function()
            require("mini.operators").setup() -- New text editing operators (e.g., move lines).
        end,
    },

    -- Matching pair handling.
    {
        "echasnovski/mini.pairs",
        version = false,
        config = function()
            require("mini.pairs").setup() -- Enhanced handling of matching pairs.
        end,
    },

    -- Bracketed text navigation.
    {
        "echasnovski/mini.bracketed",
        version = false,
        config = function()
            require("mini.bracketed").setup() -- Navigation based on brackets and paired characters.
        end,
    },

    -- Buffer removal.
    {
        "echasnovski/mini.bufremove",
        version = false,
        config = function()
            vim.keymap.set("n", "<leader>mb", function()
                require("mini.bufremove").delete(0, false) -- Delete current buffer without forcing.
            end, { desc = "Mini delete buffer" })

            vim.keymap.set("n", "<leader>mB", function()
                require("mini.bufremove").delete(0, true) -- Force delete current buffer.
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
                require("mini.files").open() -- Open the mini.files file explorer.
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
                require("mini.pick").builtin.files() -- Open fuzzy file finder.
            end, { desc = "Mini pick files" })

            vim.keymap.set("n", "<leader>mg", function()
                require("mini.pick").builtin.grep_live() -- Open live grep fuzzy finder.
            end, { desc = "Mini grep live" })
        end,
    },

    -- Notifications.
    {
        "echasnovski/mini.notify",
        version = false,
        event = "VeryLazy", -- Load lazily as notifications might not be immediately needed.
        config = function()
            local has_winblend = pcall(function()
                local win_id = vim.api.nvim_open_win(0, false, {
                    relative = "editor",
                    width = 1,
                    height = 1,
                    row = 0,
                    col = 0,
                    style = "minimal",
                    winblend = 0,
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
                    default_timeout_ms = 5000, -- Default duration for notifications.
                },
                lsp_progress = {
                    enable = true, -- Enable LSP progress notifications.
                    duration_ms = 500,
                },
            }

            if has_winblend then
                config.window.config.winblend = 0 -- Set winblend to 0 if supported.
            end

            require("mini.notify").setup(config)
            vim.notify = require("mini.notify").make_notify() -- Override vim.notify.
        end,
    },

    -- Session management.
    {
        "echasnovski/mini.sessions",
        version = false,
        lazy = false, -- Load immediately for session management.
        config = function()
            require("mini.sessions").setup({
                autoread = true, -- Automatically read the last session on startup.
                autowrite = true, -- Automatically write the current session on exit.
                directory = vim.fn.stdpath("data") .. "/sessions", -- Directory for session files.
                file = "Session.vim", -- Default session filename.
                verbose = { read = false, write = true, delete = true },
            })

            vim.keymap.set("n", "<leader>ms", function()
                require("mini.sessions").write(nil) -- Write the current session.
            end, { desc = "Write Session" })

            vim.keymap.set("n", "<leader>mr", function()
                require("mini.sessions").read(nil) -- Read the last saved session.
            end, { desc = "Read Last Session" })

            vim.keymap.set("n", "<leader>md", function()
                require("mini.sessions").delete(nil) -- Delete the last saved session.
            end, { desc = "Delete Last Session" })
        end,
    },

    -- Indentation scope lines.
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = "VeryLazy", -- Load lazily as it's a visual aid.
        config = function()
            require("mini.indentscope").setup({
                draw = {
                    delay = 100, -- Delay before drawing lines.
                    animation = require("mini.indentscope").gen_animation.none(), -- Disable animation.
                },
                symbol = "╎", -- Symbol for indentation scope lines.
            })
        end,
    },
}