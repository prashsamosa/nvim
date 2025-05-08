-- Configure 'todo-comments.nvim' for highlighting and navigating TODO-like comments.

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency.
  event = "VeryLazy",                         -- Load lazily for faster startup.
  opts = {
    signs = true,                             -- Show icons in the signs column
    sign_priority = 8,                        -- Sign priority

    -- Keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = " ",                                 -- Icon used for the sign, and in search results
        color = "error",                            -- Can be a hex color, or a named color
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Alternatives
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },

    gui_style = {
      fg = "NONE", -- The gui style to use for the fg highlight group.
      bg = "BOLD", -- The gui style to use for the bg highlight group.
    },

    merge_keywords = true, -- When true, custom keywords will be merged with default

    -- Highlighting of the line containing the todo comment
    highlight = {
      multiline = true,                -- Enable across multiple lines
      multiline_pattern = "^.",        -- Lua pattern to match the next multiline from the start of the matched keyword
      multiline_context = 10,          -- Extra lines for context
      before = "",                     -- "fg" or "bg" or empty
      keyword = "wide",                -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty
      after = "fg",                    -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)\s*:]], -- Pattern used for highlighting
      comments_only = true,            -- Highlight only inside comments using treesitter
      max_line_len = 400,              -- Ignore lines longer than this
      exclude = {},                    -- List of file types to exclude highlighting
    },

    -- List of named colors where we can set custom colors
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test = { "Identifier", "#FF00FF" }
    },

    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    },
  },
}
