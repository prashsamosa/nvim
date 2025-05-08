-- Configure 'barbar.nvim' for enhanced buffer management.
return {
  "romgrk/barbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- File icons
    "lewis6991/gitsigns.nvim",     -- Git integration for bufferline
  },
  init = function()
    -- Keymaps for buffer navigation and control.
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- BUFFER NAVIGATION
    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts) -- Go to previous buffer
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)     -- Go to next buffer

    -- BUFFER REORDERING
    map("n", "<A-S-,>", "<Cmd>BufferMovePrevious<CR>", opts) -- Move buffer left
    map("n", "<A-S-.>", "<Cmd>BufferMoveNext<CR>", opts)     -- Move buffer right

    -- JUMP TO BUFFER BY INDEX (Alt + 1–9, Alt + 0 = last)
    for i = 1, 9 do
      map("n", "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", opts)
    end
    map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

    -- BUFFER PINNING / CLOSING
    map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)                             -- Pin/unpin current buffer
    -- Avoid <A-c> (often conflicts with copy), use <leader> mappings instead:
    map("n", "<leader>bc", "<Cmd>BufferClose<CR>", opts)                      -- Close current buffer
    map("n", "<leader>bo", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", opts) -- Close others (safe)

    -- Optional: legacy close key, with a warning
    -- map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts) -- Use with caution: conflicts with Alt+C in some terminals
  end,

  opts = {
    auto_hide = true,     -- Hide the tabline if only one buffer
    clickable = true,     -- Enable mouse click support
    insert_at_end = true, -- New buffers go to end of bufferline
    icons = {
      buffer_index = true,
      button = "", -- Close button icon
      filetype = {
        enabled = true,
        custom_colors = false,
      },
      separator = { left = "▎", right = "" },
      gitsigns = {
        added = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },
      inactive = {
        filetype = { enabled = false },
      },
    },
  },
}
