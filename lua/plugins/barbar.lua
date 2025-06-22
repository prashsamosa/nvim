-- Bufferline configuration using barbar.nvim
return {
  "romgrk/barbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- File icons
    "lewis6991/gitsigns.nvim",     -- Git signs integration
  },

  init = function()
    vim.g.barbar_auto_setup = false -- Disable barbar's default keymaps

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Buffer navigation
    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)

    -- Reorder buffers
    map("n", "<A-S-,>", "<Cmd>BufferMovePrevious<CR>", opts)
    map("n", "<A-S-.>", "<Cmd>BufferMoveNext<CR>", opts)

    -- Jump to buffer 1–9, 0 = last
    for i = 1, 9 do
      map("n", "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", opts)
    end
    map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

    -- Buffer pin & close
    map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
    map("n", "<leader>bc", "<Cmd>BufferClose<CR>", opts)
    map("n", "<leader>bo", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", opts)
  end,

  opts = {
    auto_hide = true,
    clickable = true,
    insert_at_end = true,
    icons = {
      buffer_index = true,
      button = "",

      filetype = {
        enabled = true,
        custom_colors = false,
      },

      separator = {
        left = "▎",
        right = "",
      },

      gitsigns = {
        added   = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },

      inactive = {
        filetype = { enabled = false },
      },
    },
  },
}
