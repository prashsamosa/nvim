return {
    "projekt0n/github-nvim-theme",
    priority = 1000,
    config = function()
        local opts = {
            options = {
                compile_path = vim.fn.stdpath("cache") .. "/github-theme",
                compile_file_suffix = "_compiled",

                transparent = true,
                terminal_colors = true,
                dim_inactive = false,
                hide_end_of_buffer = true,
                hide_nc_statusline = true,

                styles = {
                    comments = "italic",
                    functions = "bold",
                    keywords = "italic",
                    types = "bold",
                },

                inverse = {
                    match_paren = true,
                    visual = false,
                    search = true,
                },

                darken = {
                    floats = true,
                    sidebars = {
                        enable = true,
                        list = { "neo-tree", "qf", "help" },
                    },
                },

                modules = {
                    cmp = true,
                    dap = true,
                    gitsigns = true,
                    lsp_trouble = true,
                    mini = true,
                    native_lsp = true,
                    notify = true,
                    telescope = true,
                    treesitter = true,
                },
            },
        }

        -- Setup the theme
        require("github-theme").setup(opts)

        -- Apply colorscheme with better error handling
        vim.cmd("colorscheme github_dark_default")

        -- Define colors for consistent theming
        local colors = {
            bg = "#0d1117",
            bg_float = "#1a1b26",
            fg = "#c9d1d9",
            border = "#30363d",
            keyword = "#ff7b72",
            constant = "#79c0ff",
            func = "#d2a8ff",
            string = "#a5d6ff",
            comment = "#8b949e",
            git_removed = "#f85149",
            warning = "#f0883e",
        }

        local hl = vim.api.nvim_set_hl

        -- Apply transparency if enabled
        if opts.options.transparent then
            local transparent_groups = {
                "Normal",
                "NormalNC",
                "NormalFloat",
                "FloatBorder",
                "TelescopeNormal",
                "TelescopeBorder",
                "Pmenu",
                "PmenuSbar",
                "PmenuThumb",
            }

            for _, group in ipairs(transparent_groups) do
                hl(0, group, { bg = "none" })
            end
        end

        -- Apply custom highlights
        local custom_highlights = {
            -- Mini.nvim notify highlights
            MiniNotifyBorder = { bg = "none", fg = colors.border },
            MiniNotifyNormal = { bg = colors.bg_float, fg = colors.fg, blend = 0 },
            MiniNotifyTitle = { fg = colors.constant, bold = true },
            MiniNotifyTitleError = { fg = colors.git_removed, bold = true },
            MiniNotifyTitleWarn = { fg = colors.warning, bold = true },
            MiniNotifyTitleInfo = { fg = colors.func, bold = true },
            MiniNotifyTitleTrace = { fg = colors.comment, bold = true },

            -- Additional transparency for Blink.cmp if needed
            BlinkCmpMenu = { bg = opts.options.transparent and "none" or colors.bg_float },
            BlinkCmpMenuBorder = { fg = colors.border },
            BlinkCmpDoc = { bg = opts.options.transparent and "none" or colors.bg_float },
            BlinkCmpDocBorder = { fg = colors.border },
        }

        for group, spec in pairs(custom_highlights) do
            hl(0, group, spec)
        end

        -- Create autocmd to reapply highlights after colorscheme changes
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "github_*",
            callback = function()
                for group, spec in pairs(custom_highlights) do
                    hl(0, group, spec)
                end

                if opts.options.transparent then
                    local transparent_groups = {
                        "Normal", "NormalNC", "NormalFloat", "FloatBorder",
                        "TelescopeNormal", "TelescopeBorder", "Pmenu", "PmenuSbar", "PmenuThumb"
                    }
                    for _, group in ipairs(transparent_groups) do
                        hl(0, group, { bg = "none" })
                    end
                end
            end,
        })
    end,
}
