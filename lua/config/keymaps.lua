-- Alias for better readability.
local keymap = vim.keymap

-- ===== GENERAL KEYMAPS =====
-- Quick escape from insert mode.
-- Maps 'jk' in insert mode to the Escape key for faster typing.
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode", silent = true })

-- Clear search highlighting.
-- Maps '<leader>nh' to clear the highlighting from the last search.
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights", silent = true })

-- ===== WINDOW NAVIGATION (VS Code Style) =====
-- Navigate between splits using Ctrl+h/j/k/l, similar to VS Code.
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate left", silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate down", silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate up", silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate right", silent = true })

-- ===== WINDOW SPLITTING (VS Code Style) =====
-- Shortcuts to create horizontal and vertical splits.
keymap.set("n", "sh", "<cmd>split<CR>", { desc = "Split horizontally", silent = true })
keymap.set("n", "sv", "<cmd>vsplit<CR>", { desc = "Split vertically", silent = true })

-- ===== LSP (Language Server Protocol) =====
-- Code actions (like VS Code's lightbulb).
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", silent = true })

-- Show hover information (like VS Code's hover).
keymap.set("n", "<S-k>", vim.lsp.buf.hover, { desc = "Show hover", silent = true })

-- Rename symbol (like F2 in VS Code).
keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol", silent = true })

-- ===== BUFFER MANAGEMENT =====
-- Closing buffers is primarily handled by the 'Snacks' plugin.
-- Use '<leader>bd' (Delete Buffer), '<leader>ba' (Delete All Buffers),
-- and '<leader>bo' (Delete Other Buffers) provided by Snacks.

-- ===== FILE OPERATIONS =====
-- Quick file finder using 'Snacks' smart picker.
keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Quick open files", silent = true })

-- ===== SEARCH OPERATIONS =====
-- Project-wide search using 'Snacks' grep.
-- Use '<leader>sg' provided by 'snacks.lua'.

-- Search in current buffer using 'Snacks' lines.
-- Use '<leader>sb' provided by 'snacks.lua'.

-- ===== COMMENTING =====
-- Commenting is handled by 'mini.comment'.
-- Refer to 'mini.comment' configuration for keybindings (likely 'gc' and 'gcc').

-- ===== NUMBER OPERATIONS =====
-- Increment and decrement numbers.
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
keymap.set("n", "<leader>=", "<C-x>", { desc = "Decrement number", silent = true })

-- ===== WINDOW MANAGEMENT =====
-- Make all windows equal size.
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes", silent = true })

-- Close the current window split.
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split", silent = true })

-- Resize splits with arrow keys.
keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize split up", silent = true })
keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize split down", silent = true })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize split left", silent = true })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize split right", silent = true })

-- ===== TAB MANAGEMENT (Consider removal if primarily using bufferline) =====
-- Open new tab.
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab", silent = true })
-- Close current tab.
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab", silent = true })
-- Next tab.
keymap.set("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab", silent = true })
-- Previous tab.
keymap.set("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous tab", silent = true })
-- Open current buffer in new tab.
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab", silent = true })

-- ===== QUICK EDITING SHORTCUTS =====
-- Alternative escape key in insert mode.
keymap.set("i", "<C-c>", "<ESC>", { desc = "Alternative ESC", silent = true })

-- Save with Ctrl+S.
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Quick Save", silent = true })
keymap.set("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "Quick Save", silent = true })

-- ===== TREESITTER =====
-- Swap current parameter with the next.
keymap.set("n", "<leader>a", function() vim.cmd("TSTextobjectSwapNext @parameter.inner") end,
    { desc = "[T]reesitter Swap Next Param", silent = true })
-- Swap current parameter with the previous.
keymap.set("n", "<leader>A", function() vim.cmd("TSTextobjectSwapPrevious @parameter.inner") end,
    { desc = "[T]reesitter Swap Previous Param", silent = true })