-- Configure the 'github-nvim-theme' for a GitHub-inspired Neovim appearance.
-- This plugin customizes Neovim's colors and styles to match GitHub's look.

return {
    "projekt0n/github-nvim-theme", -- Plugin specification on GitHub.
    priority = 1000,               -- Load this theme early to ensure consistent UI rendering from the start.
    config = function()
        -- Configure the GitHub theme using its setup function.
        require("github-theme").setup({
            options = {
                compile_path = vim.fn.stdpath("cache") .. "/github-theme", -- Directory to cache the compiled theme for faster loading.
                compile_file_suffix = "_compiled", -- Suffix for the compiled theme file.

                -- Appearance Options
                transparent = true,         -- Use a transparent background for Neovim windows.
                terminal_colors = true,     -- Apply the theme's colors to Neovim's terminal windows.
                dim_inactive = false,       -- Prevent inactive windows from being dimmed.
                hide_end_of_buffer = true, -- Hide the '~' characters that indicate the end of a buffer.
                hide_nc_statusline = true, -- Hide the statusline in non-current (inactive) windows.

                -- Text Styling Options
                styles = { -- Customize the styling of specific syntax groups.
                    comments = "italic",
                    functions = "bold",
                    keywords = "italic",
                    types = "bold",
                    -- Refer to the theme's documentation for other customizable syntax groups.
                },

                -- Inverse Highlight Options
                inverse = { -- Control how certain elements have their colors inverted.
                    match_paren = true, -- Invert the colors of matching parentheses when the cursor is on one.
                    visual = false,    -- Do not invert the colors of visually selected text.
                    search = true,     -- Invert the colors of search matches.
                },

                -- Window Darkening Options
                darken = { -- Options for darkening the background of certain window types.
                    floats = true, -- Darken the background of floating windows (e.g., Telescope, LSP popups).
                    sidebars = { -- Configuration for darkening sidebar-like windows.
                        enable = true,
                        list = { "neo-tree", "qf", "help" }, -- A list of window names or filetypes considered sidebars.
                    },
                },

                -- Plugin Support
                modules = { -- Enable theme-specific styling for various popular Neovim plugins.
                    lsp_trouble = true, -- Support for lsp-trouble.nvim (LSP diagnostics in a list).
                    cmp = true,         -- Support for nvim-cmp (completion framework).
                    gitsigns = true,    -- Support for gitsigns.nvim (Git integration in the sign column).
                    treesitter = true,  -- Support for nvim-treesitter (syntax highlighting and more).
                    telescope = true,   -- Support for telescope.nvim (fuzzy finder).
                    dap = true,         -- Support for Neovim's built-in Debug Adapter Protocol (DAP).
                    native_lsp = true,  -- Ensure proper theming for Neovim's native LSP features.
                    notify = true,      -- Support for Neovim's built-in notification system.
                    mini = true,        -- Support for the mini.nvim plugin suite.
                },
            },
        })

        -- Set the colorscheme to the desired GitHub dark default variant.
        local ok, _ = pcall(vim.cmd, "colorscheme github_dark_default")
        if not ok then
            vim.notify("Colorscheme 'github_dark_default' not found!", vim.log.levels.WARN)
            return -- Exit the configuration if the colorscheme cannot be loaded.
        end

        -- Apply a transparent background to specific UI elements if transparency is enabled in the theme options.
        local hl = vim.api.nvim_set_hl
        hl(0, "Normal", { bg = "none" })
        hl(0, "NormalNC", { bg = "none" })
        hl(0, "NormalFloat", { bg = "none" })
        hl(0, "FloatBorder", { bg = "none" })
        hl(0, "TelescopeNormal", { bg = "none" })
        hl(0, "TelescopeBorder", { bg = "none" })
        hl(0, "Pmenu", { bg = "none" })

        -- Define a table of GitHub theme colors for potential use in custom UI elements or plugin configurations.
        local colors = {
            bg = "#0d1117",       -- Default background color.
            bg_float = "#1a1b26", -- Background color for floating windows.
            fg = "#c9d1d9",       -- Default foreground (text) color.
            border = "#30363d",     -- Border color for various elements.
            keyword = "#ff7b72",    -- Color for keywords in code.
            constant = "#79c0ff",   -- Color for constants.
            func = "#d2a8ff",      -- Color for function names.
            string = "#a5d6ff",    -- Color for strings.
            comment = "#8b949e",   -- Color for comments.
            git_removed = "#f85149", -- Color for removed lines in Git diffs.
            warning = "#f0883e",     -- Color for warnings.
        }

        -- Custom highlight groups for mini.notify to align with the GitHub theme's appearance.
        hl(0, "MiniNotifyBorder", { bg = "none", fg = colors.border })
        hl(0, "MiniNotifyNormal", { bg = colors.bg_float, fg = colors.fg, blend = 0 })
        hl(0, "MiniNotifyTitle", { fg = colors.constant, bold = true })
        hl(0, "MiniNotifyTitleError", { fg = colors.git_removed, bold = true })
        hl(0, "MiniNotifyTitleWarn", { fg = colors.warning, bold = true })
        hl(0, "MiniNotifyTitleInfo", { fg = colors.func, bold = true })
        hl(0, "MiniNotifyTitleTrace", { fg = colors.comment, bold = true })
    end,
}