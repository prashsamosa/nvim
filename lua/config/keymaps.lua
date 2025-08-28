local map = vim.keymap.set
local opts = { silent = true }

-- Essential mappings
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Better paste in visual mode
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- System clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- Save file
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR><ESC>", { desc = "Save file" })

-- Better navigation
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Window management
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>\\", "<cmd>split<CR>", { desc = "Horizontal split" })

-- Visual mode improvements
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("v", "<", "<gv", { desc = "Decrease indent" })
map("v", ">", ">gv", { desc = "Increase indent" })

-- Terminal
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Terminal left window" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Terminal lower window" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Terminal upper window" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Terminal right window" })

-- Diagnostics
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })

-- Quickfix
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix" })

-- Select all
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Global inlay hints toggle
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })


-- Buffer management
map("n", "<leader>bd", function()
  require("snacks").bufdelete()
end, { desc = "Delete buffer" })

-- Format on save toggle
map("n", "<leader>cF", "<cmd>ConformToggle<cr>", { desc = "Toggle format on save" })
