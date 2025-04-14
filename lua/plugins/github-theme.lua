-- Configure the 'github-nvim-theme' for a GitHub-inspired Neovim appearance.
-- This plugin customizes Neovim's colors and styles to match GitHub's look.

return {
  "projekt0n/github-nvim-theme", -- Plugin specification on GitHub.
  priority = 1000,                 -- Load early for consistent UI rendering.
  config = function()
    local theme_options = {
      options = {
        compile_path = vim.fn.stdpath("cache") .. "/github-theme", -- Cache compiled theme for faster loading.
        compile_file_suffix = "_compiled",                             -- Suffix for the compiled theme file.

        -- Appearance Options
        transparent = true,         -- Use a transparent background for Neovim windows.
        terminal_colors = true,     -- Apply theme colors to Neovim's terminal windows.
        dim_inactive = false,       -- Prevent inactive windows from being dimmed.
        hide_end_of_buffer = true, -- Hide '~' characters at the end of buffers.
        hide_nc_statusline = true, -- Hide statusline in non-current windows.

        -- Text Styling Options
        styles = { -- Customize styling of specific syntax groups.
          comments = "italic",
          functions = "bold",
          keywords = "italic",
          types = "bold",
          -- Refer to the theme's documentation for other customizable syntax groups.
        },

        -- Inverse Highlight Options
        inverse = { -- Control color inversion for certain elements.
          match_paren = true, -- Invert matching parentheses.
          visual = false,    -- Do not invert visually selected text.
          search = true,     -- Invert search matches.
        },

        -- Window Darkening Options
        darken = { -- Options for darkening background of certain window types.
          floats = true, -- Darken floating windows (e.g., Telescope, LSP popups).
          sidebars = { -- Configuration for darkening sidebar-like windows.
            enable = true,
            list = { "neo-tree", "qf", "help" }, -- List of window names/filetypes considered sidebars.
          },
        },

        -- Plugin Support
        modules = { -- Enable theme-specific styling for various plugins.
          lsp_trouble = true, -- Support for lsp-trouble.nvim.
          cmp = true,         -- Support for nvim-cmp.
          gitsigns = true,    -- Support for gitsigns.nvim.
          treesitter = true,  -- Support for nvim-treesitter.
          telescope = true,   -- Support for telescope.nvim.
          dap = true,         -- Support for Neovim's DAP.
          native_lsp = true, -- Ensure proper theming for native LSP.
          notify = true,      -- Support for Neovim's notification system.
          mini = true,        -- Support for the mini.nvim plugin suite.
        },
      },
    }

    -- Configure the GitHub theme using its setup function.
    require("github-theme").setup(theme_options)

    -- Set the colorscheme to the desired GitHub dark default variant.
    local ok, _ = pcall(vim.cmd, "colorscheme github_dark_default")
    if not ok then
      vim.notify("Colorscheme 'github_dark_default' not found!", vim.log.levels.WARN)
      return -- Exit if the colorscheme cannot be loaded.
    end

    -- Apply a transparent background to specific UI elements if transparency is enabled.
    local hl = vim.api.nvim_set_hl
    if theme_options.options.transparent then -- Access the option through the local variable
      hl(0, "Normal", { bg = "none" })
      hl(0, "NormalNC", { bg = "none" })
      hl(0, "NormalFloat", { bg = "none" })
      hl(0, "FloatBorder", { bg = "none" })
      hl(0, "TelescopeNormal", { bg = "none" })
      hl(0, "TelescopeBorder", { bg = "none" })
      hl(0, "Pmenu", { bg = "none" })
    end

    -- Define a table of GitHub theme colors for potential custom UI elements or plugin configurations.
    local colors = {
      bg = "#0d1117",     -- Default background color.
      bg_float = "#1a1b26", -- Background for floating windows.
      fg = "#c9d1d9",     -- Default foreground (text) color.
      border = "#30363d",   -- Border color.
      keyword = "#ff7b72",  -- Keyword color.
      constant = "#79c0ff", -- Constant color.
      func = "#d2a8ff",    -- Function name color.
      string = "#a5d6ff",  -- String color.
      comment = "#8b949e", -- Comment color.
      git_removed = "#f85149",-- Git removed lines color.
      warning = "#f0883e",  -- Warning color.
    }

    -- Custom highlight groups for mini.notify to align with the GitHub theme.
    hl(0, "MiniNotifyBorder", { bg = "none", fg = colors.border })
    hl(0, "MiniNotifyNormal", { bg = colors.bg_float, fg = colors.fg, blend = 0 })
    hl(0, "MiniNotifyTitle", { fg = colors.constant, bold = true })
    hl(0, "MiniNotifyTitleError", { fg = colors.git_removed, bold = true })
    hl(0, "MiniNotifyTitleWarn", { fg = colors.warning, bold = true })
    hl(0, "MiniNotifyTitleInfo", { fg = colors.func, bold = true })
    hl(0, "MiniNotifyTitleTrace", { fg = colors.comment, bold = true })
  end,
}