local keymap = vim.keymap

-- General
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode", silent = true })
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights", silent = true })

-- Increment/Decrement
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number", silent = true })

-- Clipboard
keymap.set("v", "p", '"_dP', { desc = "Paste without replacing clipboard (clipboard content)", silent = true })

-- Clear search, diff update and redraw
keymap.set("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff update", silent = true })

-- Additional diagnostic keymaps (supplement 0.11 defaults: [d, ]d, [D, ]D)
keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic loclist", silent = true })
keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic quickfix", silent = true })

-- File saving
keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file", silent = true })

-- NOTE: Buffer-local LSP keymaps are configured in lua/plugins/lsp.lua via LspAttach autocommand.
-- Global LSP keymaps are generally not needed as buffer-local ones take precedence.

-- Default keymaps for quickfix/location list (not strictly necessary but can be useful)
keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item", silent = true })
keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item", silent = true })
keymap.set("n", "]l", "<cmd>lnext<CR>", { desc = "Next location list item", silent = true })
keymap.set("n", "[l", "<cmd>lprev<CR>", { desc = "Previous location list item", silent = true })

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
end, { desc = "Find Files (Snacks/FZF)", silent = true })

-- Terminal mode
keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })

-- Visual mode keymaps for moving lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Alt+j/k for visual mode (maintains selection)
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down (maintains selection)", silent = true })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up (maintains selection)", silent = true })

-- Buffer-related keymaps (from your readme.md, assuming snacks.buffer is the intended target)
keymap.set("n", "<leader>bl", function()
  if _G.Snacks and _G.Snacks.buffer then
    _G.Snacks.buffer.last() -- Assuming Snacks provides a 'last' buffer function
  else
    vim.cmd.bprevious()     -- Fallback if Snacks isn't loaded or doesn't have it
  end
end, { desc = "Switch to last buffer (Snacks/Built-in)", silent = true })

-- Missing keymap for closing all but current/pinned in Barbar (from readme)
-- This is already defined in barbar.lua, so no change needed here.
-- keymap.set("n", "<leader>bO", "<cmd>BufferCloseAllButCurrentOrPinned<cr>", { desc = "Close all but current/pinned buffer" })
