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
                "vim", "vimdoc", "yaml", "toml", "dockerfile", "gitignore", "regex", "printf"
            },
            auto_install = true,
            sync_install = false,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                -- Disable for large files
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },

            indent = {
                enable = true,
                disable = { "python" }
            },

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
                        ["as"] = "@statement.outer",
                        ["is"] = "@statement.outer",
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v',
                        ['@function.outer'] = 'V',
                        ['@class.outer'] = '<c-v>',
                    },
                },

                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]c"] = "@class.outer",
                        ["]b"] = "@block.outer",
                        ["]s"] = "@statement.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[c"] = "@class.outer",
                        ["[b"] = "@block.outer",
                        ["[s"] = "@statement.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]C"] = "@class.outer",
                        ["]B"] = "@block.outer",
                        ["]S"] = "@statement.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[C"] = "@class.outer",
                        ["[B"] = "@block.outer",
                        ["[S"] = "@statement.outer",
                    },
                },

                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>pa"] = "@parameter.inner",
                        ["<leader>fm"] = "@function.outer",
                    },
                    swap_previous = {
                        ["<leader>pA"] = "@parameter.inner",
                        ["<leader>fM"] = "@function.outer",
                    },
                },

                lsp_interop = {
                    enable = true,
                    border = 'rounded',
                    peek_definition_code = {
                        ["<leader>pf"] = "@function.outer",
                        ["<leader>pc"] = "@class.outer",
                    },
                },
            },
        })

        -- Auto-install missing parsers
        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function()
                local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
                if lang and not pcall(vim.treesitter.language.get_lang, lang) then
                    vim.cmd("TSInstall " .. lang)
                end
            end,
        })
    end,
}
