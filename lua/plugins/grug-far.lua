return {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar" },
    keys = {
        -- Main search interface (avoiding conflict with <leader>sd - diagnostics)
        {
            "<leader>gf",
            function()
                require("grug-far").open()
            end,
            desc = "Search & Replace (GrugFar)",
        },

        -- Search with AST-grep for structural patterns
        {
            "<leader>gF",
            function()
                require("grug-far").open({
                    engine = "astgrep",
                    visualSelectionUsage = "prefill-search",
                })
            end,
            desc = "AST Search & Replace",
        },

        -- Search current word under cursor (avoiding conflict with <leader>sw - workspace diagnostics)
        {
            "<leader>gw",
            function()
                require("grug-far").open({
                    prefills = { search = vim.fn.expand("<cword>") },
                })
            end,
            desc = "Search Word Under Cursor",
        },

        -- Search in current buffer only
        {
            "<leader>gb",
            function()
                require("grug-far").open({
                    prefills = { paths = vim.fn.expand("%") },
                })
            end,
            desc = "Search in Current Buffer",
        },

        -- Search with visual selection
        {
            "<leader>gv",
            function()
                require("grug-far").open({
                    visualSelectionUsage = "prefill-search",
                })
            end,
            mode = "v",
            desc = "Search Visual Selection",
        },

        -- Toggle visibility (avoiding conflict with terminals)
        {
            "<leader>gt",
            function()
                require("grug-far").toggle()
            end,
            desc = "Toggle GrugFar",
        },
    },

    config = function()
        require("grug-far").setup({
            -- Performance optimizations
            debounceMs = 500,   -- Increased for better performance
            minSearchChars = 2, -- Reduced for more immediate feedback
            maxSearchMatches = 2000,

            -- UI preferences
            startInInsertMode = true,
            windowCreationCommand = 'vsplit',

            -- Visual improvements
            disableBufferLineNumbers = true,
            showCompactInputs = true,

            -- Help and guidance
            helpLine = {
                enabled = true,
            },

            -- Window management
            openTargetWindow = {
                preferredLocation = 'left',
                exclude = { 'grug-far' },
            },

            -- Buffer optimization
            useScratchBuffer = true,

            -- Folding for better result organization
            folding = {
                enabled = true,
                foldlevel = 1,
                foldcolumn = '1',
            },

            -- Improved keymaps with better ergonomics
            keymaps = {
                replace = { n = '<leader>r', i = '<C-r>' },
                qflist = { n = '<leader>q' },
                syncLocations = { n = '<leader>s' },
                close = { n = 'q', i = '<C-q>' }, -- Easier to reach
                gotoLocation = { n = '<CR>' },
                openNextLocation = { n = '<C-n>' },
                openPrevLocation = { n = '<C-p>' },
                historyOpen = { n = '<leader>h' },
                swapEngine = { n = '<leader>e' },
                previewLocation = { n = '<leader>p' },
                nextInput = { n = '<Tab>', i = '<Tab>' },
                prevInput = { n = '<S-Tab>', i = '<S-Tab>' },
            },

            -- Icons (requires Nerd Font)
            icons = {
                enabled = true,
                fileIconsProvider = 'nvim-web-devicons',
            },

            -- Enhanced engine configurations
            engines = {
                ripgrep = {
                    placeholders = {
                        search = 'e.g. foo    [Aa]b?c    \\w+',
                        replacement = 'e.g. bar    $1    ${1:default}',
                        filesFilter = 'e.g. *.lua    src/**/*.js    !**/node_modules',
                        flags = 'e.g. --ignore-case --multiline',
                    },
                },
                astgrep = {
                    placeholders = {
                        search = 'e.g. console.log($A)    function $FUNC($$$ARGS) { $$$ }',
                        replacement = 'e.g. logger.info($A)    const $FUNC = ($$$ARGS) => { $$$ }',
                        filesFilter = 'e.g. *.js *.ts    **/*.{vue,svelte}',
                    },
                },
                astgrep_rules = {
                    placeholders = {
                        search = 'e.g. no-console    custom-rule-name',
                        filesFilter = 'e.g. *.js *.ts',
                    },
                },
            },

            -- History for persistence
            history = {
                enabled = true,
                maxHistoryLines = 3000, -- Reduced for better performance
                autoSave = {
                    onReplace = true,
                    onSyncAll = true,
                    onBufDelete = true,
                },
            },

            -- Useful path providers
            pathProviders = {
                buflist = function()
                    return require('grug-far.pathProviders').getBuflistFiles()
                end,
                cwd = function()
                    return { vim.fn.getcwd() }
                end,
                git = function()
                    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
                    return git_root and { git_root } or { vim.fn.getcwd() }
                end,
            },

            -- Result display options
            resultsPreview = {
                enabled = true,
                maxWidth = 80,
                maxHeight = 20,
            },

            -- Search scope shortcuts
            searchScopeShortcuts = {
                current_file = {
                    icon = "󰈙",
                    desc = "Current File",
                    callback = function()
                        return { vim.fn.expand("%") }
                    end,
                },
                open_buffers = {
                    icon = "󰘢",
                    desc = "Open Buffers",
                    callback = function()
                        return require('grug-far.pathProviders').getBuflistFiles()
                    end,
                },
                git_root = {
                    icon = "󰊢",
                    desc = "Git Root",
                    callback = function()
                        local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
                        return git_root and { git_root } or { vim.fn.getcwd() }
                    end,
                },
            },
        })
    end,
}
