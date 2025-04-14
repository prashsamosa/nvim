-- Alias for better readability.
local keymap = vim.keymap

-- ===== GENERAL KEYMAPS =====
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode", silent = true })                              -- Quick escape from insert mode.
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights", silent = true }) -- Clear search highlights.

-- ===== WINDOW NAVIGATION =====
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate left", silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate down", silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate up", silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate right", silent = true })

-- ===== WINDOW SPLITTING =====
keymap.set("n", "sh", "<cmd>split<CR>", { desc = "Split horizontally", silent = true })
keymap.set("n", "sv", "<cmd>vsplit<CR>", { desc = "Split vertically", silent = true })

-- ===== LSP =====
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", silent = true })
keymap.set("n", "<S-k>", vim.lsp.buf.hover, { desc = "Show hover", silent = true })
keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol", silent = true })

-- ===== FILE OPERATIONS =====
keymap.set("n", "<leader><space>", function()
  -- Only use if Snacks is not loaded
  if not _G.Snacks then
    require('fzf-lua').files()
  end
end, { desc = "Quick open files (fallback)", silent = true })

-- ===== NUMBER OPERATIONS =====
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
