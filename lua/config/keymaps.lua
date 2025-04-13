-- Set the leader key to space.
-- The leader key is often used as a prefix for custom keybindings.
-- Using space is a common and ergonomic choice.
vim.g.mapleader = " "
vim.g.maplocalleader = " " -- Also set local leader to space for buffer-local mappings

-- Alias for better readability.
-- This creates a shorter and more convenient way to access vim.keymap.set.
local keymap = vim.keymap

-- ===== GENERAL KEYMAPS =====
-- Quick escape from insert mode.
-- Maps 'jk' in insert mode to the Escape key. This is a popular alternative
-- to pressing the dedicated Esc key and can improve typing flow.
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk", silent = true })

-- Clear search highlighting.
-- Maps '<leader>nh' in normal mode to the command that clears the highlighting
-- from the last search. 'nohlsearch' is the Neovim command for this.
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights", silent = true })

-- ===== VS CODE-STYLE WINDOW NAVIGATION =====
-- Navigate between splits with Ctrl+hjkl (like VS Code).
-- These mappings allow you to move between Neovim window splits using the
-- familiar Ctrl+h/j/k/l keys, similar to how you might navigate panes in VS Code's
-- integrated terminal or editor groups. '<C-w>h' etc. are the native Neovim
-- commands for window navigation.
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate left", silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate down", silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate up", silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate right", silent = true })

-- Buffer navigation with brackets (similar to VS Code tabs).
-- These mappings allow you to cycle through open buffers using '<leader>[' for
-- the previous buffer and '<leader>]' for the next buffer. This provides a
-- quick way to switch between files you're currently working on.
keymap.set("n", "<leader>[", "<cmd>bprevious<CR>", { desc = "Previous buffer", silent = true })
keymap.set("n", "<leader>]", "<cmd>bnext<CR>", { desc = "Next buffer", silent = true })

-- ===== WINDOW SPLITTING (VS CODE STYLE) =====
-- These mappings provide shortcuts to create horizontal and vertical window splits,
-- mirroring the intuitive 'Split Horizontally' and 'Split Vertically' options found
-- in VS Code. '<cmd>split<CR>' and '<cmd>vsplit<CR>' are the Neovim commands
-- for creating splits.
keymap.set("n", "sh", "<cmd>split<CR>", { desc = "Split horizontally", silent = true })
keymap.set("n", "sv", "<cmd>vsplit<CR>", { desc = "Split vertically", silent = true })

-- ===== VS CODE-STYLE EDITING OPERATIONS =====
-- Code actions (like VS Code's lightbulb menu).
-- This mapping triggers the Language Server Protocol (LSP) code actions available
-- at the current cursor position. These actions can include things like quick fixes,
-- refactorings, and source actions, similar to VS Code's lightbulb suggestions.
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", silent = true })

-- Move lines up and down in visual mode (Shift+J/K in VS Code).
-- These mappings allow you to quickly move selected lines up or down in visual mode
-- without having to cut and paste.
-- ':m '>+1<CR>' moves the visually selected lines after the next line.
-- ':m '<-2<CR>' moves the visually selected lines before the second line above.
-- 'gv=gv' reselects the moved lines and keeps the indentation.
keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })

