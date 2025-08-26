return {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar" },

    keys = {
        { "<leader>sr", function() require("grug-far").open() end,                                                     desc = "Search & Replace" },
        { "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search Word Under Cursor" },
        { "<leader>sb", function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end,        desc = "Search in Current Buffer" },
        { "<leader>sv", mode = "v",                                                                                    function()
            require("grug-far").open({ visualSelectionUsage = "prefill-search" }) end,                                                                                                                       desc = "Search Visual Selection" },
    },

    opts = {
        debounceMs = 500,
        minSearchChars = 2,
        maxSearchMatches = 2000,
        startInInsertMode = true,
        windowCreationCommand = "vsplit",

        keymaps = {
            replace = { n = "<leader>r", i = "<C-r>" },
            qflist = { n = "<leader>q" },
            close = { n = "q", i = "<C-q>" },
            gotoLocation = { n = "<CR>" },
        },

        engines = {
            ripgrep = {
                placeholders = {
                    search = "e.g. foo [Aa]b?c \\w+",
                    replacement = "e.g. bar $1 ${1:default}",
                    filesFilter = "e.g. *.lua src/**/*.js !**/node_modules",
                },
            },
        },
    },
}
