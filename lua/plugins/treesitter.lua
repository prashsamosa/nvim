-- Configure 'nvim-treesitter' for syntax highlighting, text objects, and more.

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Automatically update parsers after installation.
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects", -- Enable Tree-sitter-based text objects.
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { -- List of languages for which parsers should be installed.
                "c", "lua", "vim", "vimdoc", "query",
                "elixir", "heex", "javascript", "html",
                "markdown", "markdown_inline", "latex",
                "json", "yaml", "toml", "css", "python",
                "typescript", "tsx", "bash", "regex",
            },
            auto_install = true, -- Automatically install missing parsers.
            sync_install = false, -- Do not block startup while installing parsers.
            highlight = { enable = true }, -- Enable syntax highlighting.
            indent = { enable = true }, -- Enable automatic indentation.

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Enter>", -- Start incremental selection.
                    node_incremental = "<Enter>", -- Expand to the next node.
                    node_decremental = "<Backspace>", -- Shrink to the previous node.
                },
            },

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to the text object.
                    keymaps = {
                        ["af"] = "@function.outer", -- Select the outer function.
                        ["if"] = "@function.inner", -- Select the inner function.
                        ["ac"] = "@class.outer", -- Select the outer class.
                        ["ic"] = "@class.inner", -- Select the inner class.
                        ["ao"] = "@comment.outer", -- Select the outer comment block.
                        ["as"] = "@scope", -- Select the current scope.
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- Charwise selection for parameters.
                        ['@function.outer'] = 'V', -- Linewise selection for functions.
                        ['@class.outer'] = '<c-v>', -- Blockwise selection for classes.
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner", -- Swap with the next parameter.
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner", -- Swap with the previous parameter.
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- Add jumps to the jumplist.
                    goto_next_start = {
                        ["]m"] = "@function.outer", -- Next function start.
                        ["]]"] = { query = "@class.outer", desc = "Next class start" },
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer", -- Next function end.
                        ["]["] = "@class.outer", -- Next class end.
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer", -- Previous function start.
                        ["[["] = "@class.outer", -- Previous class start.
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer", -- Previous function end.
                        ["[]"] = "@class.outer", -- Previous class end.
                    },
                },
            },
        })
    end,
}