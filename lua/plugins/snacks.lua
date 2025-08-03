return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    init = function()
        local Snacks = require("snacks")

        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end

        vim.opt.fillchars:append({
            vert = " ",
            fold = " ",
            eob = " ",
            diff = " ",
            msgsep = " ",
        })

        vim.cmd("highlight IndentBlanklineChar guifg=NONE")

        vim.api.nvim_create_augroup("SnacksOilHooks", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "SnacksOilHooks",
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
      ███████╗ █████╗ ███╗  ███╗ ██████╗ ███████╗ █████╗
      ██╔════╝██╔══██╗████╗ ████║██╔═══██╗██╔════╝██╔══██╗
      ███████╗███████║██╔████╔██║██║  ██║███████╗███████║
      ╚════██║██╔══██║██║╚██╔╝██║██║  ██║╚════██║██╔══██║
      ███████║██║  ██║██║ ╚═╝ ██║╚██████╔╝███████║██║  ██║
      ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
        ]],
            },
            sections = {
                { section = "header" },
                { section = "keys",   gap = 1, padding = 1 },
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
                return vim.api.nvim_buf_is_valid(buf)
                    and vim.bo[buf].buftype == ""
                    and vim.b[buf].snacks_scope ~= false
                    and vim.g.snacks_scope ~= false
            end,
            debounce = 30,
            treesitter = {
                enabled = true,
                injections = true,
                blocks = false,
                field_blocks = { "local_declaration" },
            },
            keys = {
                textobject = {
                    ii = {
                        min_size = 2,
                        edge = false,
                        cursor = false,
                        treesitter = { blocks = false },
                        desc = "inner scope",
                    },
                    ai = {
                        cursor = false,
                        min_size = 2,
                        treesitter = { blocks = false },
                        desc = "full scope",
                    },
                },
                jump = {
                    ["[i"] = {
                        min_size = 1,
                        bottom = false,
                        cursor = false,
                        edge = true,
                        treesitter = { blocks = false },
                        desc = "jump to top edge of scope",
                    },
                    ["]i"] = {
                        min_size = 1,
                        bottom = true,
                        cursor = false,
                        edge = true,
                        treesitter = { blocks = false },
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
                return vim.api.nvim_buf_is_valid(buf)
                    and vim.g.snacks_words ~= false
                    and vim.b[buf].snacks_words ~= false
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
            zoom = {
                toggles = {},
                show = { statusline = true, tabline = true },
                win = {
                    backdrop = false,
                    width = 0,
                },
            },
        },

        animate = {
            enabled = true,
            duration = 20,
            easing = "linear",
            fps = 60,
        },

        dim = { enabled = false },
    },

    keys = {
        { "<leader>,",  function() require("snacks.picker").buffers() end,                                               desc = "Buffers (Snacks Picker)" },
        { "<leader>:",  function() require("snacks.picker").command_history() end,                                       desc = "Command History" },
        { "<leader>n",  function() require("snacks.picker").notifications() end,                                         desc = "Notification History" },
        { "<leader>tt", function() require("snacks.terminal")() end,                                                     desc = "Open Terminal" },
        { "<c-t>",      function() require("snacks.terminal").toggle() end,                                              desc = "Toggle Terminal",             mode = { "n", "t" } },
        { "<leader>TT", function() require("snacks.terminal").open() end,                                                desc = "New Terminal" },
        { "<leader>e",  function() require("snacks.explorer")() end,                                                     desc = "Open Snacks Explorer" },

        -- Fixed Git keymaps - using correct Snacks.nvim API
        { "<leader>Gb", function() require("snacks.git").blame_line() end,                                               desc = "Git Blame Line" },
        { "<leader>GB", function() require("snacks.gitbrowse")() end,                                                    desc = "Git Browse",                  mode = { "n", "v" } },
        { "<leader>Gf", function() require("snacks.lazygit").log_file() end,                                             desc = "Lazygit Current File History" },
        { "<leader>GG", function() require("snacks.lazygit")() end,                                                      desc = "Open Lazygit" },
        { "<leader>Gl", function() require("snacks.lazygit").log() end,                                                  desc = "Lazygit Log" },

        -- Fixed Zen mode keymaps - providing required arguments
        { "<leader>z",  function() require("snacks.zen").zen() end,                                                      desc = "Toggle Zen Mode" },
        { "<leader>Z",  function() require("snacks.zen").zoom() end,                                                     desc = "Zoom Current Window" },

        -- Buffer management keymaps - using correct API
        { "<leader>bc", function() require("snacks.bufdelete").delete() end,                                             desc = "Close/Delete current buffer" },
        { "<leader>ba", function() require("snacks.bufdelete").all() end,                                                desc = "Delete All Buffers" },
        { "<leader>bo", function() require("snacks.bufdelete").other() end,                                              desc = "Delete Other Buffers" },

        { "<leader>.",  function() require("snacks.scratch")() end,                                                      desc = "Scratch Buffer" },
        { "<leader>S",  function() require("snacks.scratch").select() end,                                               desc = "Select Scratch Buffer" },
        { "<leader>rf", function() require("snacks.rename").rename_file() end,                                           desc = "Rename current file" },

        { "<leader>wn", function() require("snacks.words").jump(vim.v.count1) end,                                       desc = "Next Word Reference",         mode = { "n", "t" } },
        { "<leader>wp", function() require("snacks.words").jump(-vim.v.count1) end,                                      desc = "Previous Word Reference",     mode = { "n", "t" } },

        { "<leader>uL", function() vim.opt.relativenumber = not vim.opt.relativenumber:get() end,                        desc = "Toggle Relative Line Numbers" },
        { "<leader>ud", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,                           desc = "Toggle Diagnostics" },
        { "<leader>ul", function() vim.opt.number = not vim.opt.number:get() end,                                        desc = "Toggle Line Numbers" },
        { "<leader>uc", function() vim.opt.conceallevel = (vim.opt.conceallevel:get() == 0 and 2 or 0) end,              desc = "Toggle Conceallevel" },
        { "<leader>uT", "<cmd>TSHighlightToggle<CR>",                                                                    desc = "Toggle Treesitter Highlights" },
        { "<leader>ub", function() vim.cmd('set background=' .. (vim.o.background == 'dark' and 'light' or 'dark')) end, desc = "Toggle Dark/Light Background" },
        { "<leader>uh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,                   desc = "Toggle Inlay Hints" },
        { "<leader>uD", function() require('snacks.dim').toggle() end,                                                   desc = "Toggle Dim Mode" },

        { "<leader>un", function() vim.diagnostic.hide() end,                                                            desc = "Hide Notifications" },
        { "<leader>uN", function() require("snacks.picker").notifications() end,                                         desc = "Show Notification History" },
    },

    config = function(_, opts)
        require("snacks").setup(opts)

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
