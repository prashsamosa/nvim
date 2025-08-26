return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash", "c", "cpp", "css", "go", "html", "javascript", "json", "lua",
                "markdown", "markdown_inline", "python", "rust", "tsx", "typescript",
                "vim", "vimdoc", "yaml", "toml", "dockerfile", "gitignore"
            },
            auto_install = true,
            sync_install = false,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },

            indent = { enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Enter>",
                    node_incremental = "<Enter>",
                    scope_incremental = "<S-Enter>",
                    node_decremental = "<BS>",
                },
            },

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["ab"] = "@block.outer",
                        ["ib"] = "@block.inner",
                    },
                },

                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]c"] = "@class.outer",
                        ["]b"] = "@block.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[c"] = "@class.outer",
                        ["[b"] = "@block.outer",
                    },
                },

                swap = {
                    enable = true,
                    swap_next = { ["<leader>pa"] = "@parameter.inner" },
                    swap_previous = { ["<leader>pA"] = "@parameter.inner" },
                },
            },
        })
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = false
    end,
}
