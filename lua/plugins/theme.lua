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

        require("github-theme").setup(opts)

        -- Fix: Use a wrapper function to avoid type issues with pcall
        local ok, err = pcall(function()
            vim.cmd("colorscheme github_dark_default")
        end)
        if not ok then
            vim.notify("Colorscheme 'github_dark_default' not found! Error: " .. tostring(err), vim.log.levels.WARN)
            return
        end

        local hl = vim.api.nvim_set_hl
        if opts.options.transparent then
            local transparent_groups = {
                "Normal",
                "NormalNC",
                "NormalFloat",
                "FloatBorder",
                "TelescopeNormal",
                "TelescopeBorder",
                "Pmenu",
            }
            for _, group in ipairs(transparent_groups) do
                hl(0, group, { bg = "none" })
            end
        end

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

        local custom_hl = {
            MiniNotifyBorder = { bg = "none", fg = colors.border },
            MiniNotifyNormal = { bg = colors.bg_float, fg = colors.fg, blend = 0 },
            MiniNotifyTitle = { fg = colors.constant, bold = true },
            MiniNotifyTitleError = { fg = colors.git_removed, bold = true },
            MiniNotifyTitleWarn = { fg = colors.warning, bold = true },
            MiniNotifyTitleInfo = { fg = colors.func, bold = true },
            MiniNotifyTitleTrace = { fg = colors.comment, bold = true },
        }

        for group, spec in pairs(custom_hl) do
            hl(0, group, spec)
        end
    end,
}
