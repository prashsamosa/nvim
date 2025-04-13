-- This file configures the 'github-nvim-theme' plugin, which provides a
-- Neovim colorscheme inspired by the look and feel of GitHub. It allows
-- you to customize various aspects of the theme, such as transparency,
-- terminal colors, and syntax highlighting styles.

return {
    "projekt0n/github-nvim-theme", -- The plugin specification: name of the GitHub repository.
    -- Load this plugin early in the startup process. This is important for
    -- colorschemes because you want the colors to be set before other UI
    -- elements are drawn, ensuring a consistent appearance. A higher
    -- `priority` value means it will be loaded earlier.
    priority = 1000,
    config = function() -- Configuration function that runs when the plugin is loaded.
        -- Set up the GitHub theme with the specified options.
        require("github-theme").setup({
            options = {
                -- Path for compiled theme cache. Compiling the theme can improve
                -- performance by caching the highlight groups.
                compile_path = vim.fn.stdpath("cache") .. "/github-theme",
                -- Suffix for the compiled theme cache file.
                compile_file_suffix = "_compiled",

                -- ===== Appearance Options =====
                transparent = true,         -- Use a transparent background. This can
                                            -- blend the editor with your terminal's
                                            -- background for a seamless look.
                terminal_colors = true,     -- Apply the theme's colors to the Neovim
                                            -- terminal emulator windows.
                dim_inactive = false,       -- Prevent dimming of inactive windows.
                                            -- By default, some themes might slightly
                                            -- darken windows that don't have focus.
                hide_end_of_buffer = true, -- Hide the '~' characters that indicate
                                            -- the end of a buffer beyond the last line.
                hide_nc_statusline = true, -- Hide the statusline in non-current (inactive)
                                            -- windows. This can reduce visual clutter.

                -- ===== Text Styling Options =====
                styles = {
                    comments = "italic",    -- Render comments in italics.
                    functions = "bold",     -- Render function names in bold.
                    keywords = "italic",    -- Render language keywords in italics.
                    types = "bold",       -- Render type names in bold.
                    -- You can customize other syntax groups here as well.
                    -- See the theme's documentation for available groups.
                },

                -- ===== Inverse Highlight Options =====
                inverse = {
                    match_paren = true,     -- Highlight matching parentheses with an
                                            -- inverted color scheme.
                    visual = false,        -- Don't apply inverse highlighting to
                                            -- visually selected text.
                    search = true,         -- Highlight search matches with inverted colors.
                },

                -- ===== Window Darkening Options =====
                darken = {
                    floats = true,         -- Darken the background of floating windows
                                            -- (e.g., Telescope, LSP info popups).
                    sidebars = {
                        enable = true,       -- Enable darkening for sidebar-like windows.
                        list = { "neo-tree", "qf", "help" }, -- A list of buffer names or
                                                            -- filetypes that should be
                                                            -- considered sidebars and darkened.
                                                            -- "neo-tree" is likely a file explorer,
                                                            -- "qf" is the quickfix/location list,
                                                            -- and "help" is the help window.
                    },
                },

                -- ===== Explicitly Enable Support for Various Plugins =====
                -- This section ensures that the theme provides specific styling
                -- for popular Neovim plugins.
                modules = {
                    lsp_trouble = true,   -- Support for the 'lsp-trouble.nvim' plugin
                                            -- for displaying LSP diagnostics.
                    cmp = true,           -- Support for completion plugins like 'nvim-cmp'.
                    gitsigns = true,      -- Support for 'gitsigns.nvim' for Git integration.
                    treesitter = true,    -- Support for 'nvim-treesitter' for enhanced
                                            -- syntax highlighting.
                    telescope = true,     -- Support for the 'telescope.nvim' fuzzy finder.
                    dap = true,           -- Support for the Debug Adapter Protocol (DAP)
                                            -- for debugging.
                    native_lsp = true,    -- Support for Neovim's built-in LSP client.
                    notify = true,        -- Enable built-in styling for Neovim's
                                            -- notification system (e.g., `vim.notify`).
                    mini = true,          -- Enable built-in styling for plugins from
                                            -- the 'mini.nvim' suite.
                },
            },
        })

        -- Attempt to set the colorscheme. The `pcall` function runs the command
        -- and captures any errors.
        local ok, _ = pcall(vim.cmd, "colorscheme github_dark_default")
        if not ok then
            -- If setting the colorscheme fails (e.g., the theme file is not found),
            -- display a warning notification to the user.
            vim.notify("Colorscheme 'github_dark_default' not found!", vim.log.levels.WARN)
            return -- Exit the configuration function to prevent further errors.
        end

        -- Apply transparent background to various UI elements if the 'transparent'
        -- option is enabled. This section manually sets the background color
        -- of specific highlight groups to "none".
        -- (Comment out this section if you want to keep the default backgrounds
        -- provided by the theme for these elements).
        local hl = vim.api.nvim_set_hl -- Alias for the Neovim API function to set
                                     -- highlight groups.
        hl(0, "Normal", { bg = "none" })       -- Normal text background.
        hl(0, "NormalNC", { bg = "none" })     -- Normal text in non-current windows.
        hl(0, "NormalFloat", { bg = "none" })  -- Background of floating windows.
        hl(0, "FloatBorder", { bg = "none" })  -- Border of floating windows.
        hl(0, "TelescopeNormal", { bg = "none" }) -- Background of Telescope windows.
        hl(0, "TelescopeBorder", { bg = "none" }) -- Border of Telescope windows.
        hl(0, "Pmenu", { bg = "none" })        -- Background of the popup menu (e.g.,
                                            -- for completion).

        -- Define a table of GitHub theme colors. This is not directly used by
        -- the theme setup itself but is used below to customize other UI elements
        -- to match the theme's palette.
        local colors = {
            bg = "#0d1117",         -- Background color
            bg_float = "#1a1b26",     -- Float background color
            fg = "#c9d1d9",         -- Default text color
            border = "#30363d",       -- Border color
            keyword = "#ff7b72",      -- Keyword color
            constant = "#79c0ff",     -- Constant color
            func = "#d2a8ff",        -- Function color
            string = "#a5d6ff",      -- String color
            comment = "#8b949e",      -- Comment color
            git_removed = "#f85149",  -- Git removed color (for errors)
            warning = "#f0883e",      -- Warning color
        }

        -- Custom highlight groups for 'mini.notify' to perfectly match the
        -- GitHub theme's colors. This ensures that notifications from the
        -- 'mini.notify' plugin have a consistent look with the rest of the UI.
        hl(0, "MiniNotifyBorder", { bg = "none", fg = colors.border })
        hl(0, "MiniNotifyNormal", { bg = colors.bg_float, fg = colors.fg, blend = 0 })
        hl(0, "MiniNotifyTitle", { fg = colors.constant, bold = true })
        hl(0, "MiniNotifyTitleError", { fg = colors.git_removed, bold = true })
        hl(0, "MiniNotifyTitleWarn", { fg = colors.warning, bold = true })
        hl(0, "MiniNotifyTitleInfo", { fg = colors.func, bold = true })
        hl(0, "MiniNotifyTitleTrace", { fg = colors.comment, bold = true })
    end,
}