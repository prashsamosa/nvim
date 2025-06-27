return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim" },
  event = "VeryLazy",
  opts = {
    signs = true,
    sign_priority = 8,

    -- Define keyword types and icons
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },

    -- GUI style
    gui_style = {
      fg = "NONE",
      bg = "BOLD",
    },

    merge_keywords = true,

    -- Highlighting options
    highlight = {
      multiline = true,
      multiline_pattern = "^.",
      multiline_context = 10,
      before = "",
      keyword = "wide",
      after = "fg",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = true,
      max_line_len = 400,
      exclude = {},
    },

    -- Custom colors
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test = { "Identifier", "#FF00FF" },
    },

    -- Ripgrep search setup
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      pattern = [[\b(KEYWORDS):]],
    },
  },
  keys = {
    { "]t",         function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
    { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous TODO comment" },
    { "<leader>st", "<cmd>TodoTelescope<CR>",                            desc = "Search TODOs (Telescope)" },
  },
}
