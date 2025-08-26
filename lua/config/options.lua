vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable unused providers (performance optimization)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
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
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.showmode = false
opt.laststatus = 3
opt.pumheight = 10
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

-- Timing
opt.updatetime = 250
opt.timeoutlen = 300
opt.redrawtime = 10000
opt.synmaxcol = 200

-- System
opt.clipboard = "unnamedplus"
opt.mouse = "a"

-- Splits
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

-- Completion - Neovim 0.11 defaults
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmode = { "longest:full", "full" }

-- Colors
opt.termguicolors = true

-- Characters
opt.list = true
opt.listchars = {
    tab = "» ",
    trail = "·",
    extends = "❯",
    precedes = "❮",
    nbsp = "␣",
}

opt.fillchars = {
    eob = " ",
    fold = " ",
    foldopen = "",
    foldclose = "",
    diff = "╱",
    vertleft = "▎",
    vertright = " ",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    verthoriz = "╋",
}

-- Folding - Neovim 0.11 with treesitter
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""

-- Session
opt.sessionoptions = {
    "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds"
}

-- Neovim 0.11 enhanced defaults
opt.diffopt:append("algorithm:histogram")
opt.spelloptions:append("camel")

-- Autocmds
local augroup = vim.api.nvim_create_augroup("BasicConfig", { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank({ timeout = 150 })
    end,
})

-- Restore cursor position
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

-- Auto-resize windows
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    command = "wincmd =",
})

-- Auto-create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Clean whitespace on save for specific filetypes
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx", "*.go", "*.rs" },
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})
