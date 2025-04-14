-- Configure 'barbar.nvim' for enhanced buffer management.
return {
  "romgrk/barbar.nvim",
  -- version = false, -- You can keep or remove this line, usually not needed unless pinning
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- File icons.
    "lewis6991/gitsigns.nvim",     -- Git integration in the bufferline.
  },
  init = function() -- Use init for keymaps so they are set even if barbar loads lazily
    -- Keymaps for buffer navigation and control.
    local map = vim.keymap.set -- Use vim.keymap.set for Neovim >= 0.7
    local opts = { noremap = true, silent = true }

    -- Buffer Navigation
    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts) -- Previous buffer
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)     -- Next buffer

    -- Buffer Movement (Alt + < > might conflict, consider Alt + Shift + < > or other keys)
    -- Using <A-<> > requires checking terminal compatibility or using different keys
    -- map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts) -- Move buffer left
    -- map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)     -- Move buffer right
    map("n", "<A-S-,>", "<Cmd>BufferMovePrevious<CR>", opts) -- Move buffer left (Alt+Shift+,)
    map("n", "<A-S-.>", "<Cmd>BufferMoveNext<CR>", opts)     -- Move buffer right (Alt+Shift+.)


    -- Jump to Buffer by Index
    for i = 1, 9 do
      map("n", "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", opts) -- Goto buffer 1-9
    end
    map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)     -- Last buffer

    -- Buffer Pinning/Closing
    map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)                      -- Pin/unpin buffer
    map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)                    -- Close current buffer
    map("n", "<A-S-c>", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", opts) -- Close other buffers (Safer alternative)
    -- map("n", "<A-b>", "<Cmd>BufferCloseAllButCurrent<CR>", opts) -- Original Close other buffers

  end,
  opts = {
    -- Add this line:
    auto_hide = true,          -- Automatically hide barbar when only one buffer is open

    clickable = true,         -- Enable mouse clicks to switch buffers.
    -- tabpages = false,      -- This option is often not needed; barbar focuses on buffers
    insert_at_end = true,     -- Add new buffers to the end of the list.
    icons = {
      button = "",           -- Close button icon (ensure Nerd Font)
      buffer_index = true,    -- Show buffer numbers.
      filetype = {
        enabled = true,       -- Show filetype icons.
        custom_colors = false, -- Use theme default colors for icons
      },
      separator = { left = '▎', right = '' }, -- Separator style
      -- visible = { modified = { buffer_number = false } }, -- This is often default or can be tweaked
      gitsigns = {              -- Requires gitsigns.nvim plugin
        added = { enabled = true, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = true, icon = '-' },
      },
      inactive = { filetype = { enabled = false } } -- Dim inactive icons slightly
    },
    -- Add highlighting options if needed, e.g.:
    -- highlight = { },
  },
}