-- This file configures various Neovim options to customize its behavior
-- and appearance. These options control things like indentation, UI elements,
-- search behavior, file handling, performance, and more.

-- ===== INDENTATION =====
-- Configure settings related to code indentation.
vim.opt.expandtab = true         -- Use spaces instead of tabs. When you press <Tab>,
                                 -- Neovim will insert spaces. This promotes consistency
                                 -- across different editors.
vim.opt.shiftwidth = 4           -- Number of spaces per indentation level. This
                                 -- determines how many spaces are inserted or removed
                                 -- when using indentation commands (e.g., >> or <<).
vim.opt.tabstop = 4              -- Number of spaces that a <Tab> character counts for
                                 -- in terms of display width. Even though we're using
                                 -- spaces, this affects how existing tabs are displayed.
vim.opt.softtabstop = 4          -- Number of spaces inserted when pressing the <Tab> key.
                                 -- This provides the visual effect of using tabs while
                                 -- actually inserting spaces (due to expandtab).
vim.opt.smartindent = true       -- Smart auto-indenting on new lines. Neovim will
                                 -- try to guess the correct indentation level based on
                                 -- the previous line.
vim.opt.autoindent = true        -- Automatically indent new lines based on the
                                 -- indentation of the previous line.
vim.opt.smarttab = true          -- Make tabbing smarter when going backwards. When
                                 -- unindenting with <BS> at the beginning of a line,
                                 -- it will remove a shiftwidth of spaces if possible.

-- ===== UI / VISUALS =====
-- Customize the user interface and visual elements of Neovim.
vim.opt.number = true            -- Show line numbers in the left margin. This is helpful
                                 -- for navigating and referencing specific lines of code.
vim.opt.relativenumber = true    -- Display relative line numbers. The current line shows
                                 -- 0, the line above shows 1, the line below shows 1, etc.
                                 -- This makes it easy to jump up or down a specific number
                                 -- of lines using commands like `5j` or `3k`.
vim.opt.cursorline = true        -- Highlight the current line the cursor is on. This
                                 -- improves visibility of the active line.
vim.opt.signcolumn = "yes"       -- Always show the sign column, even if there are no
                                 -- signs (e.g., from LSP or Git) to display. This prevents
                                 -- the text from shifting when signs appear or disappear.
vim.opt.breakindent = true       -- Visually indent wrapped lines to align with the
                                 -- start of the original line. This makes wrapped long
                                 -- lines more readable.
vim.opt.scrolloff = 5            -- Keep at least 5 lines visible above and below the
                                 -- cursor when scrolling. This provides context and
                                 -- prevents the cursor from getting too close to the edges
                                 -- of the screen.
vim.opt.showmode = false         -- Don't display the current mode (e.g., -- INSERT --)
                                 -- in the command line. This information is often better
                                 -- placed in a statusline (which you likely have configured
                                 -- elsewhere).
vim.opt.cmdheight = 0            -- Minimize the height of the command line area. This
                                 -- can be aesthetically pleasing and saves screen real estate,
                                 -- especially when using plugins like noice.nvim that provide
                                 -- alternative ways to display messages.

-- ===== SEARCH =====
-- Configure how Neovim handles search operations.
vim.opt.ignorecase = true        -- Perform case-insensitive searches by default.
vim.opt.smartcase = true         -- Override ignorecase if the search pattern contains
                                 -- at least one uppercase letter. This provides a more
                                 -- intuitive search experience.

-- ===== FILES =====
-- Settings related to how Neovim handles files.
vim.opt.undofile = true          -- Persistently save undo history across sessions. This
                                 -- allows you to undo changes even after closing and
                                 -- reopening a file.
vim.opt.swapfile = false         -- Disable the use of swap files. Swap files are used
                                 -- to recover unsaved changes in case of a crash. Disabling
                                 -- them can improve performance on some systems but reduces
                                 -- data safety. Consider the trade-offs.

-- ===== PERFORMANCE =====
-- Options that can impact Neovim's performance.
vim.opt.updatetime = 300         -- Set the interval (in milliseconds) at which Neovim
                                 -- checks for changes that might trigger autocommands
                                 -- or other updates. A lower value can improve responsiveness
                                 -- for things like completion but might increase CPU usage.
vim.opt.lazyredraw = true        -- Prevent redrawing the screen during macro execution.
                                 -- This can significantly speed up the execution of complex
                                 -- macros, especially those that involve many changes.

-- ===== CLIPBOARD & MOUSE =====
-- Configure how Neovim interacts with the system clipboard and mouse.
vim.opt.clipboard = "unnamedplus" -- Use the system clipboard for copy/paste operations.
                                 -- This allows you to copy text from Neovim and paste it
                                 -- into other applications, and vice versa. The "unnamedplus"
                                 -- register is typically linked to the system clipboard.
vim.opt.mouse = "a"              -- Enable mouse support in all modes (normal, insert,
                                 -- visual, command-line). This allows you to use the mouse
                                 -- for actions like selecting text, navigating windows, etc.

-- ===== SPLITS =====
-- Control the behavior of window splits.
vim.opt.splitright = true        -- Open new vertical splits to the right of the current
                                 -- window. This is a common preference for screen layout.
vim.opt.splitbelow = true        -- Open new horizontal splits below the current window.
                                 -- This also contributes to a more predictable layout.

-- ===== WHITESPACE (visible formatting chars) =====
-- Configure the display of special whitespace characters to help identify
-- formatting issues.
vim.opt.list = true              -- Enable the display of special characters for tabs,
                                 -- trailing spaces, etc.
vim.opt.listchars = {            -- Define the characters used to represent different
    tab = "» ",                 -- Display tabs as "» " (a right arrow followed by a space).
    trail = "·",                -- Display trailing spaces as "·" (a middle dot).
    nbsp = "␣",                 -- Display non-breaking spaces as "␣" (an open box).
}

-- ===== Optional: Netrw visual tweak if you're using it alongside Oil.nvim =====
-- This command sets a specific list style for Netrw (Neovim's built-in file explorer).
-- It's likely included here because you might have used Netrw before or as a fallback,
-- and this style might be preferred when it's used alongside a more modern file explorer
-- like Oil.nvim.
vim.cmd("let g:netrw_liststyle = 3")