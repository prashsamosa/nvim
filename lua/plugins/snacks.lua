-- lua/plugins/snacks.lua - FIXED VERSION
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    init = function()
        -- Expose global debugging functions
        _G.dd = function(...)
            if package.loaded["snacks"] then
                require("snacks").debug.inspect(...)
            end
        end
        _G.bt = function()
            if package.loaded["snacks"] then
                require("snacks").debug.backtrace()
            end
        end

        -- Configure fillchars for better visual appearance
        vim.opt.fillchars:append({
            vert = " ",
            fold = " ",
            eob = " ",
            diff = " ",
            msgsep = " ",
        })

        -- Integration with Oil.nvim for file operations
        vim.api.nvim_create_augroup("SnacksOilHooks", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "SnacksOilHooks",
            pattern = "OilActionsPost",
            callback = function(event)
                local data = event.data and event.data.actions
                if data and data.type == "move" and data.src_url and data.dest_url then
                    if package.loaded["snacks"] then
                        require("snacks").rename.on_rename_file(data.src_url, data.dest_url)
                    end
                end
            end,
        })
    end,

    opts = {
        -- File size detection
        bigfile = {
            enabled = true,
            notify = true,
            size = 1.5 * 1024 * 1024, -- 1.5MB
        },

        -- Dashboard configuration
        dashboard = {
            enabled = true,
            width = 60,
            row = nil,
            col = nil,
            pane_gap = 4,
            preset = {
                header = [[
      ███████╗ █████╗ ███╗  ███╗ ██████╗  ███████╗ █████╗
      ██╔════╝██╔══██╗████╗ ████║██╔══██╗ ██╔════╝██╔══██╗
      ███████╗███████║██╔████╔██║██║  ██║ ███████╗███████║
      ╚════██║██╔══██║██║╚██╔╝██║██║  ██║╚══ ══██║██╔══██║
      ███████║██║  ██║██║ ╚═╝ ██║╚██████╔╝███████║██║  ██║
      ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
        ]],
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
                    { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
            sections = {
                { section = "header" },
                {
                    pane = 2,
                    section = "keys",
                    gap = 1,
                    padding = 1,
                },
                { pane = 2,           icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { pane = 2,           icon = " ", title = "Projects",     section = "projects",     indent = 2, padding = 1 },
                { section = "startup" },
            },
        },

        -- Disable input (conflicts with other input plugins)
        input = { enabled = false },

        -- Terminal configuration
        terminal = {
            enabled = true,
            win = {
                position = "bottom",
                height = 0.3,
                width = 0.8,
                border = "rounded",
            },
        },

        -- Scope highlighting
        scope = {
            enabled = true,
            animate = {
                enabled = vim.fn.has("nvim-0.10") == 1,
                duration = {
                    step = 20,
                    total = 500,
                },
                easing = "out_quad",
            },
            keys = {
                textobject = {
                    ii = {
                        min_size = 2,
                        edge = false,
                        cursor = false,
                        desc = "inner scope",
                    },
                    ai = {
                        cursor = false,
                        min_size = 2,
                        desc = "full scope",
                    },
                },
                jump = {
                    ["[i"] = {
                        min_size = 1,
                        bottom = false,
                        cursor = false,
                        edge = true,
                        desc = "jump to top edge of scope",
                    },
                    ["]i"] = {
                        min_size = 1,
                        bottom = true,
                        cursor = false,
                        edge = true,
                        desc = "jump to bottom edge of scope",
                    },
                },
            },
        },

        -- File explorer
        explorer = {
            enabled = true,
            replace_netrw = false,
        },

        -- Git integration
        git = { enabled = true },
        gitbrowse = { enabled = true },
        lazygit = { enabled = true },

        -- Development tools
        debug = { enabled = true },
        quickfile = { enabled = true },

        -- UI enhancements
        scroll = {
            enabled = true,
            animate = {
                duration = { step = 15, total = 250 },
                easing = "linear",
            },
        },
        statuscolumn = { enabled = false },

        -- Word highlighting
        words = {
            enabled = true,
            debounce = 200,
            notify_jump = false,
            notify_end = true,
            foldopen = true,
            jumplist = true,
            modes = { "n", "i", "c" },
        },

        -- File renaming
        rename = { enabled = true },

        -- Zen mode
        zen = {
            enabled = true,
            toggles = {
                dim = true,
                git_signs = false,
                mini_diff_signs = false,
                diagnostics = false,
                inlay_hints = false,
            },
            show = {
                statusline = false,
                tabline = false,
            },
            win = {
                style = "zen",
                backdrop = {
                    transparent = false,
                    blend = 95,
                },
            },
            zoom = {
                toggles = {},
                show = {
                    statusline = true,
                    tabline = true
                },
                win = {
                    backdrop = false,
                    width = 120,
                },
            },
        },

        -- Animation system
        animate = {
            enabled = vim.fn.has("nvim-0.10") == 1,
            duration = 20,
            easing = "linear",
            fps = 60,
        },

        -- Dimming
        dim = { enabled = false },

        -- Notifications
        notifier = {
            enabled = true,
            timeout = 3000,
            width = { min = 40, max = 0.4 },
            height = { min = 1, max = 0.6 },
            margin = { top = 0, right = 1, bottom = 0 },
            padding = true,
            sort = { "level", "added" },
            level = vim.log.levels.TRACE,
            icons = {
                error = " ",
                warn = " ",
                info = " ",
                debug = " ",
                trace = " ",
            },
            keep = function(notif)
                return vim.fn.getcmdpos() > 0
            end,
            style = "compact",
            top_down = true,
        },

        -- Picker (fuzzy finder)
        picker = {
            enabled = true,
            win = {
                input = {
                    keys = {
                        ["<C-j>"] = { "move", "down" },
                        ["<C-k>"] = { "move", "up" },
                    },
                },
            },
        },

        -- Buffer deletion
        bufdelete = { enabled = true },

        -- Scratch buffers
        scratch = { enabled = true },
    },

    keys = {
        -- Dashboard and navigation
        { "<leader>,",  function() require("snacks").picker.buffers() end,                        desc = "Buffers (Snacks)" },
        { "<leader>:",  function() require("snacks").picker.command_history() end,                desc = "Command History" },
        { "<leader>sn", function() require("snacks").picker.notifications() end,                  desc = "Notification History" },

        -- Terminal
        { "<leader>tt", function() require("snacks").terminal() end,                              desc = "Open Terminal" },
        { "<c-t>",      function() require("snacks").terminal.toggle() end,                       desc = "Toggle Terminal",             mode = { "n", "t" } },

        -- Explorer
        { "<leader>e",  function() require("snacks").explorer() end,                              desc = "Open Snacks Explorer" },

        -- Git operations
        { "<leader>Gb", function() require("snacks").git.blame_line() end,                        desc = "Git Blame Line" },
        { "<leader>GB", function() require("snacks").gitbrowse() end,                             desc = "Git Browse",                  mode = { "n", "v" } },
        { "<leader>Gf", function() require("snacks").lazygit.log_file() end,                      desc = "Lazygit Current File History" },
        { "<leader>GG", function() require("snacks").lazygit() end,                               desc = "Open Lazygit" },
        { "<leader>Gl", function() require("snacks").lazygit.log() end,                           desc = "Lazygit Log" },

        -- Zen mode
        { "<leader>z",  function() require("snacks").zen.zen() end,                               desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() require("snacks").zen.zoom() end,                              desc = "Zoom Current Window" },

        -- Buffer management
        { "<leader>bc", function() require("snacks").bufdelete() end,                             desc = "Close/Delete current buffer" },
        { "<leader>ba", function() require("snacks").bufdelete.all() end,                         desc = "Delete All Buffers" },
        { "<leader>bo", function() require("snacks").bufdelete.other() end,                       desc = "Delete Other Buffers" },

        -- Utilities
        { "<leader>.",  function() require("snacks").scratch() end,                               desc = "Scratch Buffer" },
        { "<leader>S",  function() require("snacks").scratch.select() end,                        desc = "Select Scratch Buffer" },
        { "<leader>rf", function() require("snacks").rename.rename_file() end,                    desc = "Rename current file" },

        -- Word references (updated keybindings)
        { "<leader>]w", function() require("snacks").words.jump(vim.v.count1) end,                desc = "Next Word Reference",         mode = { "n", "t" } },
        { "<leader>[w", function() require("snacks").words.jump(-vim.v.count1) end,               desc = "Previous Word Reference",     mode = { "n", "t" } },

        -- Toggle utilities
        { "<leader>uL", function() vim.opt.relativenumber = not vim.opt.relativenumber:get() end, desc = "Toggle Relative Line Numbers" },
        { "<leader>ud", function() require("snacks").toggle.diagnostics() end,                    desc = "Toggle Diagnostics" },
        { "<leader>ul", function() require("snacks").toggle.line_number() end,                    desc = "Toggle Line Numbers" },
        { "<leader>uc", function() require("snacks").toggle.conceallevel() end,                   desc = "Toggle Conceallevel" },
        { "<leader>uh", function() require("snacks").toggle.inlay_hints() end,                    desc = "Toggle Inlay Hints" },
        { "<leader>uD", function() require("snacks").toggle.dim() end,                            desc = "Toggle Dim Mode" },

        -- Notifications
        { "<leader>un", function() require("snacks").notifier.show_history() end,                 desc = "Show Notification History" },
        { "<leader>uN", function() require("snacks").notifier.hide() end,                         desc = "Dismiss All Notifications" },
    },

    config = function(_, opts)
        require("snacks").setup(opts)

        -- Terminal-specific autocommands
        vim.api.nvim_create_augroup("SnacksTermHooks", { clear = true })
        vim.api.nvim_create_autocmd("TermOpen", {
            group = "SnacksTermHooks",
            callback = function()
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                vim.opt_local.cursorline = false
                vim.opt_local.signcolumn = "no"
            end,
        })
    end,
}
