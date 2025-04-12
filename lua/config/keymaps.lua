-- This file contains all core keymappings for Neovim
-- Additional plugin-specific keymaps are set in their respective plugin files

-- Set the leader key to space
vim.g.mapleader = " "

-- Alias for better readability
local keymap = vim.keymap

-- ===== GENERAL KEYMAPS =====
-- Quick escape from insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk", silent = true })
-- Clear search highlighting
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights", silent = true })

-- ===== VS CODE-STYLE WINDOW NAVIGATION =====
-- Navigate between splits with Ctrl+hjkl (like VS Code)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate left", silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate down", silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate up", silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate right", silent = true })

-- Buffer navigation with brackets (similar to VS Code tabs)
keymap.set("n", "<leader>[", "<cmd>bprevious<CR>", { desc = "Previous buffer", silent = true })
keymap.set("n", "<leader>]", "<cmd>bnext<CR>", { desc = "Next buffer", silent = true })

-- ===== WINDOW SPLITTING (VS CODE STYLE) =====
keymap.set("n", "sh", "<cmd>split<CR>", { desc = "Split horizontally", silent = true })
keymap.set("n", "sv", "<cmd>vsplit<CR>", { desc = "Split vertically", silent = true })

-- ===== VS CODE-STYLE EDITING OPERATIONS =====
-- Code actions (like VS Code's lightbulb menu)
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", silent = true })
-- Move lines up and down in visual mode (Shift+J/K in VS Code)
keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })
-- Show hover information (like VS Code's hover)
keymap.set("n", "<S-k>", vim.lsp.buf.hover, { desc = "Show hover", silent = true })
-- Rename symbol (like F2 in VS Code)
keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol", silent = true })
-- Show document symbols (like VS Code's outline)
keymap.set("n", "<leader>cs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols", silent = true })

-- ===== BUFFER MANAGEMENT =====
-- Close current buffer (like closing a tab in VS Code)
keymap.set("n", "<leader>bd", function() require("mini.bufremove").delete(0, false) end,
    { desc = "Close buffer", silent = true })
-- Close all buffers except current one
keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>", { desc = "Close other buffers", silent = true })

-- ===== FILE OPERATIONS =====
-- Quick file finder (like Ctrl+P in VS Code)
keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Quick open files", silent = true })

-- ===== SEARCH OPERATIONS =====
-- Search in files (like Ctrl+Shift+F in VS Code)
keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Search in files", silent = true })
-- Search in current buffer
keymap.set("n", "<leader>ss", function() Snacks.picker.lines() end, { desc = "Search in buffer", silent = true })

-- ===== COMMENTING =====
-- Toggle comment (like Ctrl+/ in VS Code)
keymap.set("n", "<leader>c/", function() require("Comment.api").toggle.linewise.current() end,
    { desc = "Toggle comment", silent = true })
keymap.set("v", "<leader>c/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Toggle comment", silent = true })

-- ===== NUMBER OPERATIONS =====
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
keymap.set("n", "<leader>=", "<C-x>", { desc = "Decrement number", silent = true })

-- ===== WINDOW MANAGEMENT =====
-- Make all windows equal size
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes", silent = true })
-- Close the current window split
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split", silent = true })

-- Resize splits with arrow keys
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
-- Save with Ctrl+S (like in VS Code)
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Quick Save", silent = true })
keymap.set("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "Quick Save", silent = true })

-- ===== WORKSPACE OPERATIONS =====
-- Save current session
keymap.set("n", "<leader>ws", "<cmd>SessionManager save_current_session<CR>",
    { desc = "Save workspace", silent = true })
-- Load a session
keymap.set("n", "<leader>wl", "<cmd>SessionManager load_session<CR>",
    { desc = "Load workspace", silent = true })

-- Added Avante keybindings
keymap.set("n", "<leader>a", "<cmd>AvanteToggle<CR>", { desc = "Toggle Avante chat", silent = true })
keymap.set("n", "<leader>ac", "<cmd>AvanteComplete<CR>", { desc = "Avante completion", silent = true })
keymap.set("n", "<leader>ae", "<cmd>AvanteExplain<CR>", { desc = "Avante explain code", silent = true })
keymap.set("v", "<leader>ae", "<cmd>AvanteExplain<CR>", { desc = "Avante explain selection", silent = true })
keymap.set("n", "<leader>at", "<cmd>AvanteTests<CR>", { desc = "Avante generate tests", silent = true })
