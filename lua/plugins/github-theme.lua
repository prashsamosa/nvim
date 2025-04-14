-- Configure the 'github-nvim-theme' for a GitHub-inspired Neovim appearance.
-- This plugin customizes Neovim's colors and styles to match GitHub's look.

return {
    "projekt0n/github-nvim-theme", -- Plugin specification.
    priority = 1000, -- Load early for consistent UI appearance.
    config = function()
        -- Configure the GitHub theme.
        require("github-theme").setup({
            options = {
                compile_path = vim.fn.stdpath("cache") .. "/github-theme", -- Cache compiled theme for performance.
                compile_file_suffix = "_compiled",

                -- Appearance Options
                transparent = true,        -- Use a transparent background.
                terminal_colors = true,    -- Apply theme colors to terminal windows.
                dim_inactive = false,      -- Don't dim inactive windows.
                hide_end_of_buffer = true, -- Hide the '~' at the end of buffers.
                hide_nc_statusline = true, -- Hide statusline in inactive windows.

                -- Text Styling Options
                styles = { -- Customize syntax highlighting styles.
                    comments = "italic",
                    functions = "bold",
                    keywords = "italic",
                    types = "bold",
                    -- See theme docs for other customizable groups.
                },

                -- Inverse Highlight Options
                inverse = { -- Customize how certain elements are highlighted.
                    match_paren = true, -- Invert colors for matching parentheses.
                    visual = false,      -- Don't invert visual selections.
                    search = true,      -- Invert colors for search matches.
                },

                -- Window Darkening Options
                darken = { -- Darken certain window backgrounds.
                    floats = true, -- Darken floating windows (Telescope, LSP popups).
                    sidebars = { -- Darken sidebar-like windows.
                        enable = true,
                        list = { "neo-tree", "qf", "help" }, -- Sidebar window names/filetypes.
                    },
                },

                -- Plugin Support
                modules = { -- Enable theme support for specific plugins.
                    lsp_trouble = true, -- lsp-trouble.nvim
                    cmp = true,         -- nvim-cmp
                    gitsigns = true,    -- gitsigns.nvim
                    treesitter = true,  -- nvim-treesitter
                    telescope = true,   -- telescope.nvim
                    dap = true,         -- Debug Adapter Protocol (DAP)
                    native_lsp = true,  -- Neovim's built-in LSP
                    notify = true,      -- Neovim's notification system
                    mini = true,        -- mini.nvim suite
                },
            },
        })

        -- Set the colorscheme, handle errors if not found.
        local ok, _ = pcall(vim.cmd, "colorscheme github_dark_default")
        if not ok then
            vim.notify("Colorscheme 'github_dark_default' not found!", vim.log.levels.WARN)
            return
        end

        -- Apply transparent background to UI elements (if transparency is enabled).
        local hl = vim.api.nvim_set_hl
        hl(0, "Normal", { bg = "none" })
        hl(0, "NormalNC", { bg = "none" })
        hl(0, "NormalFloat", { bg = "none" })
        hl(0, "FloatBorder", { bg = "none" })
        hl(0, "TelescopeNormal", { bg = "none" })
        hl(0, "TelescopeBorder", { bg = "none" })
        hl(0, "Pmenu", { bg = "none" })

        -- GitHub theme colors (used for custom UI elements).
        local colors = {
            bg = "#0d1117",        -- Background
            bg_float = "#1a1b26",  -- Float background
            fg = "#c9d1d9",        -- Text
            border = "#30363d",    -- Border
            keyword = "#ff7b72",   -- Keyword
            constant = "#79c0ff",  -- Constant
            func = "#d2a8ff",     -- Function
            string = "#a5d6ff",     -- String
            comment = "#8b949e",    -- Comment
            git_removed = "#f85149", -- Git removed
            warning = "#f0883e",    -- Warning
        }

        -- Custom highlight groups for mini.notify (to match the theme).
        hl(0, "MiniNotifyBorder", { bg = "none", fg = colors.border })
        hl(0, "MiniNotifyNormal", { bg = colors.bg_float, fg = colors.fg, blend = 0 })
        hl(0, "MiniNotifyTitle", { fg = colors.constant, bold = true })
        hl(0, "MiniNotifyTitleError", { fg = colors.git_removed, bold = true })
        hl(0, "MiniNotifyTitleWarn", { fg = colors.warning, bold = true })
        hl(0, "MiniNotifyTitleInfo", { fg = colors.func, bold = true })
        hl(0, "MiniNotifyTitleTrace", { fg = colors.comment, bold = true })
    end,
}