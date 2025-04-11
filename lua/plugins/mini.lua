return {
  -- Core mini.nvim library
  {
    "echasnovski/mini.nvim",
    version = false,
  },

  -- comment
  {
    "echasnovski/mini.comment",
    version = false,
    lazy = false,
    opts = {
      options = {
        custom_commentstring = nil,
        ignore_blank_line = false,
        start_of_line = false,
        pad_comment_parts = true,
      },
      mappings = {
        comment = "gc",
        comment_line = "gcc",
        comment_visual = "gc",
        textobject = "gc",
      },
      hooks = {
        pre = function() end,
        post = function() end,
      },
    },
    desc = "Smart code commenting using mini.comment",
  },

  -- Text Editing Utilities
  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      require("mini.ai").setup()
    end,
  },

  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
  },

  {
    "echasnovski/mini.operators",
    version = false,
    config = function()
      require("mini.operators").setup()
    end,
  },

  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("mini.pairs").setup()
    end,
  },

  -- General Workflow
  {
    "echasnovski/mini.bracketed",
    version = false,
    config = function()
      require("mini.bracketed").setup()
    end,
  },

  {
    "echasnovski/mini.bufremove",
    version = false,
    config = function()
      vim.keymap.set("n", "<leader>mb", function()
        require("mini.bufremove").delete(0, false)
      end, { desc = "Mini delete buffer" })

      vim.keymap.set("n", "<leader>mB", function()
        require("mini.bufremove").delete(0, true)
      end, { desc = "Mini force delete buffer" })
    end,
  },

  {
    "echasnovski/mini.files",
    version = false,
    config = function()
      require("mini.files").setup()
      vim.keymap.set("n", "<leader>me", function()
        require("mini.files").open()
      end, { desc = "Mini file explorer" })
    end,
  },

  {
    "echasnovski/mini.pick",
    version = false,
    config = function()
      require("mini.pick").setup()
      vim.keymap.set("n", "<leader>mp", function()
        require("mini.pick").builtin.files()
      end, { desc = "Mini pick files" })

      vim.keymap.set("n", "<leader>mg", function()
        require("mini.pick").builtin.grep_live()
      end, { desc = "Mini grep live" })
    end,
  },

  -- UI / Appearance
  {
    "echasnovski/mini.statusline",
    version = false,
    config = function()
      require("mini.statusline").setup({ use_icons = true })
    end,
  },

  -- notify
  {
    "echasnovski/mini.notify",
    version = false,
    event = "VeryLazy",
    config = function()
      -- Test if your Neovim version supports certain window options
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

      -- Basic configuration without the problematic max_width option
      local config = {
        -- Window configuration
        window = {
          config = {
            border = "rounded",
            -- max_width has been removed as it's causing errors
            width = 60,  -- Use fixed width instead
          },
        },
        -- Content configuration
        content = {
          default_timeout_ms = 5000,  -- 5 seconds timeout
        },
        -- LSP progress indicator settings
        lsp_progress = {
          enable = true,
          duration_ms = 500,  -- Animation duration
        },
      }

      -- Only add winblend if your Neovim version supports it
      if has_winblend then
        config.window.config.winblend = 0
      end

      -- Apply configuration
      require("mini.notify").setup(config)
      
      -- Replace Neovim's default notification system
      vim.notify = require("mini.notify").make_notify()
    end,
  },

  -- sessions (replacement for neovim-session-manager)
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
        force = { read = false, write = true, delete = false },
        verbose = { read = false, write = true, delete = true },
      })

      -- Keymaps for session actions
      vim.keymap.set("n", "<leader>ws", function()
        require("mini.sessions").write(nil)
      end, { desc = "Write Session" })

      vim.keymap.set("n", "<leader>wr", function()
        require("mini.sessions").read(nil)
      end, { desc = "Read Last Session" })

      vim.keymap.set("n", "<leader>wd", function()
        require("mini.sessions").delete(nil)
      end, { desc = "Delete Last Session" })
    end,
  },
}
