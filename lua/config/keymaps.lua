-- Set leader key
vim.g.mapleader = " "

local keymap = vim.keymap -- alias for convenience

-- === General Keymaps ===
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk", silent = true })
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights", silent = true })

-- === Number Operations ===
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number", silent = true })

-- === Window Management ===
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically", silent = true })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally", silent = true })
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

-- === Plugin-Specific Keymaps ===
keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory in Oil", silent = true })

keymap.set("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "Show diagnostics in float", silent = true })

keymap.set("n", "<leader>cf", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "Format current file", silent = true })
