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

-- Window navigation (restored full navigation)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k") -- Fixed: Restored C-k window navigation
map("n", "<C-l>", "<C-w>l")

map("n", "<leader>|", "<cmd>vsplit<CR>")
map("n", "<leader>\\", "<cmd>split<CR>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "<", "<gv")
map("v", ">", ">gv")

map("t", "<ESC><ESC>", "<C-\\><C-n>")

-- Enhanced terminal navigation
map("t", "<C-h>", "<cmd>wincmd h<CR>")
map("t", "<C-j>", "<cmd>wincmd j<CR>")
map("t", "<C-k>", "<cmd>wincmd k<CR>")
map("t", "<C-l>", "<cmd>wincmd l<CR>")

map("n", "<leader>df", vim.diagnostic.open_float)

map("n", "]q", "<cmd>cnext<CR>")
map("n", "[q", "<cmd>cprev<CR>")

map("n", "<C-a>", "ggVG")

-- Global inlay hints toggle
map("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })
