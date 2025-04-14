-- Configure 'todo-comments.nvim' for highlighting and navigating TODO-like comments.

return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency.
    event = "VeryLazy",                         -- Load lazily for faster startup.
  
    config = function()
      require("todo-comments").setup({
        signs = true,          -- Show icons in the sign column.
        sign_priority = 8,     -- Priority of signs (higher = closer to text).
        keywords = {
          FIX = {
            icon = " ",      -- Icon for FIX comments.
            color = "error",    -- Highlight color.
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Alternative keywords.
          },
          TODO = { icon = " ", color = "info" },   -- Icon and color for TODO.
          HACK = { icon = " ", color = "warning" }, -- Icon and color for HACK.
          WARN = {
            icon = " ",      -- Icon for WARN.
            color = "warning",
            alt = { "WARNING", "XXX" }, -- Alternative keywords.
          },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } }, -- Performance notes.
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },             -- General notes.
          TEST = {
            icon = "⏲ ",      -- Icon for TEST.
            color = "test",
            alt = { "TESTING", "PASSED", "FAILED" }, -- Alternative keywords.
          },
        },
        highlight = {
          multiline = true,          -- Highlight multiline comments.
          multiline_pattern = "^.",  -- Match each line.
          multiline_context = 10,   -- Lines of context for multiline.
          keyword = "wide",          -- Highlight the entire keyword.
          after = "fg",            -- Highlight text after the keyword.
          pattern = [[.*<(KEYWORDS)\s*:]], -- Pattern to match keywords.
          comments_only = true,      -- Search only within comments.
          max_line_len = 400,        -- Maximum line length to search.
          exclude = {},              -- Exclude files/directories.
        },
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },     -- Red.
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" }, -- Yellow.
          info = { "DiagnosticInfo", "#2563EB" },                   -- Blue.
          hint = { "DiagnosticHint", "#10B981" },                   -- Green.
          default = { "Identifier", "#7C3AED" },                   -- Purple.
          test = { "Identifier", "#FF00FF" },                     -- Magenta.
        },
        search = {
          command = "rg",        -- Use ripgrep.
          args = {
            "--color=never",     -- Disable color output.
            "--no-heading",      -- Don't show headings.
            "--with-filename",   -- Include filenames.
            "--line-number",     -- Include line numbers.
            "--column",          -- Include column numbers.
          },
          pattern = [[\b(KEYWORDS):]], -- Pattern to find keywords.
        },
      })
  
      -- Keybindings for navigation.
      vim.keymap.set("n", "]t", require("todo-comments").jump_next, { desc = "Next TODO comment" })
      vim.keymap.set("n", "[t", require("todo-comments").jump_prev, { desc = "Previous TODO comment" })
    end,
  }