-- Configure 'barbar.nvim' for buffer management.
return {
    "romgrk/barbar.nvim",
    version = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- Support for file icons.
      "lewis6991/gitsigns.nvim",     -- Display Git status in the tabline.
    },
    config = function()
      local barbar = require("barbar")
  
      barbar.setup({
        clickable = true, -- Enable clickable tabs for buffer switching.
        tabpages = false, -- Disable tabpage indicator (we are focusing on buffers).
        insert_at_end = true, -- New buffers appear at the end of the tabline.
        icons = {
          button = "",       -- Icon to display for the close button.
          buffer_index = true, -- Show buffer index/number.
          filetype = { enabled = true }, -- Show file type icons.
          visible = { modified = { buffer_number = false } }, -- Don't show buffer number if only modified.
          gitsigns = {
            added = { enabled = true, icon = "+" },   -- Icon for added changes.
            changed = { enabled = true, icon = "~" }, -- Icon for changed changes.
            deleted = { enabled = true, icon = "-" }, -- Icon for deleted changes.
          },
        },
      })
  
      -- Define keymaps for buffer management.
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
  
      -- Move to previous/next buffer (using Alt + , and Alt + .)
      map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
      map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
  
      -- Re-order to previous/next buffer (using Alt + < and Alt + >)
      map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
      map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
  
      -- Go to buffer in position... (using Alt + 1-9 and Alt + 0 for last)
      for i = 1, 9 do
        -- Check for potential conflict with existing <leader>[1-9] for buffer jumping.
        -- Using <A-1> to <A-9> to avoid this common conflict.
        map("n", "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", opts)
      end
      map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
  
      -- Pin/unpin buffer (using Alt + p)
      map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
  
      -- Close buffer (using Alt + c)
      map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
  
      -- Close all buffers but current (using Alt + b)
      map("n", "<A-b>", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
    end,
  }