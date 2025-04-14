return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency.
    event = "VeryLazy", -- Load lazily to improve startup time.

    config = function()
        require("todo-comments").setup({
            signs = true, -- Show icons in the sign column.
            sign_priority = 8, -- Priority of signs (higher = closer to text).
            keywords = {
                FIX = {
                    icon = " ", -- Icon for FIX comments.
                    color = "error", -- Highlight color.
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Alternative keywords.
                },
                TODO = { icon = " ", color = "info" }, -- Icon and color for TODO comments.
                HACK = { icon = " ", color = "warning" }, -- Icon and color for HACK comments.
                WARN = {
                    icon = " ", -- Icon for WARN comments.
                    color = "warning",
                    alt = { "WARNING", "XXX" }, -- Alternative keywords.
                },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } }, -- Performance-related notes.
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } }, -- General notes or information.
                TEST = {
                    icon = "⏲ ", -- Icon for TEST comments.
                    color = "test",
                    alt = { "TESTING", "PASSED", "FAILED" }, -- Alternative keywords.
                },
            },
            highlight = {
                multiline = true, -- Highlight multiline comments.
                multiline_pattern = "^.", -- Match each line of a multiline comment.
                multiline_context = 10, -- Number of lines of context for multiline comments.
                keyword = "wide", -- Highlight the entire keyword.
                after = "fg", -- Highlight text after the keyword.
                pattern = [[.*<(KEYWORDS)\s*:]], -- Pattern to match keywords.
                comments_only = true, -- Search only within comments.
                max_line_len = 400, -- Maximum line length to search.
                exclude = {}, -- Exclude specific files or directories.
            },
            colors = {
                error = { "DiagnosticError", "ErrorMsg", "#DC2626" }, -- Red for errors.
                warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" }, -- Yellow for warnings.
                info = { "DiagnosticInfo", "#2563EB" }, -- Blue for informational comments.
                hint = { "DiagnosticHint", "#10B981" }, -- Green for hints.
                default = { "Identifier", "#7C3AED" }, -- Purple for default comments.
                test = { "Identifier", "#FF00FF" }, -- Magenta for test-related comments.
            },
            search = {
                command = "rg", -- Use ripgrep for searching.
                args = {
                    "--color=never", -- Disable color output.
                    "--no-heading", -- Don't show headings.
                    "--with-filename", -- Include filenames in results.
                    "--line-number", -- Include line numbers in results.
                    "--column", -- Include column numbers in results.
                },
                pattern = [[\b(KEYWORDS):]], -- Pattern to find keywords.
            },
        })

        -- Keybindings for navigating TODO comments.
        vim.keymap.set("n", "]t", function()
            require("todo-comments").jump_next() -- Jump to the next TODO comment.
        end, { desc = "Next TODO comment" })

        vim.keymap.set("n", "[t", function()
            require("todo-comments").jump_prev() -- Jump to the previous TODO comment.
        end, { desc = "Previous TODO comment" })
    end,
}