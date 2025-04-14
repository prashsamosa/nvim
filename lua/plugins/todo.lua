return {
    "folke/todo-comments.nvim", -- Manage TODO-style comments
    dependencies = { "nvim-lua/plenary.nvim" }, -- Lua utility library
    event = "VeryLazy", -- Load only when needed
  
    config = function()
      require("todo-comments").setup({
        -- Configuration options
        signs = true, -- Show signs in the sign column
        sign_priority = 8, -- Priority of signs (higher = closer to text)
        keywords = {
          -- Define recognized keywords and their properties
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Alternate spellings
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = {
            icon = " ",
            color = "warning",
            alt = { "WARNING", "XXX" },
          },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = {
            icon = "⏲ ",
            color = "test",
            alt = { "TESTING", "PASSED", "FAILED" },
          },
        },
        highlight = {
          -- Highlighting options for TODO comments
          multiline = true, -- Enable multiline highlighting
          multiline_pattern = "^.", -- Pattern for each line of multiline comment
          multiline_context = 10, -- Lines of context for multiline comments
          before = "", -- Text before keyword
          keyword = "wide", -- Highlight the whole keyword
          after = "fg", -- Highlight after keyword (foreground color)
          pattern = [[.*<(KEYWORDS)\s*:]], -- Pattern to find keywords
          comments_only = true, -- Only search in comments
          max_line_len = 400, -- Max line length to search
          exclude = {}, -- Files/dirs to exclude
        },
        colors = {
          -- Colors for different keywords
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" }, -- Red
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" }, -- Yellow
          info = { "DiagnosticInfo", "#2563EB" }, -- Blue
          hint = { "DiagnosticHint", "#10B981" }, -- Green
          default = { "Identifier", "#7C3AED" }, -- Purple
          test = { "Identifier", "#FF00FF" }, -- Magenta
        },
        search = {
          -- Search options
          command = "rg", -- Use ripgrep
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS):]], -- Pattern to find keywords
        },
      })
  
      -- Keybindings
      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next() -- Jump to next TODO
      end, { desc = "Next todo comment" })
      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev() -- Jump to previous TODO
      end, { desc = "Previous todo comment" })
    end,
  }
  