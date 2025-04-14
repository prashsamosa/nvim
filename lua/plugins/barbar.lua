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

    -- Buffer Navigation
    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts) -- Previous buffer
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)     -- Next buffer

    -- Buffer Movement
    map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts) -- Move buffer left
    map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)     -- Move buffer right

    -- Jump to Buffer by Index
    for i = 1, 9 do
      map("n", "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", opts) -- Goto buffer 1-9
    end
    map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)     -- Last buffer

    -- Buffer Pinning/Closing
    map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)                      -- Pin/unpin buffer
    map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)                    -- Close current buffer
    map("n", "<A-b>", "<Cmd>BufferCloseAllButCurrent<CR>", opts) -- Close other buffers
  end,
}