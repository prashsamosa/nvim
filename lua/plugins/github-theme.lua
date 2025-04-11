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
                transparent = false,       -- Don't use transparency by default
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
                    notify = true, -- Important: enable notify styling
                },
            },
        })

        -- Try to set the colorscheme, notify if it fails
        local ok, _ = pcall(vim.cmd, "colorscheme github_dark_default")
        if not ok then
            vim.notify("Colorscheme 'github_dark_default' not found!", vim.log.levels.WARN)
            return
        end

        -- Apply transparent background to various UI elements
        local hl = vim.api.nvim_set_hl
        hl(0, "Normal", { bg = "none" })
        hl(0, "NormalNC", { bg = "none" })
        hl(0, "NormalFloat", { bg = "none" })
        hl(0, "FloatBorder", { bg = "none" })
        hl(0, "TelescopeNormal", { bg = "none" })
        hl(0, "TelescopeBorder", { bg = "none" })
        hl(0, "Pmenu", { bg = "none" })

        -- Define custom colors for mini.notify
        -- Using hardcoded GitHub theme colors instead of requiring the module
        local colors = {
            bg = {
                float = "#1a1a1a", -- Dark background for floating windows
            },
            fg = {
                default = "#c9d1d9", -- Default text color
            },
            syntax = {
                keyword = "#ff7b72",  -- Keyword color (for borders)
                constant = "#79c0ff", -- Constant color (for titles)
                func = "#d2a8ff",     -- Function color (for info)
                comment = "#8b949e",  -- Comment color (for trace)
            },
            git = {
                removed = "#f85149", -- Git removed color (for errors)
            }
        }

        -- Apply custom highlights for mini.notify
        hl(0, "MiniNotifyBorder", { bg = "none", fg = colors.syntax.keyword })
        hl(0, "MiniNotifyNormal", { bg = colors.bg.float, fg = colors.fg.default, blend = 0 })
        hl(0, "MiniNotifyTitle", { fg = colors.syntax.constant, bold = true })
        hl(0, "MiniNotifyTitleError", { fg = colors.git.removed, bold = true })
        hl(0, "MiniNotifyTitleWarn", { fg = colors.syntax.constant, bold = true })
        hl(0, "MiniNotifyTitleInfo", { fg = colors.syntax.func, bold = true })
        hl(0, "MiniNotifyTitleTrace", { fg = colors.syntax.comment, bold = true })
    end,
}
