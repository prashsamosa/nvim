return {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar" },
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- icons support
    },
    keys = {
        {
            "<leader>sr",
            function() require("grug-far").open() end,
            desc = "GrugFar: Search & Replace",
        },
        {
            "<leader>sR",
            function()
                require("grug-far").open({
                    engine = "astgrep",
                    visualSelectionUsage = "prefill-search",
                })
            end,
            desc = "GrugFar: AST Search & Replace",
        },
        {
            "<leader>sw",
            function()
                require("grug-far").open({
                    prefills = { search = vim.fn.expand("<cword>") },
                })
            end,
            desc = "GrugFar: Search Word Under Cursor",
        },
        {
            "<leader>sb",
            function()
                require("grug-far").open({
                    prefills = { paths = vim.fn.expand("%") },
                })
            end,
            desc = "GrugFar: Search in Current Buffer",
        },
        {
            "<leader>sf",
            function()
                require("grug-far").open({
                    prefills = { paths = vim.fn.getcwd() },
                })
            end,
            desc = "GrugFar: Search in Project Root",
        },
        {
            "<leader>sv",
            mode = "v",
            function()
                require("grug-far").open({
                    visualSelectionUsage = "prefill-search",
                })
            end,
            desc = "GrugFar: Search Visual Selection",
        },
    },

    config = function()
        local function safe_git_root()
            local lines = vim.fn.systemlist("git rev-parse --show-toplevel")
            if #lines > 0 and lines[1] ~= "" then
                return lines[1]
            else
                return vim.fn.getcwd()
            end
        end

        require("grug-far").setup({
            debounceMs = 500,
            minSearchChars = 2,
            maxSearchMatches = 2000,
            startInInsertMode = true,
            windowCreationCommand = "vsplit",
            disableBufferLineNumbers = true,
            showCompactInputs = true,

            helpLine = { enabled = true },
            useScratchBuffer = true,

            openTargetWindow = {
                preferredLocation = "left",
                exclude = { "grug-far" },
            },

            folding = {
                enabled = true,
                foldlevel = 1,
                foldcolumn = "1",
            },

            keymaps = {
                replace = { n = "<leader>r", i = "<C-r>" },
                qflist = { n = "<leader>q" },
                syncLocations = { n = "<leader>ss" }, -- changed to avoid conflict
                close = { n = "q", i = "<C-q>" },
                gotoLocation = { n = "<CR>" },
                openNextLocation = { n = "<C-n>" },
                openPrevLocation = { n = "<C-p>" },
                historyOpen = { n = "<leader>h" },
                swapEngine = { n = "<leader>e" },
                previewLocation = { n = "<leader>p" },
                nextInput = { n = "<Tab>", i = "<Tab>" },
                prevInput = { n = "<S-Tab>", i = "<S-Tab>" },
            },

            icons = {
                enabled = true,
                fileIconsProvider = "nvim-web-devicons",
            },

            engines = {
                ripgrep = {
                    placeholders = {
                        search = "e.g. foo    [Aa]b?c    \\w+",
                        replacement = "e.g. bar    $1    ${1:default}",
                        filesFilter = "e.g. *.lua    src/**/*.js    !**/node_modules",
                        flags = "e.g. --ignore-case --multiline",
                    },
                },
                astgrep = {
                    placeholders = {
                        search = "e.g. console.log($A)    function $FUNC($$$ARGS) { $$$ }",
                        replacement = "e.g. logger.info($A)    const $FUNC = ($$$ARGS) => { $$$ }",
                        filesFilter = "e.g. *.js *.ts    **/*.{vue,svelte}",
                    },
                },
                astgrep_rules = {
                    placeholders = {
                        search = "e.g. no-console    custom-rule-name",
                        filesFilter = "e.g. *.js *.ts",
                    },
                },
            },

            history = {
                enabled = true,
                maxHistoryLines = 3000,
                autoSave = {
                    enabled = true,
                    onReplace = true,
                    onSyncAll = true,
                    onBufDelete = true,
                    onExit = true,
                },
            },

            pathProviders = {
                buflist = function()
                    return require("grug-far.pathProviders").getBuflistFiles()
                end,
                cwd = function()
                    return { vim.fn.getcwd() }
                end,
                git = function()
                    return { safe_git_root() }
                end,
            },

            resultsPreview = {
                enabled = true,
                maxWidth = 80,
                maxHeight = 20,
            },

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
                        return require("grug-far.pathProviders").getBuflistFiles()
                    end,
                },
                git_root = {
                    icon = "󰊢",
                    desc = "Git Root",
                    callback = function()
                        return { safe_git_root() }
                    end,
                },
            },
        })
    end,
}
