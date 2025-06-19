return {
  -- Core mini.nvim library
  { "echasnovski/mini.nvim", version = false },

  -- Smart commenting
  {
    "echasnovski/mini.comment",
    version = false,
    lazy = false,
    opts = {
      options = {
        ignore_blank_line = false,
        start_of_line = false,
        pad_comment_parts = true,
      },
      mappings = {
        comment = "gc",
        comment_line = "gcc",
        textobject = "gc",
      },
    },
    desc = "Smart code commenting",
  },

  -- Text objects
  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      require("mini.ai").setup()
    end,
  },

  -- Surround manipulation
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
  },

  -- Operators like replace, evaluate, etc.
  {
    "echasnovski/mini.operators",
    version = false,
    config = function()
      require("mini.operators").setup()
    end,
  },

  -- Auto pairs
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("mini.pairs").setup()
    end,
  },

  -- Bracketed text navigation
  {
    "echasnovski/mini.bracketed",
    version = false,
    config = function()
      require("mini.bracketed").setup()
    end,
  },

  -- Buffer remove
  {
    "echasnovski/mini.bufremove",
    version = false,
    config = function()
      vim.keymap.set("n", "<leader>mb", function()
        require("mini.bufremove").delete(0, false)
      end, { desc = "Delete buffer" })

      vim.keymap.set("n", "<leader>mB", function()
        require("mini.bufremove").delete(0, true)
      end, { desc = "Force delete buffer" })
    end,
  },

  -- File explorer
  {
    "echasnovski/mini.files",
    version = false,
    config = function()
      require("mini.files").setup()
      vim.keymap.set("n", "<leader>me", function()
        require("mini.files").open()
      end, { desc = "File explorer" })
    end,
  },

  -- Fuzzy finder
  {
    "echasnovski/mini.pick",
    version = false,
    config = function()
      require("mini.pick").setup()

      vim.keymap.set("n", "<leader>mp", function()
        require("mini.pick").builtin.files()
      end, { desc = "Pick files" })

      vim.keymap.set("n", "<leader>mg", function()
        require("mini.pick").builtin.grep_live()
      end, { desc = "Grep live" })
    end,
  },

  -- Notifications
  {
    "echasnovski/mini.notify",
    version = false,
    event = "VeryLazy",
    config = function()
      local has_winblend = pcall(function()
        local win_id = vim.api.nvim_open_win(0, false, {
          relative = "editor", width = 1, height = 1, row = 0, col = 0, style = "minimal", winblend = 0
        })
        vim.api.nvim_win_close(win_id, true)
        return true
      end)

      local config = {
        window = {
          config = {
            border = "rounded",
            width = 60,
            winblend = has_winblend and 0 or nil,
          },
        },
        content = {
          default_timeout_ms = 5000,
        },
        lsp_progress = {
          enable = true,
          duration_ms = 500,
        },
      }

      require("mini.notify").setup(config)
      vim.notify = require("mini.notify").make_notify()
    end,
  },

  -- Session management
  {
    "echasnovski/mini.sessions",
    version = false,
    lazy = false,
    config = function()
      require("mini.sessions").setup({
        autoread = true,
        autowrite = true,
        directory = vim.fn.stdpath("data") .. "/sessions",
        file = "Session.vim",
        verbose = { read = false, write = true, delete = true },
      })

      vim.keymap.set("n", "<leader>ms", function()
        require("mini.sessions").write(nil)
      end, { desc = "Write session" })

      vim.keymap.set("n", "<leader>mr", function()
        require("mini.sessions").read(nil)
      end, { desc = "Read last session" })

      vim.keymap.set("n", "<leader>md", function()
        require("mini.sessions").delete(nil)
      end, { desc = "Delete session" })
    end,
  },

  -- Indentation guides
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 100,
          animation = require("mini.indentscope").gen_animation.none(),
        },
        symbol = "╎",
      })
    end,
  },
}
