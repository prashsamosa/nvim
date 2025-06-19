-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true

-- UI / Visuals
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.breakindent = true
vim.opt.scrolloff = 5
vim.opt.showmode = false
vim.opt.cmdheight = 0

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Files
vim.opt.undofile = true
vim.opt.swapfile = false

-- Performance
vim.opt.updatetime = 300
vim.opt.lazyredraw = true

-- Clipboard & Mouse
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Whitespace
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- Netrw
vim.g.netrw_liststyle = 3
