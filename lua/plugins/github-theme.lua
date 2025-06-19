return {
  "projekt0n/github-nvim-theme",
  priority = 1000,
  config = function()
    local theme_options = {
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
          lsp_trouble = true,
          cmp = true,
          gitsigns = true,
          treesitter = true,
          telescope = true,
          dap = true,
          native_lsp = true,
          notify = true,
          mini = true,
        },
      },
    }

    require("github-theme").setup(theme_options)

    local ok = pcall(vim.cmd, "colorscheme github_dark_default")
    if not ok then
      vim.notify("Colorscheme 'github_dark_default' not found!", vim.log.levels.WARN)
      return
    end

    local hl = vim.api.nvim_set_hl
    if theme_options.options.transparent then
      hl(0, "Normal", { bg = "none" })
      hl(0, "NormalNC", { bg = "none" })
      hl(0, "NormalFloat", { bg = "none" })
      hl(0, "FloatBorder", { bg = "none" })
      hl(0, "TelescopeNormal", { bg = "none" })
      hl(0, "TelescopeBorder", { bg = "none" })
      hl(0, "Pmenu", { bg = "none" })
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

    hl(0, "MiniNotifyBorder", { bg = "none", fg = colors.border })
    hl(0, "MiniNotifyNormal", { bg = colors.bg_float, fg = colors.fg, blend = 0 })
    hl(0, "MiniNotifyTitle", { fg = colors.constant, bold = true })
    hl(0, "MiniNotifyTitleError", { fg = colors.git_removed, bold = true })
    hl(0, "MiniNotifyTitleWarn", { fg = colors.warning, bold = true })
    hl(0, "MiniNotifyTitleInfo", { fg = colors.func, bold = true })
    hl(0, "MiniNotifyTitleTrace", { fg = colors.comment, bold = true })
  end,
}
