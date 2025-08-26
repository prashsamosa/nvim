local map = vim.keymap.set

-- Exit insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Clear search highlights
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Number operations
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Clipboard operations
map("v", "p", '"_dP', { desc = "Paste without replacing clipboard" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- Save file
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR><ESC>", { desc = "Save file" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Better scrolling with centering
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window splitting
map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>\\", "<cmd>split<CR>", { desc = "Horizontal split" })

-- Buffer operations
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Visual mode text manipulation
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Terminal mode
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Diagnostics
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostic in float" })
map("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic quickfix" })

-- Quickfix navigation (Neovim 0.11 has these built-in but we keep them for consistency)
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })

-- Smart file finder with fallback support
map("n", "<leader><space>", function()
    if package.loaded["snacks"] and require("snacks").picker then
        require("snacks").picker.files()
    elseif package.loaded["fzf-lua"] then
        require("fzf-lua").files()
    else
        vim.cmd("find .")
    end
end, { desc = "Find Files" })

-- LSP keymaps are now set up in the LSP configuration via LspAttach autocmd
-- This prevents duplicate mappings and ensures proper LSP client availability

-- Utility keymaps
map("n", "<leader>x", "<cmd>source %<CR>", { desc = "Source current file" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- REMOVED: Duplicate LSP mappings (now handled in lsp.lua)
-- The LspAttach autocmd in lsp.lua handles all LSP-specific keymaps
