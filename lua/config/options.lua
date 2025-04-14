-- Configure Neovim options for customized behavior and appearance.

-- ===== INDENTATION =====
vim.opt.expandtab = true        -- Use spaces instead of tabs for indentation.
vim.opt.shiftwidth = 4          -- Number of spaces per indentation level.
vim.opt.tabstop = 4             -- Number of spaces a <Tab> character occupies.
vim.opt.softtabstop = 4         -- Number of spaces inserted when pressing <Tab>.
vim.opt.smartindent = true      -- Enable smart auto-indenting based on syntax.
vim.opt.autoindent = true       -- Automatically indent new lines.
vim.opt.smarttab = true         -- Adjust tab behavior based on 'shiftwidth'.

-- ===== UI / VISUALS =====
vim.opt.number = true           -- Show absolute line numbers.
vim.opt.relativenumber = true   -- Show relative line numbers.
vim.opt.cursorline = true       -- Highlight the current line.
vim.opt.signcolumn = "yes"      -- Always display the sign column.
vim.opt.breakindent = true      -- Indent wrapped lines.
vim.opt.scrolloff = 5           -- Keep 5 lines visible above/below the cursor.
vim.opt.showmode = false        -- Hide mode display (use statusline instead).
vim.opt.cmdheight = 0           -- Minimize the command line height.

-- ===== SEARCH =====
vim.opt.ignorecase = true       -- Case-insensitive search by default.
vim.opt.smartcase = true        -- Override 'ignorecase' if uppercase is used.

-- ===== FILES =====
vim.opt.undofile = true         -- Enable persistent undo history.
vim.opt.swapfile = false        -- Disable swap files.

-- ===== PERFORMANCE =====
vim.opt.updatetime = 300        -- Faster updates for better responsiveness.
vim.opt.lazyredraw = true       -- Optimize screen redraws during macros.

-- ===== CLIPBOARD & MOUSE =====
vim.opt.clipboard = "unnamedplus" -- Use the system clipboard.
vim.opt.mouse = "a"             -- Enable mouse support in all modes.

-- ===== SPLITS =====
vim.opt.splitright = true       -- Open vertical splits to the right.
vim.opt.splitbelow = true       -- Open horizontal splits below.

-- ===== WHITESPACE =====
vim.opt.list = true             -- Show special characters for whitespace.
vim.opt.listchars = {
    tab = "» ",                 -- Display for tabs.
    trail = "·",                -- Display for trailing spaces.
    nbsp = "␣",                 -- Display for non-breaking spaces.
}

-- ===== Optional: Netrw visual tweak =====
vim.g.netrw_liststyle = 3       -- Use a tree-like view in Netrw.