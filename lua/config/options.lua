vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.showmode = false
opt.laststatus = 3
opt.pumheight = 10
opt.cmdheight = 1

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

opt.undofile = true
opt.backup = false
opt.swapfile = false
opt.autowrite = true

-- Better performance
opt.updatetime = 50        -- Faster updates (was 250)
opt.timeoutlen = 300
opt.redrawtime = 10000     -- Better redraw performance

opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.splitright = true
opt.splitbelow = true

-- Enhanced completion for Neovim 0.11+
opt.completeopt = { "menu", "menuone", "noselect", "popup" }
opt.termguicolors = true
-- Better completion visuals
opt.pumblend = 10  -- Slight transparency for completion menu
opt.winblend = 0   -- No transparency for other windows

-- Enhanced LSP features
opt.shortmess:append("c")  -- Don't show completion messages

-- Enhanced search
opt.inccommand = "split"   -- Live preview for substitutions

opt.list = true
opt.listchars = { tab = "» ", trail = "·", extends = "❯", precedes = "❮" }

opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""

opt.diffopt:append("algorithm:histogram")
-- Better diff algorithm for Neovim 0.11+
opt.diffopt:append("linematch:60")

-- Neovim 0.11+ features
if vim.fn.has("nvim-0.11") == 1 then
  opt.smoothscroll = true
  opt.splitkeep = "cursor"  -- Keep cursor position when splitting
  opt.shortmess:append("WcC") -- Reduce command line messages
  -- New in 0.11
  opt.jumpoptions = "stack"  -- Better jump list
end

-- Better performance for large files
opt.maxmempattern = 5000  -- Increase pattern memory
opt.regexpengine = 0      -- Auto-select regexp engine

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
