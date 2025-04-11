return {
    "projekt0n/github-nvim-theme",
    -- Load this plugin early to set the colorscheme before other UI elements
    priority = 1000,
    config = function()
        -- Set up the GitHub theme with appropriate settings
        require("github-theme").setup({
            options = {
                -- Path for compiled theme cache
                compile_path = vim.fn.stdpath("cache") .. "/github-theme",
                compile_file_suffix = "_compiled",

                -- Appearance options
                transparent = true,        -- Use transparency for consistency
                terminal_colors = true,    -- Apply theme colors to terminal
                dim_inactive = false,      -- Don't dim inactive windows
                hide_end_of_buffer = true, -- Hide end of buffer characters
                hide_nc_statusline = true, -- Hide statusline in inactive windows

                -- Text styling options
                styles = {
                    comments = "italic", -- Italicize comments
                    functions = "bold",  -- Make functions bold
                    keywords = "italic", -- Italicize keywords
                    types = "bold",      -- Make types bold
                },

                -- Inverse highlight options
                inverse = {
                    match_paren = true, -- Highlight matching parentheses differently
                    visual = false,     -- Don't inverse highlight visual selections
                    search = true,      -- Highlight search matches with inverse colors
                },

                -- Window darkening options
                darken = {
                    floats = true, -- Darken floating windows
                    sidebars = {
                        enable = true,
                        list = { "neo-tree", "qf", "help" }, -- Darken these special buffers
                    },
                },

                -- Explicitly enable support for various plugins
                modules = {
                    lsp_trouble = true,
                    cmp = true,
                    gitsigns = true,
                    treesitter = true,
                    telescope = true,
                    dap = true,
                    native_lsp = true,
                    notify = true, -- Enable built-in notify styling
                    mini = true,   -- Enable built-in mini styling
                },
            },
        })

        -- Try to set the colorscheme, notify if it fails
        local ok, _ = pcall(vim.cmd, "colorscheme github_dark_default")
        if not ok then
            vim.notify("Colorscheme 'github_dark_default' not found!", vim.log.levels.WARN)
            return
        end

        -- Apply transparent background to various UI elements if desired
        -- (Comment out this section if you want to keep backgrounds)
        local hl = vim.api.nvim_set_hl
        hl(0, "Normal", { bg = "none" })
        hl(0, "NormalNC", { bg = "none" })
        hl(0, "NormalFloat", { bg = "none" })
        hl(0, "FloatBorder", { bg = "none" })
        hl(0, "TelescopeNormal", { bg = "none" })
        hl(0, "TelescopeBorder", { bg = "none" })
        hl(0, "Pmenu", { bg = "none" })

        -- GitHub theme colors
        local colors = {
            bg = "#0d1117",          -- Background color
            bg_float = "#1a1b26",    -- Float background color
            fg = "#c9d1d9",          -- Default text color
            border = "#30363d",      -- Border color
            keyword = "#ff7b72",     -- Keyword color
            constant = "#79c0ff",    -- Constant color
            func = "#d2a8ff",        -- Function color
            string = "#a5d6ff",      -- String color
            comment = "#8b949e",     -- Comment color
            git_removed = "#f85149", -- Git removed color (for errors)
            warning = "#f0883e",     -- Warning color
        }

        -- Custom mini.notify highlights to match GitHub theme perfectly
        hl(0, "MiniNotifyBorder", { bg = "none", fg = colors.border })
        hl(0, "MiniNotifyNormal", { bg = colors.bg_float, fg = colors.fg, blend = 0 })
        hl(0, "MiniNotifyTitle", { fg = colors.constant, bold = true })
        hl(0, "MiniNotifyTitleError", { fg = colors.git_removed, bold = true })
        hl(0, "MiniNotifyTitleWarn", { fg = colors.warning, bold = true })
        hl(0, "MiniNotifyTitleInfo", { fg = colors.func, bold = true })
        hl(0, "MiniNotifyTitleTrace", { fg = colors.comment, bold = true })
    end,
}