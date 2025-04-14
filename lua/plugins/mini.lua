return {
    -- Core mini.nvim library. This is the foundation for all other mini.* plugins.
    {
        "echasnovski/mini.nvim",
        version = false, -- Pin to false to always use the latest version.
    },

    -- Smart code commenting using mini.comment. Provides commands and mappings
    -- for easily commenting and uncommenting code blocks and lines.
    {
        "echasnovski/mini.comment",
        version = false,
        lazy = false, -- Load immediately as commenting is a fundamental operation.
        opts = {
            options = {
                custom_commentstring = nil, -- Function to define custom comment strings per filetype.
                ignore_blank_line = false, -- Whether to skip commenting on blank lines.
                start_of_line = false, -- Whether to always comment at the start of the line.
                pad_comment_parts = true, -- Add padding spaces around comment delimiters.
            },
            mappings = {
                comment = "gc", -- Mapping to comment out the current selection (line/visual).
                comment_line = "gcc", -- Mapping to comment out the current line.
                comment_visual = "gc", -- Mapping for commenting in visual mode.
                textobject = "gc", -- Mapping for commenting using text objects (e.g., `gcip` to comment inside paragraph).
            },
            hooks = {
                pre = function() end, -- Function to run before commenting.
                post = function() end, -- Function to run after commenting.
            },
        },
        desc = "Smart code commenting using mini.comment",
    },

    -- Text Editing Utilities:
    -- 'mini.ai' provides enhanced text objects (like inside/around argument, etc.).
    {
        "echasnovski/mini.ai",
        version = false,
        config = function()
            require("mini.ai").setup()
        end,
    },

    -- 'mini.surround' provides commands to easily surround text with delimiters
    -- (like parentheses, quotes, etc.) and change/delete them.
    {
        "echasnovski/mini.surround",
        version = false,
        config = function()
            require("mini.surround").setup()
        end,
    },

    -- 'mini.operators' allows defining custom text editing operators.
    {
        "echasnovski/mini.operators",
        version = false,
        config = function()
            require("mini.operators").setup()
        end,
    },

    -- 'mini.pairs' handles automatic insertion and deletion of matching pairs
    -- (like parentheses, brackets, quotes).
    {
        "echasnovski/mini.pairs",
        version = false,
        config = function()
            require("mini.pairs").setup()
        end,
    },

    -- General Workflow:
    -- 'mini.bracketed' provides navigation and manipulation of bracketed text.
    {
        "echasnovski/mini.bracketed",
        version = false,
        config = function()
            require("mini.bracketed").setup()
        end,
    },

    -- 'mini.bufremove' allows easy deletion of buffers.
    {
        "echasnovski/mini.bufremove",
        version = false,
        config = function()
            vim.keymap.set("n", "<leader>mb", function()
                require("mini.bufremove").delete(0, false) -- Delete current buffer, don't force.
            end, { desc = "Mini delete buffer" })

            vim.keymap.set("n", "<leader>mB", function()
                require("mini.bufremove").delete(0, true) -- Delete current buffer, force close.
            end, { desc = "Mini force delete buffer" })
        end,
    },

    -- 'mini.files' provides a simple file explorer within Neovim.
    {
        "echasnovski/mini.files",
        version = false,
        config = function()
            require("mini.files").setup()
            vim.keymap.set("n", "<leader>me", function()
                require("mini.files").open() -- Open the mini.files explorer.
            end, { desc = "Mini file explorer" })
        end,
    },

    -- 'mini.pick' offers a selection menu for various built-in and custom sources.
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

    -- UI / Appearance:
    -- 'mini.statusline' provides a customizable statusline.
    {
        "echasnovski/mini.statusline",
        version = false,
        config = function()
            require("mini.statusline").setup({ use_icons = true }) -- Enable icons in the statusline.
        end,
    },

    -- 'mini.tabline' provides a minimal and fast tabline showing listed buffers.
    {
        "echasnovski/mini.tabline",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.tabline").setup({
                show_icons = true, -- Show file icons (requires mini.icons or nvim-web-devicons).
                format = nil, -- Use default formatting.
                tabpage_section = "left", -- Show tabpage section on the left if multiple tabs.
            })

            -- Buffer navigation: next/previous
            vim.keymap.set("n", "<Tab>", function()
                vim.cmd("bnext")
            end, { desc = "Next buffer" })

            vim.keymap.set("n", "<S-Tab>", function()
                vim.cmd("bprevious")
            end, { desc = "Previous buffer" })

            -- Jump to buffer 1 through 9 using <leader>1..9
            for i = 1, 9 do
                vim.keymap.set("n", "<leader>" .. i, function()
                    vim.cmd("buffer " .. i)
                end, { desc = "Go to buffer " .. i })
            end
        end,
    },

    -- 'mini.notify' is a modern and customizable notification system.
    {
        "echasnovski/mini.notify",
        version = false,
        event = "VeryLazy", -- Load only when needed (e.g., when a notification is triggered).
        config = function()
            -- Test if your Neovim version supports the 'winblend' window option.
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

            -- Basic configuration for mini.notify.
            local config = {
                -- Window configuration for notifications.
                window = {
                    config = {
                        border = "rounded", -- Use rounded borders for notification windows.
                        width = 60, -- Set a fixed width for notification windows.
                        -- max_width has been removed as it was causing errors in some versions.
                    },
                },
                -- Content configuration for notifications.
                content = {
                    default_timeout_ms = 5000, -- Default timeout for notifications (5 seconds).
                },
                -- LSP progress indicator settings.
                lsp_progress = {
                    enable = true, -- Enable the display of LSP progress.
                    duration_ms = 500, -- Duration of the progress animation.
                },
            }

            -- Only add the 'winblend' option if the Neovim version supports it
            -- for transparent notification backgrounds.
            if has_winblend then
                config.window.config.winblend = 0
            end

            -- Apply the mini.notify configuration.
            require("mini.notify").setup(config)

            -- Replace Neovim's default notification system with mini.notify.
            vim.notify = require("mini.notify").make_notify()
        end,
    },

    -- 'mini.sessions' provides session management (saving and restoring
    -- Neovim's state).
    {
        "echasnovski/mini.sessions",
        version = false,
        lazy = false, -- Load immediately for session management.
        config = function()
            require("mini.sessions").setup({
                autoread = true, -- Automatically read the last session on startup.
                autowrite = true, -- Automatically write the current session when exiting.
                directory = vim.fn.stdpath("data") .. "/sessions", -- Directory to store session files.
                file = "Session.vim", -- Default filename for sessions.
                force = { read = false, write = true, delete = false }, -- Force options for actions.
                verbose = { read = false, write = true, delete = true }, -- Verbose output for actions.
            })

            -- Keymaps for common session actions.
            vim.keymap.set("n", "<leader>ws", function()
                require("mini.sessions").write(nil) -- Write the current session.
            end, { desc = "Write Session" })

            vim.keymap.set("n", "<leader>wr", function()
                require("mini.sessions").read(nil) -- Read the last saved session.
            end, { desc = "Read Last Session" })

            vim.keymap.set("n", "<leader>wd", function()
                require("mini.sessions").delete(nil) -- Delete the last saved session.
            end, { desc = "Delete Last Session" })
        end,
    },
}
