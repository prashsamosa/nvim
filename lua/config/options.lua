-- lua/config/options.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local o = vim.opt

-- Editor behavior
o.mouse = "a"
o.clipboard = "unnamedplus"
o.autowrite = true
o.confirm = true

-- Indentation
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.breakindent = true -- Better line wrapping

-- UI
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.wrap = false
o.linebreak = true
o.scrolloff = 4
o.sidescrolloff = 4
o.showmode = false
o.laststatus = 3
o.cmdheight = 1

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true
o.inccommand = "split"

-- Files
o.undofile = true
o.backup = false
o.swapfile = false

-- Performance (optimized for 0.11)
o.updatetime = 250
o.timeoutlen = 300
o.redrawtime = 10000

-- Completion
o.completeopt = { "menu", "menuone", "noselect" }
o.pumheight = 15
o.pumblend = 10
o.winblend = 10 -- Floating window transparency

-- Visual enhancements
o.termguicolors = true
o.list = true
o.listchars = { tab = "» ", trail = "·", extends = "❯", precedes = "❮", nbsp = "␣" }

-- Folding (using treesitter)
o.foldlevel = 99
o.foldlevelstart = 99
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldtext = ""

-- Enhanced diff
o.diffopt:append("algorithm:histogram,linematch:60")

-- Neovim 0.11+ specific features
if vim.fn.has("nvim-0.11") == 1 then
  o.smoothscroll = true
  o.splitkeep = "cursor"
  o.jumpoptions = "stack"
  -- Enhanced completion for 0.11+
  o.completeopt:append("fuzzy")
end

-- Window splitting
o.splitright = true
o.splitbelow = true

-- Better defaults for modern editing
o.virtualedit = "block"       -- Allow cursor beyond line end in visual block mode
o.formatoptions:remove("cro") -- Disable auto comment continuation
