local keymap = vim.keymap

-- General
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode", silent = true })
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights", silent = true })

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window", silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window", silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window", silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window", silent = true })

-- Window splitting
keymap.set("n", "sh", "<cmd>split<CR>", { desc = "Horizontal split", silent = true })
keymap.set("n", "sv", "<cmd>vsplit<CR>", { desc = "Vertical split", silent = true })

-- Files
keymap.set("n", "<leader><space>", function()
  if not _G.Snacks then
    require("fzf-lua").files()
  end
end, { desc = "Fuzzy find files", silent = true })

-- Numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })

-- Note: LSP keymaps are now handled in the LSP configuration file
-- Neovim 0.11 provides these default LSP keymaps automatically:
-- grn - vim.lsp.buf.rename()
-- grr - vim.lsp.buf.references()
-- gri - vim.lsp.buf.implementation()
-- gO  - vim.lsp.buf.document_symbol()
-- gra - vim.lsp.buf.code_action() (Normal and Visual mode)
-- CTRL-S - vim.lsp.buf.signature_help() (Insert and Select mode)
-- [d, ]d - navigate diagnostics ([D, ]D for first/last)

-- Additional convenience mappings for diagnostics
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics", silent = true })

-- Terminal mode escape
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })

-- Better indenting in visual mode
keymap.set("v", "<", "<gv", { desc = "Indent left", silent = true })
keymap.set("v", ">", ">gv", { desc = "Indent right", silent = true })

-- Move lines up/down
keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Quick save
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file", silent = true })
keymap.set("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "Save file", silent = true })

-- Better paste in visual mode (doesn't replace clipboard)
keymap.set("v", "p", '"_dP', { desc = "Paste without replacing clipboard", silent = true })

-- Toggle between buffers
keymap.set("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to other buffer", silent = true })

-- Clear search, diff update and redraw
keymap.set("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff update", silent = true })
