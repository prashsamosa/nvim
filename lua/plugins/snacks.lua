return {
    "folke/snacks.nvim", -- A collection of useful Neovim utilities.
    priority = 1000,     -- Initialize early.
    lazy = false,        -- Load immediately.

    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy", -- After lazy-loading other plugins.
            callback = function()
                -- Global debugging functions.
                _G.dd = function(...)
                    Snacks.debug.inspect(...) -- Print debug info.
                end
                _G.bt = function()
                    Snacks.debug.backtrace() -- Print backtrace.
                end
                vim.print = _G.dd           -- Redirect vim.print for debugging.

                -- Toggle mappings.
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle
                    .option("conceallevel", {
                        off = 0,
                        on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
                        name = "Conceal",
                    })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle
                    .option("background", { off = "light", on = "dark", name = "Dark Background" })
                    :map("<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "OilActionsPost", -- After actions in oil.nvim.
            callback = function(event)
                if event.data.actions.type == "move" then
                    Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
                    -- Notify Snacks of file renames in oil.nvim.
                end
            end,
        })
    end,

    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            preset = {
                header = [[
                    ███████╗ █████╗ ███╗   ███╗ ██████╗ ███████╗ █████╗ 
                    ██╔════╝██╔══██╗████╗ ████║██╔═══██╗██╔════╝██╔══██╗
                    ███████╗███████║██╔████╔██║██║   ██║███████╗███████║
                    ╚════██║██╔══██║██║╚██╔╝██║██║   ██║╚════██║██╔══██║
                    ███████║██║  ██║██║ ╚═╝ ██║╚██████╔╝███████║██║  ██║
                    ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
                ]],
                
            },
        },
        explorer = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true, timeout = 3000 }, -- Notification timeout in ms.
        picker = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        rename = { enabled = true },
        zen = {
            enabled = true,
            options = {
                window = {
                    width = 0.85,    -- Zen mode window width (percentage).
                    options = {
                        signcolumn = "no",
                        number = false,
                        relativenumber = false,
                    },
                },
            },
        },
    },

    keys = {
        {
            "<leader><space>",
            function()
                Snacks.picker.smart() -- Smart picker.
            end,
            desc = "Smart Find Files",
        },
        {
            "<leader>,",
            function()
                Snacks.picker.buffers() -- Buffer picker.
            end,
            desc = "Buffers",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history() -- Command history.
            end,
            desc = "Command History",
        },
        {
            "<leader>n",
            function()
                Snacks.picker.notifications() -- Notification history.
            end,
            desc = "Notification History",
        },
        {
            "<leader>e",
            function()
                Snacks.explorer() -- File explorer.
            end,
            desc = "File Explorer",
        },
        {
            "<leader>fc",
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) -- Find config files.
            end,
            desc = "Find Config File",
        },
        {
            "<leader>ff",
            function()
                Snacks.picker.files() -- Find files in cwd.
            end,
            desc = "Find Files",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.git_files() -- Find Git files.
            end,
            desc = "Find Git Files",
        },
        {
            "<leader>fp",
            function()
                Snacks.picker.projects() -- Project picker.
            end,
            desc = "Projects",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.recent() -- Recent files.
            end,
            desc = "Recent",
        },
        {
            "<leader>gb",
            function()
                Snacks.picker.git_branches() -- Git branches.
            end,
            desc = "Git Branches",
        },
        {
            "<leader>gl",
            function()
                Snacks.picker.git_log() -- Git log.
            end,
            desc = "Git Log",
        },
        {
            "<leader>gL",
            function()
                Snacks.picker.git_log_line() -- Git log for line.
            end,
            desc = "Git Log Line",
        },
        {
            "<leader>gs",
            function()
                Snacks.picker.git_status() -- Git status.
            end,
            desc = "Git Status",
        },
        {
            "<leader>gS",
            function()
                Snacks.picker.git_stash() -- Git stash.
            end,
            desc = "Git Stash",
        },
        {
            "<leader>gd",
            function()
                Snacks.picker.git_diff() -- Git diff (hunks).
            end,
            desc = "Git Diff (Hunks)",
        },
        {
            "<leader>gf",
            function()
                Snacks.picker.git_log_file() -- Git log for file.
            end,
            desc = "Git Log File",
        },
        {
            "<leader>sb",
            function()
                Snacks.picker.lines() -- Lines in buffer.
            end,
            desc = "Buffer Lines",
        },
        {
            "<leader>sB",
            function()
                Snacks.picker.grep_buffers() -- Grep in buffers.
            end,
            desc = "Grep Open Buffers",
        },
        {
            "<leader>sg",
            function()
                Snacks.picker.grep() -- Grep in project.
            end,
            desc = "Grep",
        },
        {
            "<leader>sw",
            function()
                Snacks.picker.grep_word() -- Grep word (visual).
            end,
            desc = "Visual Word",
            mode = { "n", "x" },
        },
        {
            "<leader>z",
            function()
                Snacks.zen() -- Zen mode.
            end,
            desc = "Toggle Zen Mode",
        },
        {
            "<leader>Z",
            function()
                Snacks.zen.zoom() -- Zen mode zoom.
            end,
            desc = "Toggle Zoom",
        },
        {
            "<leader>bd",
            function()
                Snacks.bufdelete() -- Delete buffer.
            end,
            desc = "Delete Buffer",
        },
        {
            "<leader>ba",
            function()
                Snacks.bufdelete.all() -- Delete all buffers.
            end,
            desc = "Delete All Buffers",
        },
        {
            "<leader>bo",
            function()
                Snacks.bufdelete.other() -- Delete other buffers.
            end,
            desc = "Delete Other Buffers",
        },
        {
            "<leader>.",
            function()
                Snacks.scratch() -- Scratch buffer.
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>S",
            function()
                Snacks.scratch.select() -- Select scratch.
            end,
            desc = "Select Scratch Buffer",
        },
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse() -- Git browse.
            end,
            desc = "Git Browse",
            mode = { "n", "v" },
        },
        {
            "<leader>gg",
            function()
                Snacks.lazygit() -- Lazygit.
            end,
            desc = "Lazygit",
        },
        {
            "<leader>un",
            function()
                Snacks.notifier.hide() -- Hide notifications.
            end,
            desc = "Dismiss Notifications",
        },
        {
            "<leader>cR",
            function()
                Snacks.rename.rename_file() -- Rename file.
            end,
            desc = "Rename File",
        },
        {
            "]]",
            function()
                Snacks.words.jump(vim.v.count1) -- Next word.
            end,
            desc = "Next Reference",
            mode = { "n", "t" },
        },
        {
            "[[",
            function()
                Snacks.words.jump(-vim.v.count1) -- Previous word.
            end,
            desc = "Previous Reference",
            mode = { "n", "t" },
        },
    },

    config = function(_, opts)
        require("snacks").setup(opts) -- Setup Snacks.
    end,
}