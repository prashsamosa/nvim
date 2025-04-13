-- This file configures the 'fzf-lua' plugin, which provides a fast and
-- feature-rich fuzzy finder using the 'fzf' command-line tool. It allows
-- you to quickly search and open files, buffers, help tags, and more within
-- Neovim.

return {
    "ibhagwan/fzf-lua", -- The plugin specification: name of the GitHub repository.
    -- Optional dependency for displaying icons in the fzf-lua results.
    "nvim-tree/nvim-web-devicons",
    -- Alternatively, if you are using 'mini.icons' from the 'mini.nvim' suite,
    -- you can specify it as a dependency. This ensures that the icons are
    -- available if 'mini.icons' is installed.
    dependencies = { "echasnovski/mini.icons" },
    opts = {}, -- Configuration options for 'fzf-lua'. This table is currently empty,
              -- meaning it's using the default settings. You could add custom
              -- configurations here if needed (see the 'fzf-lua' documentation).
    keys = { -- Define keybindings for various 'fzf-lua' functionalities.
        {
            "<leader>zf", -- Changed from <leader>ff. This defines a keybinding
                         -- in normal mode. When you press your leader key (usually
                         -- space) followed by 'z' and then 'f', the associated
                         -- function will be executed.
            function()
                require("fzf-lua").files() -- Calls the 'files' function of 'fzf-lua',
                                         -- which opens a fuzzy finder for files in the
                                         -- current working directory.
            end,
            desc = "[Z]FZ Find Files", -- A description for this keybinding, useful
                                      -- for plugins like 'which-key.nvim'. The '[Z]FZ'
                                      -- prefix likely indicates that these keybindings
                                      -- are related to 'fzf-lua'.
        },
        {
            "<leader>zg", -- Changed from <leader>fg. Keybinding for live grep.
            function()
                require("fzf-lua").live_grep() -- Opens a fuzzy finder for live grep,
                                            -- allowing you to search for a pattern
                                            -- across your project files.
            end,
            desc = "[Z]FZ Live Grep",
        },
        {
            "<leader>zc", -- Changed from <leader>fc. Keybinding to find files
                         -- within the Neovim configuration directory.
            function()
                require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) -- Opens
                                                                         -- the file finder,
                                                                         -- but restricts the
                                                                         -- search to your
                                                                         -- Neovim configuration
                                                                         -- directory.
            end,
            desc = "[Z]FZ Find in Config",
        },
        {
            "<leader>zh", -- Changed from <leader>fh. Keybinding to search help tags.
            function()
                require("fzf-lua").helptags() -- Opens a fuzzy finder for Neovim's
                                           -- help tags, allowing you to quickly
                                           -- navigate the documentation.
            end,
            desc = "[Z]FZ [H]elptags",
        },
        {
            "<leader>zk", -- Changed from <leader>fk. Keybinding to list keymaps.
            function()
                require("fzf-lua").keymaps() -- Opens a fuzzy finder displaying
                                           -- all defined keybindings in Neovim.
            end,
            desc = "[Z]FZ [K]eymaps",
        },
        {
            "<leader>zb", -- Changed from <leader>fb. Keybinding to list built-in commands.
            function()
                require("fzf-lua").builtin() -- Opens a fuzzy finder for Neovim's
                                           -- built-in commands.
            end,
            desc = "[Z]FZ [B]uiltins",
        },
        {
            "<leader>zw", -- Changed from <leader>fw. Keybinding to grep for the
                         -- word under the cursor.
            function()
                require("fzf-lua").grep_cword() -- Performs a live grep search for
                                              -- the word currently under your cursor.
            end,
            desc = "[Z]FZ Find current [W]ord",
        },
        {
            "<leader>zW", -- Changed from <leader>fW. Keybinding to grep for the
                         -- WORD under the cursor (case-sensitive).
            function()
                require("fzf-lua").grep_cWORD() -- Similar to 'grep_cword', but the
                                               -- search is case-sensitive.
            end,
            desc = "[Z]FZ Find current [W]ORD",
        },
        {
            "<leader>zd", -- Changed from <leader>fd. Keybinding to show diagnostics
                         -- for the current document.
            function()
                require("fzf-lua").diagnostics_document() -- Opens a fuzzy finder
                                                        -- displaying diagnostics
                                                        -- (errors, warnings) for
                                                        -- the currently open file.
            end,
            desc = "[Z]FZ [D]iagnostics",
        },
        {
            "<leader>zr", -- Changed from <leader>fr. Keybinding to resume the last fzf-lua search.
            function()
                require("fzf-lua").resume() -- Reopens the last 'fzf-lua' window with
                                          -- the previous search query and results.
            end,
            desc = "[Z]FZ [R]esume",
        },
        {
            "<leader>zo", -- Changed from <leader>fo. Keybinding to list old files.
            function()
                require("fzf-lua").oldfiles() -- Opens a fuzzy finder displaying
                                            -- the list of recently opened files.
            end,
            desc = "[Z]FZ [O]ld Files",
        },
        {
            "<leader>z<space>", -- Changed from <leader><leader>. Keybinding to list open buffers.
            function()
                require("fzf-lua").buffers() -- Opens a fuzzy finder displaying the
                                           -- list of currently open buffers in Neovim.
            end,
            desc = "[Z]FZ Buffers",
        },
        {
            "<leader>z/", -- Changed from <leader>/. Keybinding to live grep in the current buffer.
            function()
                require("fzf-lua").lgrep_curbuf() -- Performs a live grep search within
                                                -- the content of the current buffer.
            end,
            desc = "[Z]FZ Live grep current buffer",
        },
    },
}