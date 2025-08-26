-- Enhanced Neovim options with better defaults and performance

-- Indentation - More consistent and modern defaults
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 4     -- Number of spaces for auto-indent
vim.opt.tabstop = 4        -- Number of spaces a tab represents
vim.opt.softtabstop = 4    -- Number of spaces for <Tab> in insert mode
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true  -- Copy indent from current line
vim.opt.shiftround = true  -- Round indent to multiple of shiftwidth
vim.opt.smarttab = true    -- Smart tab behavior

-- UI / Visuals - Enhanced visual experience
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.cursorcolumn = false -- Don't highlight current column (performance)
vim.opt.signcolumn = "yes:2" -- Always show 2-character sign column
vim.opt.colorcolumn = "80,120" -- Show rulers at 80 and 120 columns
vim.opt.wrap = false -- Don't wrap lines
vim.opt.breakindent = true -- Maintain indent when wrapping
vim.opt.linebreak = true -- Break at word boundaries
vim.opt.showbreak = "↪ " -- String to show at line breaks
vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.showmode = false -- Don't show mode in command line (statusline shows it)
vim.opt.cmdheight = 1 -- Command line height (0 can be problematic with some plugins)
vim.opt.laststatus = 3 -- Global statusline
vim.opt.showtabline = 2 -- Always show tabline
vim.opt.ruler = false -- Hide ruler (statusline shows position)
vim.opt.showcmd = true -- Show partial commands
vim.opt.conceallevel = 0 -- Don't conceal by default
vim.opt.concealcursor = "" -- Don't conceal on cursor line

-- Search - Improved search behavior
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true  -- Case-sensitive if uppercase letters
vim.opt.incsearch = true  -- Show search results as you type
vim.opt.hlsearch = true   -- Highlight search results
vim.opt.wrapscan = true   -- Wrap search around file
vim.opt.gdefault = false  -- Don't use global flag by default in substitute

-- Files and backup - Modern approach
vim.opt.undofile = true     -- Persistent undo
vim.opt.undolevels = 10000  -- Maximum number of undos
vim.opt.undoreload = 10000  -- Save whole buffer for undo when reloading
vim.opt.backup = false      -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup while editing
vim.opt.swapfile = false    -- Don't create swap files
vim.opt.autowrite = true    -- Auto-save before commands like :next
vim.opt.autoread = true     -- Auto-reload files changed outside vim
vim.opt.confirm = true      -- Confirm before closing unsaved files

-- Performance - Better performance settings
vim.opt.updatetime = 250      -- Faster completion (default 4000ms)
vim.opt.timeoutlen = 500      -- Time to wait for mapped sequence (default 1000ms)
vim.opt.ttimeoutlen = 10      -- Time to wait for key codes
vim.opt.redrawtime = 10000    -- Time in milliseconds for redrawing
vim.opt.maxmempattern = 20000 -- Maximum memory for pattern matching
vim.opt.lazyredraw = false    -- Don't use lazyredraw (can cause issues with modern plugins)
vim.opt.ttyfast = true        -- Fast terminal connection
vim.opt.synmaxcol = 300       -- Only syntax highlight first 300 columns

-- Clipboard & Mouse - Enhanced interaction
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.mouse = "a"               -- Enable mouse in all modes
vim.opt.mousefocus = true         -- Focus follows mouse
vim.opt.mousemodel = "popup"      -- Right-click popup menu

-- Splits - Better split behavior
vim.opt.splitright = true    -- Vertical splits go to the right
vim.opt.splitbelow = true    -- Horizontal splits go below
vim.opt.splitkeep = "screen" -- Keep text on screen when splitting

-- Completion - Enhanced completion
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.opt.pumheight = 15 -- Maximum items in popup menu
vim.opt.pumblend = 10  -- Transparency for popup menu
vim.opt.winblend = 0   -- Transparency for floating windows (disabled for better visibility)
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.wildoptions = "pum,fuzzy"
vim.opt.wildignore:append({
    "*.o", "*.obj", "*.pyc", "*.pyo", "*.pyd", "*.class", "*.lock",
    "*.so", "*.dll", "*.swp", "*.swo", "*.tmp", "*~", ".git/",
    "node_modules/", "__pycache__/", ".pytest_cache/", "*.egg-info/",
})

