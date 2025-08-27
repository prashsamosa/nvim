-- lua/plugins/todo.lua
return {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",

    opts = {
        signs = true,
        keywords = {
            FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        highlight = {
            multiline = true,
            before = "",
            keyword = "wide",
            after = "fg",
            pattern = [[.*<(KEYWORDS)\s*:]],
            comments_only = true,
            max_line_len = 400,
        },
        colors = {
            error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
            info = { "DiagnosticInfo", "#2563EB" },
            hint = { "DiagnosticHint", "#10B981" },
            default = { "Identifier", "#7C3AED" },
            test = { "Identifier", "#FF00FF" },
        },
        search = {
            command = "rg",
            args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
            pattern = [[\b(KEYWORDS):]],
        },
    },

    keys = {
        { "]t",         function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
        { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous TODO comment" },
        { "<leader>ft", function() require("todo-comments.fzf").todo() end,  desc = "Search TODOs" },
    },
}
