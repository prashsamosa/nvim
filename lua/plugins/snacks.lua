-- lua/plugins/snacks.lua - Optimized for Neovim 0.11

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        bigfile = { enabled = true, size = 1.5 * 1024 * 1024 },

        dashboard = {
            enabled = true,
            width = 60,
            preset = {
                header = [[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
            sections = {
                { section = "header" },
                { section = "keys",   gap = 1,                padding = 1 },
                { icon = " ",         title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { icon = " ",         title = "Projects",     section = "projects",     indent = 2, padding = 1 },
                { section = "startup" },
            },
        },

        input = { enabled = false },

        terminal = {
            enabled = true,
            win = {
                position = "bottom",
                height = 0.3,
                border = "rounded",
            },
        },

        scope = { enabled = true },
        explorer = { enabled = true },
        git = { enabled = true },
        gitbrowse = { enabled = true },
        lazygit = { enabled = true },
        quickfile = { enabled = true },

        scroll = {
            enabled = true,
            animate = {
                duration = { step = 15, total = 250 },
                easing = "linear",
            },
        },

        words = {
            enabled = true,
            debounce = 200,
            notify_jump = false,
        },

        rename = { enabled = true },
        zen = { enabled = true },

        notifier = {
            enabled = true,
            timeout = 3000,
            width = { min = 40, max = 0.4 },
            height = { min = 1, max = 0.6 },
            margin = { top = 0, right = 1, bottom = 0 },
            sort = { "level", "added" },
            icons = {
                error = " ",
                warn = " ",
                info = " ",
                debug = " ",
                trace = " ",
            },
            style = "compact",
            top_down = true,
        },

        picker = { enabled = true },
        bufdelete = { enabled = true },
        scratch = { enabled = true },
    },

    keys = {
        -- Core functionality
        { "<leader>e",       function() require("snacks").explorer() end,              desc = "Explorer" },
        { "<leader><space>", function() require("snacks").picker.files() end,          desc = "Find Files" },
        { "<leader>,",       function() require("snacks").picker.buffers() end,        desc = "Buffers" },

        -- Terminal
        { "<c-t>",           function() require("snacks").terminal.toggle() end,       desc = "Toggle Terminal",          mode = { "n", "t" } },

        -- Git
        { "<leader>gg",      function() require("snacks").lazygit() end,               desc = "Lazygit" },
        { "<leader>gb",      function() require("snacks").git.blame_line() end,        desc = "Git Blame Line" },
        { "<leader>gB",      function() require("snacks").gitbrowse() end,             desc = "Git Browse" },

        -- Zen mode
        { "<leader>z",       function() require("snacks").zen.zen() end,               desc = "Zen Mode" },

        -- Buffer management
        { "<leader>bc",      function() require("snacks").bufdelete() end,             desc = "Close Buffer" },
        { "<leader>bo",      function() require("snacks").bufdelete.other() end,       desc = "Delete Other Buffers" },

        -- Utilities
        { "<leader>.",       function() require("snacks").scratch() end,               desc = "Scratch Buffer" },
        { "<leader>rf",      function() require("snacks").rename.rename_file() end,    desc = "Rename File" },

        -- Toggles
        { "<leader>ud",      function() require("snacks").toggle.diagnostics() end,    desc = "Toggle Diagnostics" },
        { "<leader>ul",      function() require("snacks").toggle.line_number() end,    desc = "Toggle Line Numbers" },
        { "<leader>uh",      function() require("snacks").toggle.inlay_hints() end,    desc = "Toggle Inlay Hints" },

        -- Notifications
        { "<leader>un",      function() require("snacks").notifier.show_history() end, desc = "Notification History" },
        { "<leader>uN",      function() require("snacks").notifier.hide() end,         desc = "Dismiss All Notifications" },
    },

    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Global debugging functions
                _G.dd = function(...) require("snacks").debug.inspect(...) end
                _G.bt = function() require("snacks").debug.backtrace() end
            end,
        })
    end,
}
