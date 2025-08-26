return {
    -- Core mini.nvim library
    { "echasnovski/mini.nvim", version = false },

    -- Icons for consistent iconography
    {
        "echasnovski/mini.icons",
        version = false,
        config = function()
            require("mini.icons").setup()
        end,
        desc = "Icon provider",
    },

    -- Text objects
    {
        "echasnovski/mini.ai",
        version = false,
        event = "VeryLazy",
        config = function()
            local ai = require("mini.ai")
            ai.setup({
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                    d = { "%f[%d]%d+" }, -- digits
                    e = {      -- Word with case
                        {
                            "%u[%l%d]+%f[^%l%d]",
                            "%f[%S][%l%d]+%f[^%l%d]",
                            "%f[%P][%l%d]+%f[^%l%d]",
                            "^[%l%d]+%f[^%l%d]",
                        },
                        "^().*()$",
                    },
                    u = ai.gen_spec.function_call(),                 -- u for "Usage"
                    U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
                },
            })
        end,
        desc = "Enhanced text objects",
    },

    -- Surround manipulation
    {
        "echasnovski/mini.surround",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup({
                mappings = {
                    add = "gsa",  -- Add surrounding in Normal and Visual modes
                    delete = "gsd", -- Delete surrounding
                    find = "gsf", -- Find surrounding (to the right)
                    find_left = "gsF", -- Find surrounding (to the left)
                    highlight = "gsh", -- Highlight surrounding
                    replace = "gsr", -- Replace surrounding
                    update_n_lines = "gsn", -- Update `n_lines`
                },
            })
        end,
        desc = "Surround text objects manipulation",
    },

    -- Operators like replace, evaluate, etc.
    {
        "echasnovski/mini.operators",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.operators").setup({
                evaluate = {
                    prefix = "g=",
                    func = nil,
                },
                exchange = {
                    prefix = "gx",
                    reindent_linewise = true,
                },
                multiply = {
                    prefix = "gm",
                    func = nil,
                },
                replace = {
                    prefix = "gr",
                    reindent_linewise = true,
                },
                sort = {
                    prefix = "gs",
                    func = nil,
                },
            })
        end,
        desc = "Additional text operators",
    },

    -- Auto pairs
    {
        "echasnovski/mini.pairs",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.pairs").setup({
                modes = { insert = true, command = true, terminal = false },
                mappings = {
                    ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
                    ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
                    ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
                    [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
                    ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
                    ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
                    ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
                    ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
                    ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
                },
            })
        end,
        desc = "Auto-completion of bracket pairs",
    },

    -- Bracketed text navigation
    {
        "echasnovski/mini.bracketed",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.bracketed").setup({
                buffer = { suffix = "b", options = {} },
                comment = { suffix = "c", options = {} },
                conflict = { suffix = "x", options = {} },
                diagnostic = { suffix = "d", options = {} },
                file = { suffix = "f", options = {} },
                indent = { suffix = "i", options = {} },
                jump = { suffix = "j", options = {} },
                location = { suffix = "l", options = {} },
                oldfile = { suffix = "o", options = {} },
                quickfix = { suffix = "q", options = {} },
                treesitter = { suffix = "t", options = {} },
                undo = { suffix = "u", options = {} },
                window = { suffix = "w", options = {} },
                yank = { suffix = "y", options = {} },
            })
        end,
        desc = "Navigate through various text objects with brackets",
    },

    -- Fuzzy finder
    {
        "echasnovski/mini.pick",
        version = false,
        cmd = { "Pick" },
        config = function()
            local pick = require("mini.pick")
            pick.setup({
                delay = {
                    async = 10,
                    busy = 50,
                },
                mappings = {
                    caret_left = "<C-b>",
                    caret_right = "<C-f>",
                    choose = "<CR>",
                    choose_in_split = "<C-s>",
                    choose_in_tabpage = "<C-t>",
                    choose_in_vsplit = "<C-v>",
                    choose_marked = "<M-CR>",
                    delete_char = "<BS>",
                    delete_char_right = "<Del>",
                    delete_left = "<C-u>",
                    delete_word = "<C-w>",
                    mark = "<C-x>",
                    mark_all = "<C-a>",
                    move_down = "<C-j>",
                    move_start = "<C-g>",
                    move_up = "<C-k>",
                    paste = "<C-r>",
                    refine = "<C-Space>",
                    refine_marked = "<M-Space>",
                    scroll_down = "<C-d>",
                    scroll_left = "<C-h>",
                    scroll_right = "<C-l>",
                    scroll_up = "<C-u>",
                    stop = "<Esc>",
                    toggle_info = "<S-Tab>",
                    toggle_preview = "<Tab>",
                },
                options = {
                    content_from_bottom = false,
                    use_cache = false,
                },
                source = {
                    items = nil,
                    name = nil,
                    cwd = nil,
                    show = pick.default_show,
                    preview = pick.default_preview,
                    choose = pick.default_choose,
                    choose_marked = pick.default_choose_marked,
                },
                window = {
                    config = {
                        border = "rounded",
                        relative = "editor",
                    },
                    prompt_cursor = "▏",
                    prompt_prefix = "❯ ",
                },
            })

            -- Custom pickers
            vim.keymap.set("n", "<leader>mp", function()
                pick.builtin.files()
            end, { desc = "Pick files" })

            vim.keymap.set("n", "<leader>mg", function()
                pick.builtin.grep_live()
            end, { desc = "Grep live" })

            vim.keymap.set("n", "<leader>mb", function()
                pick.builtin.buffers()
            end, { desc = "Pick buffers" })

            vim.keymap.set("n", "<leader>mh", function()
                pick.builtin.help()
            end, { desc = "Pick help" })

            vim.keymap.set("n", "<leader>mr", function()
                pick.builtin.resume()
            end, { desc = "Resume last pick" })
        end,
        desc = "Fuzzy finder and picker",
    },

    -- Notifications
    {
        "echasnovski/mini.notify",
        version = false,
        event = "VeryLazy",
        config = function()
            local notify = require("mini.notify")

            notify.setup({
                content = {
                    format = notify.default_format,
                    sort = notify.default_sort,
                },
                lsp_progress = {
                    enable = true,
                    duration_last = 1000,
                },
                window = {
                    config = {
                        border = "rounded",
                    },
                    max_width_share = 0.382,
                    winblend = 25,
                },
            })

            vim.notify = notify.make_notify({
                ERROR = { duration = 10000, hl_group = "DiagnosticError" },
                WARN = { duration = 8000, hl_group = "DiagnosticWarn" },
                INFO = { duration = 5000, hl_group = "DiagnosticInfo" },
                DEBUG = { duration = 2000, hl_group = "DiagnosticHint" },
                TRACE = { duration = 2000, hl_group = "DiagnosticHint" },
                OFF = { duration = 0 },
            })
        end,
        desc = "Notification system",
    },

    -- Session management
    {
        "echasnovski/mini.sessions",
        version = false,
        lazy = false,
        config = function()
            local sessions = require("mini.sessions")

            sessions.setup({
                autoread = false,
                autowrite = true,
                directory = vim.fn.stdpath("data") .. "/sessions",
                file = "",
                force = { read = false, write = true, delete = false },
                hooks = {
                    pre = { read = nil, write = nil, delete = nil },
                    post = { read = nil, write = nil, delete = nil },
                },
                verbose = { read = false, write = true, delete = true },
            })

            -- Session keymaps
            vim.keymap.set("n", "<leader>Ss", function()
                sessions.write(vim.fn.input("Session name: "))
            end, { desc = "Write session" })

            vim.keymap.set("n", "<leader>Sr", function()
                sessions.select("read")
            end, { desc = "Read session" })

            vim.keymap.set("n", "<leader>Sd", function()
                sessions.select("delete")
            end, { desc = "Delete session" })

            vim.keymap.set("n", "<leader>SL", function()
                sessions.read(sessions.detected)
            end, { desc = "Read last session" })
        end,
        desc = "Session management",
    },

    -- Indentation guides
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("mini.indentscope").setup({
                draw = {
                    delay = 100,
                    animation = require("mini.indentscope").gen_animation.none(),
                    priority = 2,
                },
                mappings = {
                    object_scope = "ii",
                    object_scope_with_border = "ai",
                    goto_top = "[i",
                    goto_bottom = "]i",
                },
                options = {
                    border = "both",
                    indent_at_cursor = true,
                    try_as_border = false,
                },
                symbol = "╎",
            })

            -- Disable for certain filetypes
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help", "alpha", "dashboard", "neo-tree", "Trouble", "trouble",
                    "lazy", "mason", "notify", "toggleterm", "lazyterm", "snacks_dashboard"
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
        desc = "Indentation scope visualization",
    },

    -- Move lines and selections
    {
        "echasnovski/mini.move",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.move").setup({
                mappings = {
                    left = "<M-h>",
                    right = "<M-l>",
                    down = "<M-j>",
                    up = "<M-k>",
                    line_left = "<M-h>",
                    line_right = "<M-l>",
                    line_down = "<M-j>",
                    line_up = "<M-k>",
                },
                options = {
                    reindent_linewise = true,
                },
            })
        end,
        desc = "Move lines and selections",
    },

    -- Comment functionality
    {
        "echasnovski/mini.comment",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.comment").setup({
                options = {
                    custom_commentstring = function()
                        return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                    end,
                    ignore_blank_line = false,
                    start_of_line = false,
                    pad_comment_parts = true,
                },
                mappings = {
                    comment = "gc",
                    comment_line = "gcc",
                    comment_visual = "gc",
                    textobject = "gc",
                },
                hooks = {
                    pre = function() end,
                    post = function() end,
                },
            })
        end,
        desc = "Smart code commenting",
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                opts = { enable_autocmd = false },
            },
        },
    },

    -- Splitjoin
    {
        "echasnovski/mini.splitjoin",
        version = false,
        keys = {
            { "gS", desc = "Split/Join" },
        },
        config = function()
            require("mini.splitjoin").setup({
                mappings = {
                    toggle = "gS",
                    split = "",
                    join = "",
                },
                detect = {
                    brackets = nil,
                    separator = ",",
                    exclude_regions = nil,
                },
                split = {
                    hooks_pre = {},
                    hooks_post = {},
                },
                join = {
                    hooks_pre = {},
                    hooks_post = {},
                },
            })
        end,
        desc = "Split and join arguments",
    },

    -- Highlight patterns
    {
        "echasnovski/mini.hipatterns",
        version = false,
        event = "VeryLazy",
        config = function()
            local hipatterns = require("mini.hipatterns")
            hipatterns.setup({
                highlighters = {
                    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
                    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
                    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
        desc = "Highlight patterns in text",
    },
}