-- Show hover information (like VS Code's hover).
-- This mapping triggers the LSP hover information for the symbol under the cursor.
-- This typically displays documentation or type information.
keymap.set("n", "<S-k>", vim.lsp.buf.hover, { desc = "Show hover", silent = true })

-- Rename symbol (like F2 in VS Code).
-- This mapping triggers the LSP rename functionality, allowing you to rename
-- variables, functions, etc., across your project with confidence.
keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol", silent = true })

-- Show document symbols (like VS Code's outline) - FIXED: Use FZF-lua.
-- This mapping uses the 'fzf-lua' plugin to display a searchable list of symbols
-- (functions, classes, variables, etc.) in the current document, similar to VS Code's
-- outline view.
keymap.set("n", "<leader>cs", require("fzf-lua").lsp_document_symbols, { desc = "Document symbols", silent = true })

-- ===== BUFFER MANAGEMENT =====
-- Close current buffer (like closing a tab in VS Code).
-- This functionality is now handled by the 'Snacks' plugin, so the direct
-- keymap using 'mini.bufremove' has been removed. Refer to the 'Snacks'
-- plugin configuration for the '<leader>bd' mapping.

-- Close all buffers except current one.
-- This functionality is also likely handled by the 'Snacks' plugin. The
-- previous direct mapping using core Neovim commands has been removed.
-- Check the 'Snacks' plugin configuration for the '<leader>bo' mapping.

-- ===== FILE OPERATIONS =====
-- Quick file finder (like Ctrl+P in VS Code).
-- This mapping uses the 'Snacks' plugin's smart picker function to quickly find
-- and open files in your project.
keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Quick open files", silent = true })

-- ===== SEARCH OPERATIONS =====
-- Search in files (like Ctrl+Shift+F in VS Code).
-- This mapping uses the 'Snacks' plugin's grep function to perform a project-wide
-- search for a given pattern.
-- REMOVED: Redundant <leader>sg mapping (handled by snacks.lua)
-- keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Search in files", silent = true })

-- Search in current buffer.
-- This mapping uses the 'Snacks' plugin's lines function to search within the
-- current open buffer.
-- REMOVED: Redundant <leader>ss mapping (handled by snacks.lua <leader>sb)
-- keymap.set("n", "<leader>ss", function() Snacks.picker.lines() end, { desc = "Search in buffer", silent = true })

-- ===== COMMENTING =====
-- Toggle comment (like Ctrl+/ in VS Code).
-- These mappings use the 'Comment.nvim' plugin to toggle comments on the current
-- line (in normal mode) or on the visually selected lines.
keymap.set("n", "<leader>c/", function() require("Comment.api").toggle.linewise.current() end,
    { desc = "Toggle comment", silent = true })
keymap.set("v", "<leader>c/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Toggle comment", silent = true })

-- ===== NUMBER OPERATIONS =====
-- Increment and decrement numbers.
-- These mappings use the built-in Neovim commands '<C-a>' (increment) and
-- '<C-x>' (decrement) to change the number under the cursor.
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
keymap.set("n", "<leader>=", "<C-x>", { desc = "Decrement number", silent = true })

-- ===== WINDOW MANAGEMENT =====
-- Make all windows equal size.
-- This mapping uses the '<C-w>=' command to equalize the height and width of all
-- open windows.
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes", silent = true })

-- Close the current window split.
-- This mapping uses the ':close' command to close the currently active window.
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split", silent = true })

-- Resize splits with arrow keys.
-- These mappings allow you to resize the current window split using Ctrl+Up/Down/Left/Right.
-- ':resize -2<CR>' decreases the height by 2.
-- ':resize +2<CR>' increases the height by 2.
-- ':vertical resize -2<CR>' decreases the width by 2.
-- ':vertical resize +2<CR>' increases the width by 2.
keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize split up", silent = true })
keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize split down", silent = true })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize split left", silent = true })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize split right", silent = true })

-- ===== TAB MANAGEMENT =====
-- These mappings provide shortcuts for common tab-related operations.
-- ':tabnew' creates a new tab.
-- ':tabclose' closes the current tab.
-- ':tabnext' goes to the next tab.
-- ':tabprevious' goes to the previous tab.
-- ':tabnew %' opens the current buffer in a new tab.
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab", silent = true })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab", silent = true })
keymap.set("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab", silent = true })
keymap.set("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous tab", silent = true })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab", silent = true })

-- ===== QUICK EDITING SHORTCUTS =====
-- Alternative escape key in insert mode.
-- This provides another way to exit insert mode, which can be useful for some keyboard layouts or personal preference.
keymap.set("i", "<C-c>", "<ESC>", { desc = "Alternative ESC", silent = true })

-- Save with Ctrl+S (like in VS Code).
-- These mappings allow you to save the current buffer using the familiar Ctrl+S shortcut in both normal and insert modes.
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Quick Save", silent = true })
keymap.set("i", "<C-s>", "<ESC><cmd>w<CR>", { desc = "Quick Save", silent = true })

-- ===== AI (Avante - REMOVED) =====
-- The keymaps associated with the 'Avante' AI plugin have been removed.
-- This suggests that the plugin is no longer in use or its keybindings
-- are configured elsewhere.

-- Treesitter swap keymaps (reverted <leader>a).
-- These mappings use the 'nvim-treesitter' plugin to swap the current
-- parameter with the next or previous parameter. This can be useful for
-- quickly reordering function arguments.
-- '@parameter.inner' is a treesitter query that targets the inner content
-- of a function parameter.
-- 'TSTextobjectSwapNext' and 'TSTextobjectSwapPrevious' are commands provided
-- by a treesitter extension (likely 'nvim-treesitter-textobjects').
keymap.set("n", "<leader>a", function() vim.cmd("TSTextobjectSwapNext @parameter.inner") end,
    { desc = "[T]reesitter Swap Next Param", silent = true })
keymap.set("n", "<leader>A", function() vim.cmd("TSTextobjectSwapPrevious @parameter.inner") end,
    { desc = "[T]reesitter Swap Previous Param", silent = true })

