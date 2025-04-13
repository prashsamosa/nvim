return {
    "folke/snacks.nvim", -- The plugin specification: name of the GitHub repository.
    priority = 1000, -- Sets a high priority to ensure it initializes early.
    lazy = false,    -- Load immediately on startup.

    init = function() -- Initialization function that runs when the plugin is loaded.
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy", -- Trigger this autocommand when the 'VeryLazy' user event is fired
                                 -- (typically after lazy-loading of other plugins).
            callback = function()
                -- Define a global debug function 'dd' using Snacks' inspect.
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                -- Define a global backtrace function 'bt' using Snacks' backtrace.
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                -- Redirect Neovim's built-in 'print' function to our 'dd' for easier debugging.
                vim.print = _G.dd

                -- Create toggle mappings for various Neovim options using Snacks.
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                -- Toggle spell checking with <leader>us.
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                -- Toggle line wrapping with <leader>uw.
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                -- Toggle relative line numbers with <leader>uL.
                Snacks.toggle.diagnostics():map("<leader>ud")
                -- Toggle diagnostics display with <leader>ud.
                Snacks.toggle.line_number():map("<leader>ul")
                -- Toggle absolute line numbers with <leader>ul.
                Snacks.toggle
                    .option("conceallevel", {
                        off = 0,
                        on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
                        name = "Conceal",
                    })
                    :map("<leader>uc")
                -- Toggle conceal level with <leader>uc. If conceal is on, keep the current level,
                -- otherwise set it to 2.
                Snacks.toggle.treesitter():map("<leader>uT")
                -- Toggle Treesitter highlighting with <leader>uT.
                Snacks.toggle
                    .option("background", { off = "light", on = "dark", name = "Dark Background" })
                    :map("<leader>ub")
                -- Toggle background theme (light/dark) with <leader>ub.
                Snacks.toggle.inlay_hints():map("<leader>uh")
                -- Toggle LSP inlay hints with <leader>uh.
                Snacks.toggle.dim():map("<leader>uD")
                -- Toggle dimming of inactive windows with <leader>uD.
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "OilActionsPost", -- Triggered after actions in the 'oil.nvim' file explorer.
            callback = function(event)
                if event.data.actions.type == "move" then
                    -- If the action in oil was a file move/rename, notify Snacks' rename module.
                    Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
                end
            end,
        })
    end,

    opts = { -- Configuration options for 'snacks.nvim'.
        bigfile = { enabled = true }, -- Enable big file optimizations.
        dashboard = { -- Configuration for the dashboard (startup screen).
            enabled = true,
            preset = {
                header = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝   ╚═╝
        ]],
            },
        },
        explorer = { enabled = true }, -- Enable the built-in file explorer.
        indent = { enabled = true },   -- Enable indent guides.
        input = { enabled = true },    -- Enable input prompts.
        notifier = { enabled = true, timeout = 3000 }, -- Enable notifications with a 3-second timeout.
        picker = { enabled = true },    -- Enable the smart picker (file finder, etc.).
        quickfile = { enabled = true }, -- Enable quick file creation.
        scope = { enabled = true },     -- Enable scope highlighting.
        scroll = { enabled = true },    -- Enable smooth scrolling.
        statuscolumn = { enabled = true }, -- Enable the status column (line numbers, etc.).
        words = { enabled = true },     -- Enable word-related features (jump to next/previous).
        rename = { enabled = true },    -- Enable file renaming features.
        zen = { -- Configuration for Zen mode (distraction-free writing).
            enabled = true,
            options = {
                window = {
                    width = 0.85, -- Zen mode window width as a percentage of screen width.
                    options = {
                        signcolumn = "no",       -- Hide the sign column.
                        number = false,          -- Hide line numbers.
                        relativenumber = false,  -- Hide relative line numbers.
                    },
                },
            },
        },
    },

    keys = { -- Key mappings provided by 'snacks.nvim'.
        {
            "<leader><space>",
            function()
                Snacks.picker.smart() -- Open the smart picker (find files, buffers, etc.).
            end,
            desc = "Smart Find Files",
        },
        {
            "<leader>,", -- Kept this one for buffers
            function()
                Snacks.picker.buffers() -- Open the buffer picker.
            end,
            desc = "Buffers",
        },
        -- REMOVED: <leader>/ mapping for grep (conflicted with comment, redundant with <leader>sg)
        {
            "<leader>:",
            function()
                Snacks.picker.command_history() -- Open the command history picker.
            end,
            desc = "Command History",
        },
        {
            "<leader>n",
            function()
                Snacks.picker.notifications() -- Open the notification history picker.
            end,
            desc = "Notification History",
        },
        {
            "<leader>e",
            function()
                Snacks.explorer() -- Open the built-in file explorer.
            end,
            desc = "File Explorer",
        },
        -- REMOVED: <leader>fb mapping for buffers (redundant with <leader>,)
        {
            "<leader>fc",
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) -- Find files in the Neovim config directory.
            end,
            desc = "Find Config File",
        },
        {
            "<leader>ff",
            function()
                Snacks.picker.files() -- Find files in the current working directory.
            end,
            desc = "Find Files",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.git_files() -- Find files tracked by Git.
            end,
            desc = "Find Git Files",
        },
        {
            "<leader>fp",
            function()
                Snacks.picker.projects() -- Open the project picker.
            end,
            desc = "Projects",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.recent() -- Open the recent files picker.
            end,
            desc = "Recent",
        },
        {
            "<leader>gb",
            function()
                Snacks.picker.git_branches() -- Open the Git branches picker.
            end,
            desc = "Git Branches",
        },
        {
            "<leader>gl",
            function()
                Snacks.picker.git_log() -- Open the Git log picker.
            end,
            desc = "Git Log",
        },
        {
            "<leader>gL",
            function()
                Snacks.picker.git_log_line() -- Open the Git log for the current line.
            end,
            desc = "Git Log Line",
        },
        {
            "<leader>gs",
            function()
                Snacks.picker.git_status() -- Open the Git status picker.
            end,
            desc = "Git Status",
        },
        {
            "<leader>gS",
            function()
                Snacks.picker.git_stash() -- Open the Git stash picker.
            end,
            desc = "Git Stash",
        },
        {
            "<leader>gd",
            function()
                Snacks.picker.git_diff() -- Open the Git diff picker (hunks).
            end,
            desc = "Git Diff (Hunks)",
        },
        {
            "<leader>gf",
            function()
                Snacks.picker.git_log_file() -- Open the Git log for the current file.
            end,
            desc = "Git Log File",
        },
        {
            "<leader>sb",
            function()
                Snacks.picker.lines() -- Pick lines in the current buffer.
            end,
            desc = "Buffer Lines",
        },
        {
            "<leader>sB",
            function()
                Snacks.picker.grep_buffers() -- Grep across open buffers.
            end,
            desc = "Grep Open Buffers",
        },
        {
            "<leader>sg",
            function()
                Snacks.picker.grep() -- Grep across the project.
            end,
            desc = "Grep",
        },
        {
            "<leader>sw",
            function()
                Snacks.picker.grep_word() -- Grep for the word under the cursor (visual selection).
            end,
            desc = "Visual Word",
            mode = { "n", "x" },
        },
        -- REMOVED: LSP keymaps (gd, gD, gr, gI, gy, <leader>ss, <leader>sS) - Handled by lsp.lua
        {
            "<leader>z",
            function()
                Snacks.zen() -- Toggle Zen mode.
            end,
            desc = "Toggle Zen Mode",
        },
        {
            "<leader>Z",
            function()
                Snacks.zen.zoom() -- Toggle zoom in Zen mode.
            end,
            desc = "Toggle Zoom",
        },
        {
            "<leader>bd", -- Keep Snacks definition
            function()
                Snacks.bufdelete() -- Delete the current buffer.
            end,
            desc = "Delete Buffer",
        },
        {
            "<leader>ba", -- Keep Snacks definition
            function()
                Snacks.bufdelete.all() -- Delete all buffers.
            end,
            desc = "Delete All Buffers",
        },
        {
            "<leader>bo", -- Keep Snacks definition
            function()
                Snacks.bufdelete.other() -- Delete other buffers (keep current).
            end,
            desc = "Delete Other Buffers",
        },
        {
            "<leader>.",
            function()
                Snacks.scratch() -- Toggle the scratch buffer.
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>S",
            function()
                Snacks.scratch.select() -- Select an existing scratch buffer.
            end,
            desc = "Select Scratch Buffer",
        },
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse() -- Open the current file/selection in the Git repository browser.
            end,
            desc = "Git Browse",
            mode = { "n", "v" },
        },
        {
            "<leader>gg",
            function()
                Snacks.lazygit() -- Open Lazygit in a floating window.
            end,
            desc = "Lazygit",
        },
        -- REMOVED: Terminal toggles (<c-/>, <c-_>) - Handled by toggle-terminal.lua
        {
            "<leader>un",
            function()
                Snacks.notifier.hide() -- Hide all notifications.
            end,
            desc = "Dismiss Notifications",
        },
        {
            "<leader>cR",
            function()
                Snacks.rename.rename_file() -- Prompt to rename the current file.
            end,
            desc = "Rename File",
        },
        {
            "]]",
            function()
                Snacks.words.jump(vim.v.count1) -- Jump to the next occurrence of the word under the cursor.
            end,
            desc = "Next Reference",
            mode = { "n", "t" },
        },
        {
            "[[",
            function()
                Snacks.words.jump(-vim.v.count1) -- Jump to the previous occurrence of the word under the cursor.
            end,
            desc = "Previous Reference",
            mode = { "n", "t" },
        },
    },

    config = function(_, opts)
        require("snacks").setup(opts) -- Finally, apply the 'snacks.nvim' setup with the configured options.
    end,
}