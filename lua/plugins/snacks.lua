return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        terminal = { enabled = true },
        scroll = { enabled = true },
        notifier = { enabled = true },
        picker = { enabled = true },
        bufdelete = { enabled = true },
        zen = { enabled = true },
        words = { enabled = true },
    },

    keys = {
        { "<leader>e",  function() require("snacks").explorer() end,              desc = "Explorer" },
        { "<leader>sf", function() require("snacks").picker.files() end,          desc = "Files" },
        { "<leader>sb", function() require("snacks").picker.buffers() end,        desc = "Buffers" },
        { "<leader>sg", function() require("snacks").picker.grep() end,           desc = "Grep" },
        { "<C-t>",      function() require("snacks").terminal.toggle() end,       desc = "Terminal",     mode = { "n", "t" } },
        { "<leader>gg", function() require("snacks").lazygit() end,               desc = "Lazygit" },
        { "<leader>z",  function() require("snacks").zen() end,                   desc = "Zen Mode" },
        { "<leader>bd", function() require("snacks").bufdelete() end,             desc = "Delete Buffer" },
        { "<leader>un", function() require("snacks").notifier.show_history() end, desc = "Notifications" },
    },
}
