return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        bigfile = { enabled = true, size = 1.5 * 1024 * 1024 },

        dashboard = {
            enabled = true,
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
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
        },

        terminal = {
            enabled = true,
            win = { position = "bottom", height = 0.3, border = "rounded" },
        },

        scroll = {
            enabled = true,
            animate = { duration = { step = 15, total = 250 }, easing = "linear" },
        },

        words = { enabled = true, debounce = 200 },
        rename = { enabled = true },
        zen = { enabled = true },

        notifier = {
            enabled = true,
            timeout = 3000,
            icons = {
                error = " ", warn = " ", info = " ", debug = " ", trace = " ",
            },
        },

        picker = { enabled = true },
        bufdelete = { enabled = true },
        scratch = { enabled = true },
    },

    keys = {
        { "<leader>e",       function() require("snacks").explorer() end,              desc = "Explorer" },
        { "<leader><space>", function() require("snacks").picker.files() end,          desc = "Find Files" },
        { "<leader>,",       function() require("snacks").picker.buffers() end,        desc = "Buffers" },
        { "<c-t>",           function() require("snacks").terminal.toggle() end,       desc = "Toggle Terminal",          mode = { "n", "t" } },
        { "<leader>gg",      function() require("snacks").lazygit() end,               desc = "Lazygit" },
        { "<leader>gb",      function() require("snacks").git.blame_line() end,        desc = "Git Blame Line" },
        { "<leader>gB",      function() require("snacks").gitbrowse() end,             desc = "Git Browse" },
        { "<leader>z",       function() require("snacks").zen.zen() end,               desc = "Zen Mode" },
        { "<leader>bc",      function() require("snacks").bufdelete() end,             desc = "Close Buffer" },
        { "<leader>bo",      function() require("snacks").bufdelete.other() end,       desc = "Delete Other Buffers" },
        { "<leader>.",       function() require("snacks").scratch() end,               desc = "Scratch Buffer" },
        { "<leader>rf",      function() require("snacks").rename.rename_file() end,    desc = "Rename File" },
        { "<leader>ud",      function() require("snacks").toggle.diagnostics() end,    desc = "Toggle Diagnostics" },
        { "<leader>ul",      function() require("snacks").toggle.line_number() end,    desc = "Toggle Line Numbers" },
        { "<leader>uh",      function() require("snacks").toggle.inlay_hints() end,    desc = "Toggle Inlay Hints" },
        { "<leader>un",      function() require("snacks").notifier.show_history() end, desc = "Notification History" },
        { "<leader>uN",      function() require("snacks").notifier.hide() end,         desc = "Dismiss All Notifications" },
    },

    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                _G.dd = function(...) require("snacks").debug.inspect(...) end
                _G.bt = function() require("snacks").debug.backtrace() end
            end,
        })
    end,
}
