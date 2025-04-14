-- Configure 'barbar.nvim' for enhanced buffer management.
return {
  "romgrk/barbar.nvim",
  version = false, -- Follow the latest version
  dependencies = {
      "nvim-tree/nvim-web-devicons", -- Display file icons in the bufferline.
      "lewis6991/gitsigns.nvim",     -- Show Git status indicators in the bufferline.
  },
  config = function()
      local barbar = require("barbar")

      barbar.setup({
          clickable = true,          -- Enable buffer switching by clicking on tabs.
          tabpages = false,          -- Disable the tabpage indicator (focusing on buffers).
          insert_at_end = true,      -- New buffers are added to the end of the bufferline.
          icons = {
              button = "",          -- Icon for the buffer close button.
              buffer_index = true,    -- Display the index/number of each buffer.
              filetype = { enabled = true }, -- Show icons based on the file type.
              visible = {
                  modified = { buffer_number = false } -- Don't show buffer number if only modified.
              },
              gitsigns = {
                  added = { enabled = true, icon = "+" },    -- Icon for added lines (Git).
                  changed = { enabled = true, icon = "~" },  -- Icon for changed lines (Git).
                  deleted = { enabled = true, icon = "-" },  -- Icon for deleted lines (Git).
              },
          },
      })

      -- Define keymaps for 'barbar.nvim' buffer management.
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Navigate to the previous buffer (Alt + ,).
      map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)

      -- Navigate to the next buffer (Alt + .).
      map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)

      -- Move the current buffer one position to the left (Alt + <).
      map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)

      -- Move the current buffer one position to the right (Alt + >).
      map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

      -- Go to a specific buffer by its number (Alt + 1-9).
      for i = 1, 9 do
          -- Using Alt + number to avoid potential conflicts with <leader>[1-9].
          map("n", "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", opts)
      end

      -- Go to the last buffer (Alt + 0).
      map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

      -- Pin or unpin the current buffer (Alt + p). Pinned buffers stay in place.
      map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)

      -- Close the current buffer (Alt + c).
      map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)

      -- Close all buffers except the currently active one (Alt + b).
      map("n", "<A-b>", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
  end,
}