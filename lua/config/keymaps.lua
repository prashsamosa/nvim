-- Alias for better readability.
local keymap = vim.keymap

-- ===== GENERAL KEYMAPS =====
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode", silent = true }) -- Quick escape from insert mode.
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
keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Quick open files", silent = true })

-- ===== NUMBER OPERATIONS =====
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
keymap.set("n", "<leader>=", "<C-x>", { desc = "Decrement number", silent = true })

-- ===== WINDOW MANAGEMENT =====
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes", silent = true })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split", silent = true })
keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize split up", silent = true })
keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize split down", silent = true })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize split left", silent = true })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize split right", silent = true })

-- ===== TAB MANAGEMENT =====
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab", silent = true })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab", silent = true })
keymap.set("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab", silent = true })
keymap.set("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous tab", silent = true })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab", silent = true })

-- ===== QUICK EDITING SHORTCUTS =====
keymap.set("i", "<C-c>", "<ESC>", { desc = "Alternative ESC", silent = true })
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Quick Save", silent = true })
keymap.set("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "Quick Save", silent = true })

-- ===== TREESITTER =====
keymap.set("n", "<leader>a", function() vim.cmd("TSTextobjectSwapNext @parameter.inner") end, { desc = "Swap Next Param", silent = true })
keymap.set("n", "<leader>A", function() vim.cmd("TSTextobjectSwapPrevious @parameter.inner") end, { desc = "Swap Previous Param", silent = true })