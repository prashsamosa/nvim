return {
  -- Core mini.nvim library
  {
    "echasnovski/mini.nvim",
    version = false,
  },

  -- Buffer removal
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

  -- File explorer
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

  -- Fuzzy picker
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

  -- Notifications
  {
    "echasnovski/mini.notify",
    version = false,
    event = "VeryLazy",
    config = function()
      -- First check what version of mini.notify we're using
      local has_winblend = pcall(function()
        -- Try creating a floating window with winblend to see if it's supported
        local win_id = vim.api.nvim_open_win(0, false, {
          relative = "editor",
          width = 1,
          height = 1,
          row = 0,
          col = 0,
          style = "minimal",
          winblend = 0
        })
        vim.api.nvim_win_close(win_id, true)
        return true
      end)

      local config = {
        window = {
          config = {
            border = "rounded",
            max_width = 60,
          }
        },
        content = {
          default_timeout_ms = 5000,
        },
        lsp_progress = {
          enable = true,
          duration_ms = 500,
        },
      }

      -- Only add winblend if it's supported
      if has_winblend then
        config.window.config.winblend = 0
      end

      require("mini.notify").setup(config)
      vim.notify = require("mini.notify").make_notify()
    end,
  },

  -- Statusline
  {
    "echasnovski/mini.statusline",
    version = false,
    config = function()
      require("mini.statusline").setup({ use_icons = true })
    end,
  },
}
