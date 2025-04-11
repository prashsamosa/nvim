-- filepath: /home/samosa/.config/nvim/lua/config/keymaps.lua
-- Set leader key
vim.g.mapleader = " "

local keymap = vim.keymap -- alias for convenience

-- === General Keymaps ===
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk", silent = true })
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights", silent = true })

-- === VS Code Navigation ===
-- Window navigation with Ctrl+hjkl
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate left", silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate down", silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate up", silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate right", silent = true })

-- Buffer navigation with space+[] (like VS Code tabs)
keymap.set("n", "<leader>[", "<cmd>bprevious<CR>", { desc = "Previous buffer", silent = true })
keymap.set("n", "<leader>]", "<cmd>bnext<CR>", { desc = "Next buffer", silent = true })

-- === VS Code Split Management ===
keymap.set("n", "sh", "<cmd>split<CR>", { desc = "Split horizontally", silent = true })
keymap.set("n", "sv", "<cmd>vsplit<CR>", { desc = "Split vertically", silent = true })

-- === VS Code Coding Operations ===
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", silent = true })
keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })
keymap.set("n", "<S-k>", vim.lsp.buf.hover, { desc = "Show hover", silent = true })
keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol", silent = true })
keymap.set("n", "<leader>cs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols", silent = true })

-- === VS Code Buffer Management ===
keymap.set("n", "<leader>bd", "<cmd>Bdelete<CR>", { desc = "Close buffer", silent = true })
keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>", { desc = "Close other buffers", silent = true })

-- === VS Code File Operations ===
keymap.set("n", "<leader><space>", "<cmd>Telescope find_files<CR>", { desc = "Quick open files", silent = true })

-- === VS Code Search Operations ===
keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "Search in files", silent = true })
keymap.set("n", "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<CR>",
    { desc = "Search in buffer", silent = true })

-- === VS Code Comment Operation ===
keymap.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end,
    { desc = "Toggle comment", silent = true })
keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Toggle comment", silent = true })

-- === Number Operations ===
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
keymap.set("n", "<leader>=", "<C-x>", { desc = "Decrement number", silent = true })

-- === Window Management ===
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes", silent = true })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split", silent = true })

-- Resize splits easily
keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize split up", silent = true })
keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize split down", silent = true })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize split left", silent = true })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize split right", silent = true })

-- === Tab Management ===
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab", silent = true })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab", silent = true })
keymap.set("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab", silent = true })
keymap.set("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous tab", silent = true })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab", silent = true })

-- === Quick Normal Mode Shortcuts ===
keymap.set("i", "<C-c>", "<ESC>", { desc = "Alternative ESC", silent = true })
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Quick Save", silent = true })
keymap.set("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "Quick Save", silent = true })
