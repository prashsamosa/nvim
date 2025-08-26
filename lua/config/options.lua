vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.shiftround = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.showmode = false
opt.laststatus = 3
opt.pumheight = 10
opt.pumblend = 10
opt.cmdheight = 1

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.undofile = true
opt.backup = false
opt.swapfile = false
opt.autowrite = true
opt.autoread = true

opt.updatetime = 250
opt.timeoutlen = 300
opt.redrawtime = 10000
opt.synmaxcol = 200

opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmode = { "longest:full", "full" }

opt.termguicolors = true

opt.list = true
opt.listchars = {
    tab = "» ",
    trail = "·",
    extends = "❯",
    precedes = "❮",
}

opt.fillchars = {
    eob = " ",
    fold = " ",
    foldopen = "",
    foldclose = "",
    diff = "╱",
}

opt.foldlevel = 99
opt.foldlevelstart = 99

opt.sessionoptions = {
    "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds"
}

local augroup = vim.api.nvim_create_augroup("BasicConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank({ timeout = 150 })
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    command = "wincmd =",
})
