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

-- Files - Use Snacks picker if available, fallback to fzf-lua
keymap.set("n", "<leader><space>", function()
  if _G.Snacks and _G.Snacks.picker then
    _G.Snacks.picker.files()
  else
    require("fzf-lua").files()
  end
end, { desc = "Find files", silent = true })

-- Numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
-- FIX: Added a consistent keymap for decrementing numbers
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number", silent = true })

keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostic float", silent = true })
keymap.set("n", "<leader>bl", "<cmd>e #<CR>", { desc = "Switch to last buffer", silent = true })
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file", silent = true })
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })

-- Visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Better paste in visual mode (doesn't replace clipboard)
keymap.set("v", "p", '"_dP', { desc = "Paste without replacing clipboard", silent = true })

-- Clear search, diff update and redraw
keymap.set("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff update", silent = true })

-- Additional diagnostic keymaps (supplement 0.11 defaults: [d, ]d, [D, ]D)
keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic loclist", silent = true })
keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic quickfix", silent = true })

-- NOTE: Neovim 0.11 provides these LSP keymaps automatically (and are also configured in lsp.lua):
-- grn - vim.lsp.buf.rename()
-- grr - vim.lsp.buf.references()
-- gri - vim.lsp.buf.implementation()
-- gO  - vim.lsp.buf.document_symbol()
-- gra - vim.lsp.buf.code_action() (Normal and Visual mode)
-- CTRL-S - vim.lsp.buf.signature_help() (Insert and Select mode)
-- [d, ]d - move between diagnostics
-- [D, ]D - jump to first/last diagnostic

-- Default keymaps for quickfix/location/tag/argument/buffer lists, and adding new lines
-- [q, ]q, [Q, ]Q, [CTRL-Q, ]CTRL-Q - navigate quickfix list
-- [l, ]l, [L, ]L, [CTRL-L, ]CTRL-L - navigate location list
-- [t, ]t, [T, ]T, [CTRL-T, ]CTRL-T - navigate tag matchlist
-- [a, ]a, [A, ]A - navigate argument list
-- [b, ]b, [B, ]B - navigate buffer list
-- [<Space>, ]<Space> - add empty line above/below cursor
