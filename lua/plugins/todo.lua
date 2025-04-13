return {
  "folke/todo-comments.nvim", -- The plugin specification: name of the GitHub repository.
  dependencies = { "nvim-lua/plenary.nvim" }, -- A Lua utility library for Neovim, required by todo-comments.
  event = "VeryLazy", -- Load this plugin lazily, only when needed, to improve startup time.
  config = function() -- Configuration function that runs when the plugin is loaded.
      require("todo-comments").setup({ -- Call the setup function of todo-comments.nvim with the following options.
          signs = true, -- Enable the display of signs (markers) in the sign column for TODO comments.
          sign_priority = 8, -- Set the priority of the signs. Higher numbers are displayed closer to the text.
          keywords = { -- Define the keywords to look for and their associated properties.
              FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
              -- 'FIX' keyword with an error icon, error color, and alternative spellings.
              TODO = { icon = " ", color = "info" },
              -- 'TODO' keyword with an info icon and info color.
              HACK = { icon = " ", color = "warning" },
              -- 'HACK' keyword with a warning icon and warning color.
              WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
              -- 'WARN' keyword with a warning icon, warning color, and alternative spellings.
              PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
              -- 'PERF' keyword with an icon and alternative spellings.
              NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
              -- 'NOTE' keyword with a hint icon, hint color, and alternative spelling.
              TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
              -- 'TEST' keyword with a test icon, test color, and alternative spellings.
          },
          highlight = { -- Configuration for how TODO comments are highlighted.
              multiline = true, -- Enable highlighting of multiline TODO comments.
              multiline_pattern = "^.", -- Pattern to match for each line of a multiline comment.
              multiline_context = 10, -- Number of context lines to highlight for multiline comments.
              before = "", -- Text to add before the highlighted keyword.
              keyword = "wide", -- How to highlight the keyword ("wide" highlights the whole word).
              after = "fg", -- How to highlight after the keyword ("fg" uses the foreground color).
              pattern = [[.*<(KEYWORDS)\s*:]], -- Regular expression pattern to find keywords.
                                             -- (KEYWORDS) will be replaced by the defined keywords.
              comments_only = true, -- Only search for keywords within comment regions.
              max_line_len = 400, -- Maximum line length to search within.
              exclude = {}, -- File patterns to exclude from searching.
          },
          colors = { -- Define the colors used for highlighting based on the keyword.
              error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
              -- Use DiagnosticError, ErrorMsg highlight groups or the hex color.
              warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
              info = { "DiagnosticInfo", "#2563EB" },
              hint = { "DiagnosticHint", "#10B981" },
              default = { "Identifier", "#7C3AED" }, -- Default color if no specific color is defined.
              test = { "Identifier", "#FF00FF" },
          },
          search = { -- Configuration for how to search for TODO comments.
              command = "rg", -- Use ripgrep for searching (requires ripgrep to be installed).
              args = { -- Arguments passed to the search command.
                  "--color=never", -- Don't include color codes in the output.
                  "--no-heading", -- Don't include file name headings for each file.
                  "--with-filename", -- Include the filename in the output.
                  "--line-number", -- Include the line number in the output.
                  "--column", -- Include the column number in the output.
              },
              pattern = [[\b(KEYWORDS):]], -- Regular expression pattern to search for.
                                         -- \b for word boundary, (KEYWORDS) replaced by defined keywords.
          },
      })

      -- Keymaps for jumping between TODO comments.
      vim.keymap.set("n", "]t", function()
          require("todo-comments").jump_next() -- Jump to the next TODO comment in the buffer.
      end, { desc = "Next todo comment" })

      vim.keymap.set("n", "[t", function()
          require("todo-comments").jump_prev() -- Jump to the previous TODO comment in the buffer.
      end, { desc = "Previous todo comment" })
  end,
}