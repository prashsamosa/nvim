-- Configure Neovim options for customized behavior and appearance.

-- ===== INDENTATION =====
vim.opt.expandtab = true       -- Use spaces instead of tabs.
vim.opt.shiftwidth = 4         -- Number of spaces per indentation level.
vim.opt.tabstop = 4            -- Display width of a <Tab>.
vim.opt.softtabstop = 4        -- Spaces inserted for a <Tab> press (visual tab).
vim.opt.smartindent = true     -- Smart auto-indenting on new lines.
vim.opt.autoindent = true      -- Auto-indent based on the previous line.
vim.opt.smarttab = true        -- Smarter backspace unindentation.

-- ===== UI / VISUALS =====
vim.opt.number = true          -- Show line numbers.
vim.opt.relativenumber = true  -- Show relative line numbers.
vim.opt.cursorline = true      -- Highlight the current line.
vim.opt.signcolumn = "yes"     -- Always show the sign column.
vim.opt.breakindent = true     -- Indent wrapped lines visually.
vim.opt.scrolloff = 5          -- Keep context lines above/below cursor.
vim.opt.showmode = false       -- Don't display the current mode (statusline is used).
vim.opt.cmdheight = 0          -- Minimize command line height (using alternative UI).

-- ===== SEARCH =====
vim.opt.ignorecase = true      -- Case-insensitive search by default.
vim.opt.smartcase = true       -- Case-sensitive search if pattern has uppercase.

-- ===== FILES =====
vim.opt.undofile = true        -- Persistent undo history.
vim.opt.swapfile = false       -- Disable swap files (consider data safety).

-- ===== PERFORMANCE =====
vim.opt.updatetime = 300       -- Interval to check for updates (milliseconds).
vim.opt.lazyredraw = true      -- Don't redraw during macro execution.

-- ===== CLIPBOARD & MOUSE =====
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for copy/paste.
vim.opt.mouse = "a"            -- Enable mouse support in all modes.

-- ===== SPLITS =====
vim.opt.splitright = true      -- New vertical splits to the right.
vim.opt.splitbelow = true      -- New horizontal splits below.

-- ===== WHITESPACE =====
vim.opt.list = true            -- Show special whitespace characters.
vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
}

-- ===== Optional: Netrw visual tweak =====
-- Adjust Netrw list style, possibly for better integration with other file explorers.
vim.cmd("let g:netrw_liststyle = 3")