return {
    "nvim-treesitter/nvim-treesitter", -- Plugin: nvim-treesitter
    build = ":TSUpdate",               -- Command to run after installation/update

    config = function()
        local configs = require("nvim-treesitter.configs") -- Load the config module

        configs.setup({
            -- Configuration
            ensure_installed = { -- Languages to install parsers for
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "elixir",
                "heex",
                "javascript",
                "html",
                "markdown",
                "markdown_inline",     -- Required for proper Markdown parsing
                "latex",               -- Optional: LaTeX support
            },
            auto_install = true,       -- Automatically install parsers
            sync_install = false,      -- Install parsers asynchronously

            highlight = { enable = true }, -- Enable syntax highlighting
            indent = { enable = true }, -- Enable automatic indentation

            incremental_selection = {  -- Enable incremental selection
                enable = true,
                keymaps = {
                    -- Keybindings for incremental selection
                    init_selection = "<Enter>", -- Start selection with Enter
                    node_incremental = "<Enter>", -- Expand selection to parent node
                    scope_incremental = false, -- Disable scope-based selection
                    node_decremental = "<Backspace>", -- Shrink selection to previous node
                },
            },
        })
    end,
}
