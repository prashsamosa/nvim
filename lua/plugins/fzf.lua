return {
    "ibhagwan/fzf-lua",
    dependencies = "nvim-tree/nvim-web-devicons",

    keys = {
        { "<leader>ff", "<cmd>FzfLua files<cr>",                                                       desc = "Find Files" },
        { "<leader>fC", function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end,   desc = "Find in Config" },
        { "<leader>fg", "<cmd>FzfLua live_grep<cr>",                                                   desc = "Live Grep" },
        { "<leader>f/", function() require("fzf-lua").live_grep({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Grep Current Dir" },
        { "<leader>fo", "<cmd>FzfLua oldfiles<cr>",                                                    desc = "Recent Files" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>",                                                     desc = "Open Buffers" },
        { "<leader>fc", "<cmd>FzfLua commands<cr>",                                                    desc = "Commands" },
        { "<leader>fw", "<cmd>FzfLua grep_cword<cr>",                                                  desc = "Find word under cursor" },
        { "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>",                                                  desc = "Find WORD under cursor" },
        { "<leader>fh", "<cmd>FzfLua helptags<cr>",                                                    desc = "Help Tags" },
        { "<leader>fk", "<cmd>FzfLua keymaps<cr>",                                                     desc = "Keymaps" },
        { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>",                                        desc = "Document Diagnostics" },
        { "<leader>fr", "<cmd>FzfLua resume<cr>",                                                      desc = "Resume Last Search" },
    },

    opts = {
        winopts = {
            preview = { default = "bat" },
            width = 0.85,
            height = 0.75,
            border = "rounded",
        },
        fzf_opts = {
            ["--ansi"] = true,
            ["--prompt"] = "❯ ",
            ["--layout"] = "reverse",
            ["--info"] = "inline",
        },
    },
}
