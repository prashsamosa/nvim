-- Configure various 'mini.nvim' utility plugins by echasnovski.

return {
    -- Core mini.nvim library (foundation for other mini.* plugins).
    {
      "echasnovski/mini.nvim",
      version = false, -- Always use the latest version.
    },
  
    -- Smart code commenting.
    {
      "echasnovski/mini.comment",
      version = false,
      lazy = false, -- Load immediately as commenting is frequently used.
      opts = {
        options = {
          ignore_blank_line = false,
          start_of_line = false,
          pad_comment_parts = true,
        },
        mappings = {
          comment = "gc",       -- Toggle comment for current line/selection.
          comment_line = "gcc",  -- Comment out current line.
          textobject = "gc",    -- Comment text objects (e.g., `gcip`).
        },
      },
      desc = "Smart code commenting",
    },
  
    -- Enhanced text objects.
    {
      "echasnovski/mini.ai",
      version = false,
      config = function()
        require("mini.ai").setup() -- Additional/improved text objects.
      end,
    },
  
    -- Surround management.
    {
      "echasnovski/mini.surround",
      version = false,
      config = function()
        require("mini.surround").setup() -- Easy manipulation of surrounding characters.
      end,
    },
  
    -- Text editing operators.
    {
      "echasnovski/mini.operators",
      version = false,
      config = function()
        require("mini.operators").setup() -- New text editing operators.
      end,
    },
  
    -- Matching pair handling.
    {
      "echasnovski/mini.pairs",
      version = false,
      config = function()
        require("mini.pairs").setup() -- Enhanced handling of matching pairs.
      end,
    },
  
    -- Bracketed text navigation.
    {
      "echasnovski/mini.bracketed",
      version = false,
      config = function()
        require("mini.bracketed").setup() -- Navigation based on brackets.
      end,
    },
  
    -- Buffer removal.
    {
      "echasnovski/mini.bufremove",
      version = false,
      config = function()
        vim.keymap.set("n", "<leader>mb", function()
          require("mini.bufremove").delete(0, false) -- Delete current buffer.
        end, { desc = "Delete buffer" })
  
        vim.keymap.set("n", "<leader>mB", function()
          require("mini.bufremove").delete(0, true)  -- Force delete current buffer.
        end, { desc = "Force delete buffer" })
      end,
    },
  
    -- File explorer.
    {
      "echasnovski/mini.files",
      version = false,
      config = function()
        require("mini.files").setup()
        vim.keymap.set("n", "<leader>me", function()
          require("mini.files").open() -- Open file explorer.
        end, { desc = "File explorer" })
      end,
    },
  
    -- Fuzzy picker.
    {
      "echasnovski/mini.pick",
      version = false,
      config = function()
        require("mini.pick").setup()
        vim.keymap.set("n", "<leader>mp", function()
          require("mini.pick").builtin.files()     -- Open file finder.
        end, { desc = "Pick files" })
  
        vim.keymap.set("n", "<leader>mg", function()
          require("mini.pick").builtin.grep_live() -- Open live grep.
        end, { desc = "Grep live" })
      end,
    },
  
    -- Notifications.
    {
      "echasnovski/mini.notify",
      version = false,
      event = "VeryLazy", -- Load lazily.
      config = function()
        local has_winblend = pcall(function()
          local win_id = vim.api.nvim_open_win(0, false, {
            relative = "editor",
            width = 1,
            height = 1,
            row = 0,
            col = 0,
            style = "minimal",
            winblend = 0,
          })
          vim.api.nvim_win_close(win_id, true)
          return true
        end)
  
        local config = {
          window = {
            config = {
              border = "rounded",
              width = 60,
            },
          },
          content = {
            default_timeout_ms = 5000, -- Default notification duration.
          },
          lsp_progress = {
            enable = true,
            duration_ms = 500,
          },
        }
  
        if has_winblend then
          config.window.config.winblend = 0 -- Set winblend if supported.
        end
  
        require("mini.notify").setup(config)
        vim.notify = require("mini.notify").make_notify() -- Override vim.notify.
      end,
    },
  
    -- Session management.
    {
      "echasnovski/mini.sessions",
      version = false,
      lazy = false, -- Load immediately.
      config = function()
        require("mini.sessions").setup({
          autoread = true,        -- Auto-read last session on startup.
          autowrite = true,       -- Auto-write current session on exit.
          directory = vim.fn.stdpath("data") .. "/sessions", -- Session files directory.
          file = "Session.vim",   -- Default session filename.
          verbose = { read = false, write = true, delete = true },
        })
  
        vim.keymap.set("n", "<leader>ms", function()
          require("mini.sessions").write(nil) -- Write current session.
        end, { desc = "Write session" })
  
        vim.keymap.set("n", "<leader>mr", function()
          require("mini.sessions").read(nil)  -- Read last saved session.
        end, { desc = "Read last session" })
  
        vim.keymap.set("n", "<leader>md", function()
          require("mini.sessions").delete(nil) -- Delete last saved session.
        end, { desc = "Delete session" })
      end,
    },
  
    -- Indentation scope lines.
    {
      "echasnovski/mini.indentscope",
      version = false,
      event = "VeryLazy", -- Load lazily.
      config = function()
        require("mini.indentscope").setup({
          draw = {
            delay = 100,
            animation = require("mini.indentscope").gen_animation.none(), -- Disable animation.
          },
          symbol = "╎", -- Indentation scope line symbol.
        })
      end,
    },
  }