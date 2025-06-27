return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    init = function()
        _G.dd = function(...)
            Snacks.debug.inspect(...)
        end
        _G.bt = function()
            Snacks.debug.backtrace()
        end
        vim.print = _G.dd

        vim.opt.fillchars:append({
            vert = " ",
            fold = " ",
            eob = " ",
            diff = " ",
            msgsep = " ",
        })

        vim.cmd("highlight IndentBlanklineChar guifg=NONE")

        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function() end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "OilActionsPost",
            callback = function(event)
                local data = event.data and event.data.actions
                if data and data.type == "move" and data.src_url and data.dest_url then
                    Snacks.rename.on_rename_file(data.src_url, data.dest_url)
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
 ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
                ]],
            },
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { section = "startup" },
            },
        },

        input = { enabled = false },

        terminal = {
            enabled = true,
            win = {
                style = "terminal",
                position = "bottom",
                height = 0.3,
                width = 0.8,
                border = "rounded",
            },
            shell = vim.o.shell,
            interactive = true,
        },

        scope = {
            enabled = true,
            min_size = 2,
            cursor = true,
            edge = true,
            siblings = false,
            filter = function(buf)
                return vim.bo[buf].buftype == "" and vim.b[buf].snacks_scope ~= false and vim.g.snacks_scope ~= false
            end,
            debounce = 30,
            treesitter = {
                enabled = true,
                injections = true,
                blocks = {
                    enabled = false,
                    "function_declaration",
                    "function_definition",
                    "method_declaration",
                    "method_definition",
                    "class_declaration",
                    "class_definition",
                    "do_statement",
                    "while_statement",
                    "repeat_statement",
                    "if_statement",
                    "for_statement",
                },
                field_blocks = {
                    "local_declaration",
                },
            },
            keys = {
                textobject = {
                    ii = {
                        min_size = 2,
                        edge = false,
                        cursor = false,
                        treesitter = { blocks = { enabled = false } },
                        desc = "inner scope",
                    },
                    ai = {
                        cursor = false,
                        min_size = 2,
                        treesitter = { blocks = { enabled = false } },
                        desc = "full scope",
                    },
                },
                jump = {
                    ["[i"] = {
                        min_size = 1,
                        bottom = false,
                        cursor = false,
                        edge = true,
                        treesitter = { blocks = { enabled = false } },
                        desc = "jump to top edge of scope",
                    },
                    ["]i"] = {
                        min_size = 1,
                        bottom = true,
                        cursor = false,
                        edge = true,
                        treesitter = { blocks = { enabled = false } },
                        desc = "jump to bottom edge of scope",
                    },
                },
            },
        },

        explorer = {
            enabled = true,
            actions = {
                ["<cr>"] = "open",
                ["<c-v>"] = "vsplit",
                ["<c-x>"] = "split",
                ["<c-t>"] = "tabnew",
            },
        },

        git = { enabled = true },

        lazygit = {
            enabled = true,
            configure = true,
            args = {},
            config = {
                os = { editPreset = "nvim-remote" },
                gui = { nerdFontsVersion = "3" },
            },
            theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
            theme = {
                [241] = { fg = "Special" },
                activeBorderColor = { fg = "MatchParen", bold = true },
                cherryPickedCommitBgColor = { fg = "Identifier" },
                cherryPickedCommitFgColor = { fg = "Function" },
                defaultFgColor = { fg = "Normal" },
                inactiveBorderColor = { fg = "FloatBorder" },
                optionsTextColor = { fg = "Function" },
                searchingActiveBorderColor = { fg = "MatchParen", bold = true },
                selectedLineBgColor = { bg = "Visual" },
                unstagedChangesColor = { fg = "DiagnosticError" },
            },
            win = { style = "lazygit" },
        },

        debug = { enabled = true },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = false },

        words = {
            enabled = true,
            debounce = 200,
            notify_jump = false,
            notify_end = true,
            foldopen = true,
            jumplist = true,
            modes = { "n", "i", "c" },
            filter = function(buf)
                return vim.g.snacks_words ~= false and vim.b[buf].snacks_words ~= false
            end,
        },

        rename = { enabled = true },

        zen = {
            enabled = true,
            toggles = {
                dim = true,
                git_signs = false,
                mini_diff_signs = false,
            },
            show = {
                statusline = false,
                tabline = false,
            },
            win = { style = "zen" },
            on_open = function(win) end,
            on_close = function(win) end,
            zoom = {
                toggles = {},
                show = { statusline = true, tabline = true },
                win = {
                    backdrop = false,
                    width = 0,
                },
            },
        },

        -- notifier = {
        --     enabled = true,
        --     timeout = 3000,
        -- },

        animate = {
            enabled = true,
            duration = 20,
            easing = "linear",
            fps = 60,
        },

        dim = { enabled = false },
    },

    keys = {
        {
            "<leader>,",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>n",
            function()
                Snacks.picker.notifications()
            end,
            desc = "Notification History",
        },
        {
            "<leader>tt",
            function()
                Snacks.terminal()
            end,
            desc = "Terminal",
        },
        {
            "<c-t>",
            function()
                Snacks.terminal.toggle()
            end,
            desc = "Toggle Terminal (Alt)",
            mode = { "n", "t" },
        },
        {
            "<leader>TT",
            function()
                Snacks.terminal.open()
            end,
            desc = "New Terminal",
        },
        {
            "<leader>e",
            function()
                Snacks.explorer()
            end,
            desc = "Explorer",
        },
        {
            "<leader>gb",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Git Blame Line",
        },
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse",
            mode = { "n", "v" },
        },
        {
            "<leader>gf",
            function()
                Snacks.lazygit.log_file()
            end,
            desc = "Lazygit Current File History",
        },
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "<leader>gl",
            function()
                Snacks.lazygit.log()
            end,
            desc = "Lazygit Log",
        },
        {
            "<leader>z",
            function()
                Snacks.zen()
            end,
            desc = "Toggle Zen Mode",
        },
        {
            "<leader>Z",
            function()
                Snacks.zen.zoom()
            end,
            desc = "Zoom Current Window",
        },
        {
            "<leader>bd",
            function()
                Snacks.bufdelete()
            end,
            desc = "Delete Buffer",
        },
        {
            "<leader>ba",
            function()
                Snacks.bufdelete.all()
            end,
            desc = "Delete All Buffers",
        },
        {
            "<leader>bo",
            function()
                Snacks.bufdelete.other()
            end,
            desc = "Delete Other Buffers",
        },
        {
            "<leader>.",
            function()
                Snacks.scratch()
            end,
            desc = "Scratch Buffer",
        },
        {
            "<leader>S",
            function()
                Snacks.scratch.select()
            end,
            desc = "Select Scratch",
        },
        {
            "<leader>rf",
            function()
                Snacks.rename.rename_file()
            end,
            desc = "Rename File",
        },
        {
            "<leader>wn",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
            mode = { "n", "t" },
        },
        {
            "<leader>wp",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
            mode = { "n", "t" },
        },
        -- { "<leader>un",      function() Snacks.notifier.hide() end,           desc = "Hide Notifications" },
        -- { "<leader>uN",      function() Snacks.notifier.show_history() end,   desc = "Show Notification History" },
        {
            "<leader><space>",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
    },

    config = function(_, opts)
        require("snacks").setup(opts)

        vim.api.nvim_create_autocmd("TermOpen", {
            callback = function()
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                vim.opt_local.cursorline = false
                vim.opt_local.signcolumn = "no"
            end,
        })
    end,
}
