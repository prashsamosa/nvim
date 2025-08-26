-- lua/config/options.lua - Optimized for Neovim 0.11

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable unused providers (performance)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Core settings
local opt = vim.opt

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2 -- Standard 2 spaces (was 4)
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.shiftround = true

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.wrap = false
opt.scrolloff = 4 -- Reduced from 8
opt.sidescrolloff = 4
opt.showmode = false
opt.laststatus = 3
opt.pumheight = 10 -- Reduced from 15
opt.pumblend = 10
opt.cmdheight = 1

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Files
opt.undofile = true
opt.backup = false
opt.swapfile = false
opt.autowrite = true
opt.autoread = true

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300 -- Reduced from 500
opt.redrawtime = 10000
opt.synmaxcol = 200  -- Reduced from 300

-- System integration
opt.clipboard = "unnamedplus"
opt.mouse = "a"

-- Splits
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmode = { "longest:full", "full" }

-- Terminal
opt.termguicolors = true

-- Appearance
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

-- Folding
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Session
opt.sessionoptions = {
    "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds"
}

-- Simple autocommands only
local augroup = vim.api.nvim_create_augroup("BasicConfig", { clear = true })

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank({ timeout = 150 })
    end,
})

-- Return to last position
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

-- Auto-resize splits
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    command = "wincmd =",
})
