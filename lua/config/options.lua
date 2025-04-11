-- INDENTATION
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.shiftwidth = 4          -- Number of spaces per indentation level
vim.opt.tabstop = 4             -- Number of spaces that a <Tab> counts for
vim.opt.softtabstop = 4         -- Number of spaces inserted when pressing Tab
vim.opt.smartindent = true      -- Smart autoindenting on new lines
vim.opt.autoindent = true       -- Auto-indent new lines
vim.opt.smarttab = true         -- Make tabbing smarter when going backwards

-- UI / VISUALS
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true   -- Relative line numbers for better navigation
vim.opt.cursorline = true       -- Highlight the current line
vim.opt.signcolumn = "yes"      -- Always show sign column
vim.opt.breakindent = true      -- Wrap indents visually
vim.opt.scrolloff = 5           -- Keep 5 lines above/below the cursor
vim.opt.showmode = false        -- Don't show -- INSERT -- (use statusline)
vim.opt.cmdheight = 0           -- Minimize command height (good for noice.nvim, optional)

-- SEARCH
vim.opt.ignorecase = true       -- Case-insensitive search
vim.opt.smartcase = true        -- Case-sensitive if capital letters are used

-- FILES
vim.opt.undofile = true         -- Save undo history
vim.opt.swapfile = false        -- Disable swapfile (optional)

-- PERFORMANCE
vim.opt.updatetime = 300        -- Faster completion
vim.opt.lazyredraw = true       -- Don't redraw screen during macros

-- CLIPBOARD & MOUSE
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.mouse = "a"               -- Enable mouse in all modes

-- SPLITS
vim.opt.splitright = true       -- Vertical splits open to the right
vim.opt.splitbelow = true       -- Horizontal splits open to the bottom

-- WHITESPACE (visible formatting chars)
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- Optional: Netrw visual tweak if you're using it alongside Oil.nvim
vim.cmd("let g:netrw_liststyle = 3")
