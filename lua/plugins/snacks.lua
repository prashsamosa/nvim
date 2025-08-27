return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        -- Core features
        bigfile      = { enabled = true },
        dashboard    = { enabled = true },
        terminal     = { enabled = true },
        scroll       = { enabled = true },
        notifier     = { enabled = true },
        bufdelete    = { enabled = true },
        zen          = { enabled = true },
        words        = { enabled = true },

        -- Status column
        statuscolumn = {
            enabled = true,
            left    = { "mark", "sign" },
            right   = { "fold", "git" },
            folds   = {
                open   = true,
                git_hl = true,
            },
            git     = {
                patterns = { "GitSign", "MiniDiff" },
            },
        },

        -- Disable picker (using fzf-lua)
        picker       = { enabled = false },

        -- Extra features
        image        = { enabled = true },
        input        = { enabled = true },
        quickfile    = { enabled = true },
        scope        = { enabled = true },
        scratch      = { enabled = true },
        rename       = { enabled = true },
        gitbrowse    = { enabled = true },
        toggle       = { enabled = true },
        profiler     = { enabled = true },

        -- Advanced window management
        dim          = {
            enabled = true,
            scope = {
                min_size = 5,
                max_size = 20,
            },
        },
    },

    keys = {
        -- Core actions
        { "<leader>e",  function() require("snacks").explorer() end,                desc = "Explorer" },
        { "<leader>gg", function() require("snacks").lazygit() end,                 desc = "Lazygit" },
        { "<leader>z",  function() require("snacks").zen() end,                     desc = "Zen Mode" },
        { "<leader>Z",  function() require("snacks").zen.zoom() end,                desc = "Zoom Mode" },
        { "<leader>bd", function() require("snacks").bufdelete() end,               desc = "Delete Buffer" },
        { "<leader>un", function() require("snacks").notifier.show_history() end,   desc = "Notifications" },
        { "<C-t>",      function() require("snacks").terminal.toggle() end,         desc = "Terminal",            mode = { "n", "t" } },

        -- Scratch buffers
        { "<leader>.",  function() require("snacks").scratch() end,                 desc = "Scratch Buffer" },
        { "<leader>S",  function() require("snacks").scratch.select() end,          desc = "Select Scratch" },

        -- File ops
        { "<leader>cR", function() require("snacks").rename.rename_file() end,      desc = "Rename File" },
        { "<leader>gB", function() require("snacks").gitbrowse() end,               desc = "Git Browse",          mode = { "n", "v" } },

        -- Dev utilities
        { "<leader>dP", function() require("snacks").profiler.pick() end,           desc = "Profiler" },
        { "<leader>dp", function() require("snacks").profiler.scratch() end,        desc = "Profiler Scratch" },

        -- Word navigation
        { "]w",         function() require("snacks").words.jump(vim.v.count1) end,  desc = "Next Word Reference", mode = { "n", "t" } },
        { "[w",         function() require("snacks").words.jump(-vim.v.count1) end, desc = "Prev Word Reference", mode = { "n", "t" } },
    },

    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Debugging helpers
                _G.dd = function(...) require("snacks").debug.inspect(...) end
                _G.bt = function() require("snacks").debug.backtrace() end
                vim.print = _G.dd

                local snacks = require("snacks")

                -- Toggles
                vim.keymap.set("n", "<leader>ud", function() snacks.toggle.diagnostics() end,
                    { desc = "Toggle Diagnostics" })
                vim.keymap.set("n", "<leader>ul", function() snacks.toggle.line_number() end,
                    { desc = "Toggle Line Numbers" })
                vim.keymap.set("n", "<leader>uw", function() snacks.toggle.option("wrap", { name = "Wrap" }) end,
                    { desc = "Toggle Wrap" })
                vim.keymap.set("n", "<leader>us", function() snacks.toggle.option("spell", { name = "Spelling" }) end,
                { desc = "Toggle Spell" })
                vim.keymap.set("n", "<leader>ih", function() snacks.toggle.inlay_hints() end,
                    { desc = "Toggle Buffer Inlay Hints" })
                vim.keymap.set("n", "<leader>uT", function() snacks.toggle.treesitter() end,
                    { desc = "Toggle Treesitter" })
                vim.keymap.set("n", "<leader>ub",
                    function() snacks.toggle.option("background", { off = "light", on = "dark" }) end,
                    { desc = "Toggle Background" })
            end,
        })
    end,
}