-- Whitespace - Better whitespace handling
vim.opt.list = true -- Show whitespace characters
vim.opt.listchars = {
    tab = "» ", -- Tab characters
    trail = "·", -- Trailing spaces
    nbsp = "␣", -- Non-breaking spaces
    extends = "❯", -- Line continues beyond screen
    precedes = "❮", -- Line precedes beyond screen
    eol = "↴", -- End of line (disabled by default)
}
vim.opt.fillchars = {
    vert = "│", -- Vertical separator
    fold = " ", -- Fold character
    foldopen = "╰", -- Fold open
    foldclose = "╭", -- Fold close
    foldsep = "│", -- Fold separator
    diff = "╱", -- Diff character
    eob = " ", -- End of buffer
    horiz = "─", -- Horizontal separator
    horizup = "┴", -- Horizontal up
    horizdown = "┬", -- Horizontal down
    vertleft = "┤", -- Vertical left
    vertright = "├", -- Vertical right
    verthoriz = "┼", -- Vertical horizontal
}

-- Folding - Better folding defaults
vim.opt.foldmethod = "indent" -- Use indent for folding (treesitter will override)
vim.opt.foldlevel = 99        -- Don't fold by default
vim.opt.foldlevelstart = 99   -- Start with all folds open
vim.opt.foldenable = true     -- Enable folding
vim.opt.foldcolumn = "1"      -- Show fold column

-- Command line - Better command line experience
vim.opt.history = 10000        -- Command history length
vim.opt.inccommand = "nosplit" -- Live preview of substitute commands

-- Diff mode - Better diff visualization
vim.opt.diffopt:append({
    "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal", "linematch:60"
})

-- Session - Better session handling
vim.opt.sessionoptions = {
    "blank", "buffers", "curdir", "folds", "help", "tabpages", "winsize", "winpos", "terminal", "localoptions"
}

-- Misc - Additional improvements
vim.opt.virtualedit = "block"                    -- Allow cursor beyond end of line in visual block
vim.opt.startofline = false                      -- Keep cursor column when moving
vim.opt.backspace = { "indent", "eol", "start" } -- Backspace behavior
vim.opt.whichwrap:append("<,>,[,],h,l")          -- Allow movement keys to wrap
vim.opt.iskeyword:append("-")                    -- Treat dash as part of word
vim.opt.formatoptions:remove({ "c", "r", "o" })  -- Don't auto-comment new lines
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.showmatch = true                         -- Highlight matching brackets
vim.opt.matchtime = 2                            -- Time to show matching bracket

-- Netrw - Disable netrw (we use file managers like Oil or Mini.files)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Terminal - Better terminal colors
vim.opt.termguicolors = true -- Enable 24-bit colors

-- Spell checking - Basic spell check setup
vim.opt.spell = false                  -- Disable spell check by default
vim.opt.spelllang = { "en_us" }        -- Spell check language
vim.opt.spellsuggest = { "best", "9" } -- Spell suggestions

-- Security - Disable some risky options
vim.opt.modeline = false -- Disable modeline for security
vim.opt.exrc = false     -- Don't read .nvimrc from current directory

-- Providers - Disable unused providers for faster startup
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0

-- Python provider (keep python3 if you use it)
-- vim.g.loaded_python3_provider = 0

-- Custom autocommands for better UX
local augroup = vim.api.nvim_create_augroup("CustomOptions", { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
    desc = "Highlight yanked text",
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    command = "wincmd =",
    desc = "Resize splits when window is resized",
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
    desc = "Remove trailing whitespace on save",
})

-- Return to last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
    desc = "Return to last edit position",
})

-- Close certain windows with 'q'
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = {
        "qf", "help", "man", "lspinfo", "spectre_panel", "startuptime",
        "tsplayground", "PlenaryTestPopup", "checkhealth", "neotest-output",
        "neotest-summary", "neotest-output-panel", "notify",
    },
    callback = function()
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
    end,
    desc = "Close certain windows with 'q'",
})
