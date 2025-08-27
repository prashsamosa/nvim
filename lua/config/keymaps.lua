local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("n", "<leader>nh", "<cmd>nohlsearch<CR>")
map("n", "<leader>+", "<C-a>")
map("n", "<leader>-", "<C-x>")

map("v", "p", '"_dP')
map({ "n", "v" }, "<leader>y", '"+y')

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR><ESC>")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Window navigation (keep these but let LSP handle <C-k> for signature help)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
-- Removed <C-k> to avoid conflict with LSP signature help
map("n", "<C-l>", "<C-w>l")

map("n", "<leader>|", "<cmd>vsplit<CR>")
map("n", "<leader>\\", "<cmd>split<CR>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "<", "<gv")
map("v", ">", ">gv")

map("t", "<ESC><ESC>", "<C-\\><C-n>")

map("n", "<leader>df", vim.diagnostic.open_float)

map("n", "]q", "<cmd>cnext<CR>")
map("n", "[q", "<cmd>cprev<CR>")

map("n", "<C-a>", "ggVG")
