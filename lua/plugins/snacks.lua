return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        -- Core features you already have
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        terminal = { enabled = true },
        scroll = { enabled = true },
        notifier = { enabled = true },
        bufdelete = { enabled = true },
        zen = { enabled = true },
        words = { enabled = true },

        -- Enhanced features to add
        statuscolumn = {
            enabled = true,
            left = { "mark", "sign" },
            right = { "fold", "git" },
            folds = {
                open = true,
                git_hl = true,
            },
            git = {
                patterns = { "GitSign", "MiniDiff" },
            },
        },

        picker = {
            enabled = true,
            win = {
                backdrop = 60,
                height = 0.8,
                width = 0.8,
            },
        },

        -- Add useful snacks you're missing
        input = { enabled = true },     -- Better vim.ui.input
        quickfile = { enabled = true }, -- Fast file opening
        scope = { enabled = true },     -- Scope-based buffer management
        scratch = { enabled = true },   -- Scratch buffers
        rename = { enabled = true },    -- File renaming
        gitbrowse = { enabled = true }, -- Open files in browser
        toggle = { enabled = true },    -- Toggle options
        profiler = { enabled = true },  -- Performance profiling

        -- Configure indent (better than mini.indentscope)
        indent = {
            enabled = true,
            animate = {
                enabled = false, -- Disable for performance
            },
            scope = {
                enabled = true,
                char = "╎",
                underline = true,
            },
        },

        -- Advanced window management
        dim = {
            enabled = true,
            scope = {
                min_size = 5,
                max_size = 20,
            },
        },
    },

    keys = {
        -- Keep existing keys and add new ones
        { "<leader>e",  function() require("snacks").explorer() end,                                                  desc = "Explorer" },
        { "<leader>gg", function() require("snacks").lazygit() end,                                                   desc = "Lazygit" },
        { "<leader>z",  function() require("snacks").zen() end,                                                       desc = "Zen Mode" },
        { "<leader>Z",  function() require("snacks").zen.zoom() end,                                                  desc = "Zoom Mode" },
        { "<leader>bd", function() require("snacks").bufdelete() end,                                                 desc = "Delete Buffer" },
        { "<leader>un", function() require("snacks").notifier.show_history() end,                                     desc = "Notifications" },
        { "<C-t>",      function() require("snacks").terminal.toggle() end,                                           desc = "Terminal",           mode = { "n", "t" } },

        -- Enhanced picker integration (alternative to fzf)
        { "<leader>.",  function() require("snacks").scratch() end,                                                   desc = "Scratch Buffer" },
        { "<leader>S",  function() require("snacks").scratch.select() end,                                            desc = "Select Scratch" },

        -- File operations
        { "<leader>cR", function() require("snacks").rename.rename_file() end,                                        desc = "Rename File" },
        { "<leader>gB", function() require("snacks").gitbrowse() end,                                                 desc = "Git Browse",         mode = { "n", "v" } },

        -- Toggle utilities
        { "<leader>ud", function() require("snacks").toggle.diagnostics() end,                                        desc = "Toggle Diagnostics" },
        { "<leader>ul", function() require("snacks").toggle.line_number() end,                                        desc = "Toggle Line Numbers" },
        { "<leader>uw", function() require("snacks").toggle.option("wrap", { name = "Wrap" }) end,                    desc = "Toggle Wrap" },
        { "<leader>us", function() require("snacks").toggle.option("spell", { name = "Spelling" }) end,               desc = "Toggle Spell" },
        { "<leader>uh", function() require("snacks").toggle.inlay_hints() end,                                        desc = "Toggle Inlay Hints" },
        { "<leader>uT", function() require("snacks").toggle.treesitter() end,                                         desc = "Toggle Treesitter" },
        { "<leader>ub", function() require("snacks").toggle.option("background", { off = "light", on = "dark" }) end, desc = "Toggle Background" },

        -- Word navigation
        { "]]",         function() require("snacks").words.jump(vim.v.count1) end,                                    desc = "Next Reference",     mode = { "n", "t" } },
        { "[[",         function() require("snacks").words.jump(-vim.v.count1) end,                                   desc = "Prev Reference",     mode = { "n", "t" } },

        -- Development utilities
        { "<leader>dP", function() require("snacks").profiler.pick() end,                                             desc = "Profiler" },
        { "<leader>dp", function() require("snacks").profiler.scratch() end,                                          desc = "Profiler Scratch" },
    },

    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup debugging globals
                _G.dd = function(...)
                    require("snacks").debug.inspect(...)
                end
                _G.bt = function()
                    require("snacks").debug.backtrace()
                end
                vim.print = _G.dd
            end,
        })
    end,
}
