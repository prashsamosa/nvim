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
        lazy = false, -- Load immediately for essential commenting functionality.
        opts = {
            options = {
                custom_commentstring = nil, -- Custom comment strings per filetype (function).
                ignore_blank_line = false,  -- Don't comment on blank lines.
                start_of_line = false,    -- Always comment at the start of the line.
                pad_comment_parts = true, -- Add spaces around comment delimiters.
            },
            mappings = {
                comment = "gc",         -- Toggle comment for selection (line/visual).
                comment_line = "gcc",    -- Toggle comment for current line.
                comment_visual = "gc",  -- Comment in visual mode.
                textobject = "gc",      -- Comment using text objects (e.g., `gcip`).
            },
            hooks = {
                pre = function() end,  -- Run before commenting.
                post = function() end, -- Run after commenting.
            },
        },
        desc = "Smart code commenting using mini.comment",
    },

    -- Enhanced text objects (inside/around argument, etc.).
    {
        "echasnovski/mini.ai",
        version = false,
        config = function()
            require("mini.ai").setup()
        end,
    },

    -- Easily surround text with delimiters (parentheses, quotes) and manage them.
    {
        "echasnovski/mini.surround",
        version = false,
        config = function()
            require("mini.surround").setup()
        end,
    },

    -- Define custom text editing operators.
    {
        "echasnovski/mini.operators",
        version = false,
        config = function()
            require("mini.operators").setup()
        end,
    },

    -- Automatic insertion and deletion of matching pairs (parentheses, brackets, quotes).
    {
        "echasnovski/mini.pairs",
        version = false,
        config = function()
            require("mini.pairs").setup()
        end,
    },

    -- Navigation and manipulation of bracketed text.
    {
        "echasnovski/mini.bracketed",
        version = false,
        config = function()
            require("mini.bracketed").setup()
        end,
    },

    -- Easy deletion of buffers.
    {
        "echasnovski/mini.bufremove",
        version = false,
        config = function()
            vim.keymap.set("n", "<leader>mb", function()
                require("mini.bufremove").delete(0, false) -- Delete current buffer (no force).
            end, { desc = "Mini delete buffer" })

            vim.keymap.set("n", "<leader>mB", function()
                require("mini.bufremove").delete(0, true) -- Force delete current buffer.
            end, { desc = "Mini force delete buffer" })
        end,
    },

    -- Simple file explorer within Neovim.
    {
        "echasnovski/mini.files",
        version = false,
        config = function()
            require("mini.files").setup()
            vim.keymap.set("n", "<leader>me", function()
                require("mini.files").open() -- Open mini.files explorer.
            end, { desc = "Mini file explorer" })
        end,
    },

    -- Selection menu for various built-in and custom sources.
    {
        "echasnovski/mini.pick",
        version = false,
        config = function()
            require("mini.pick").setup()
            vim.keymap.set("n", "<leader>mp", function()
                require("mini.pick").builtin.files() -- Open mini.pick for files.
            end, { desc = "Mini pick files" })

            vim.keymap.set("n", "<leader>mg", function()
                require("mini.pick").builtin.grep_live() -- Open mini.pick for live grep.
            end, { desc = "Mini grep live" })
        end,
    },

    -- Modern and customizable notification system.
    {
        "echasnovski/mini.notify",
        version = false,
        event = "VeryLazy", -- Load only when needed (e.g., notification triggered).
        config = function()
            -- Check if 'winblend' is supported for transparency.
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
                        border = "rounded", -- Rounded borders for notifications.
                        width = 60,        -- Fixed width for notifications.
                    },
                },
                content = {
                    default_timeout_ms = 5000, -- Default notification timeout (5 seconds).
                },
                lsp_progress = {
                    enable = true,       -- Enable LSP progress display.
                    duration_ms = 500,   -- Duration of progress animation.
                },
            }

            -- Enable transparency if 'winblend' is supported.
            if has_winblend then
                config.window.config.winblend = 0
            end

            require("mini.notify").setup(config)
            vim.notify = require("mini.notify").make_notify() -- Replace default notify.
        end,
    },

    -- Session management (saving and restoring Neovim's state).
    {
        "echasnovski/mini.sessions",
        version = false,
        lazy = false, -- Load immediately for session management.
        config = function()
            require("mini.sessions").setup({
                autoread = true,  -- Automatically read last session on startup.
                autowrite = true, -- Automatically write current session on exit.
                directory = vim.fn.stdpath("data") .. "/sessions", -- Session file directory.
                file = "Session.vim", -- Default session filename.
                force = { read = false, write = true, delete = false }, -- Force options for actions.
                verbose = { read = false, write = true, delete = true }, -- Verbose output for actions.
            })

            -- Keymaps for session actions.
            vim.keymap.set("n", "<leader>ws", function()
                require("mini.sessions").write(nil) -- Write current session.
            end, { desc = "Write Session" })

            vim.keymap.set("n", "<leader>wr", function()
                require("mini.sessions").read(nil) -- Read last saved session.
            end, { desc = "Read Last Session" })

            vim.keymap.set("n", "<leader>wd", function()
                require("mini.sessions").delete(nil) -- Delete last saved session.
            end, { desc = "Delete Last Session" })
        end,
    },
}