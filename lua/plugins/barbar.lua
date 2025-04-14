-- Configure 'barbar.nvim' for enhanced buffer management.
return {
    "romgrk/barbar.nvim",
    version = false, -- Use the latest commit.
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- File icons.
      "lewis6991/gitsigns.nvim",     -- Git integration in the bufferline.
    },
    config = function()
      local barbar = require("barbar")
  
      barbar.setup({
        clickable = true,         -- Enable mouse clicks to switch buffers.
        tabpages = false,         -- Hide tabpages; focus on buffer navigation only.
        insert_at_end = true,     -- Add new buffers to the end of the list.
        icons = {
          button = "",           -- Close button icon.
          buffer_index = true,    -- Show buffer numbers.
          filetype = {
            enabled = true,       -- Show filetype icons.
          },
          visible = {
            modified = {
              buffer_number = false, -- Don't show buffer number if only modified.
            },
          },
          gitsigns = {
            added = { enabled = true, icon = "+" },
            changed = { enabled = true, icon = "~" },
            deleted = { enabled = true, icon = "-" },
          },
        },
      })
  
      -- Keymaps for buffer navigation and control.
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
  
      -- Navigate between buffers
      map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
      map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
  
      -- Move current buffer left/right
      map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
      map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
  
      -- Jump to buffers by index (Alt + 1 through 9)
      for i = 1, 9 do
        map("n", "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", opts)
      end
  
      -- Jump to the last buffer
      map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
  
      -- Pin/unpin current buffer
      map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
  
      -- Close buffers
      map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
      map("n", "<A-b>", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
    end,
  }
  