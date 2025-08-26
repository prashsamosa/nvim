return {
    {
        "saghen/blink.compat",
        version = "*",
        lazy = true,
    },

    {
        "saghen/blink.cmp",
        version = "1.*",
        event = "InsertEnter",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "moyiz/blink-emoji.nvim",
            "ray-x/cmp-sql",
        },
        opts = function()
            local function get_filetype()
                local ok, ft = pcall(function() return vim.bo.filetype end)
                return ok and ft or ""
            end

            local function should_show_in(ft_list)
                return function()
                    return vim.tbl_contains(ft_list, get_filetype())
                end
            end

            return {
                keymap = {
                    preset = "default",
                    ["<CR>"] = { "accept", "fallback" },
                    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                    ["<C-k>"] = { "show", "show_documentation", "hide_documentation" },
                    ["<C-e>"] = { "hide", "fallback" },
                },

                appearance = {
                    nerd_font_variant = "mono",
                    kind_icons = {
                        Text = "󰉿",
                        Method = "󰆧",
                        Function = "󰊕",
                        Constructor = "",
                        Field = "󰜢",
                        Variable = "󰀫",
                        Class = "󰠱",
                        Interface = "",
                        Module = "",
                        Property = "󰜢",
                        Unit = "󰑭",
                        Value = "󰎠",
                        Enum = "",
                        Keyword = "󰌋",
                        Snippet = "",
                        Color = "󰏘",
                        File = "󰈙",
                        Reference = "󰈇",
                        Folder = "󰉋",
                        EnumMember = "",
                        Constant = "󰏿",
                        Struct = "󰙅",
                        Event = "",
                        Operator = "󰆕",
                        TypeParameter = "",
                    },
                },

                completion = {
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 200,
                        update_delay_ms = 50,
                        treesitter_highlighting = true,
                        window = {
                            max_width = 80,
                            max_height = 20,
                            border = "rounded",
                            scrollbar = true,
                        },
                    },
                    menu = {
                        border = "rounded",
                        scrollbar = true,
                        draw = {
                            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
                        },
                    },
                },

                signature = {
                    enabled = true,
                    window = {
                        border = "rounded",
                        scrollbar = false,
                    },
                },

                sources = {
                    default = {
                        "lsp",
                        "path",
                        "snippets",
                        "buffer",
                        "emoji",
                        "sql",
                    },

                    providers = {
                        emoji = {
                            module = "blink-emoji",
                            name = "Emoji",
                            score_offset = 15,
                            opts = { insert = true },
                            should_show_items = should_show_in({ "gitcommit", "markdown", "text" }),
                        },

                        sql = {
                            module = "blink.compat.source",
                            name = "sql",
                            score_offset = -3,
                            opts = {},
                            should_show_items = should_show_in({ "sql", "mysql", "plsql" }),
                        },

                        lsp = {
                            name = "LSP",
                            module = "blink.cmp.sources.lsp",
                            score_offset = 90,
                        },

                        path = {
                            name = "Path",
                            module = "blink.cmp.sources.path",
                            score_offset = 3,
                            opts = {
                                trailing_slash = false,
                                label_trailing_slash = true,
                                get_cwd = function(context) return vim.fn.expand(("#%d:p:h"):format(context.bufnr)) end,
                                show_hidden_files_by_default = false,
                            },
                        },

                        snippets = {
                            name = "Snippets",
                            module = "blink.cmp.sources.snippets",
                            score_offset = -3,
                            opts = {
                                friendly_snippets = true,
                                search_paths = { vim.fn.stdpath("config") .. "/snippets" },
                                global_snippets = { "all" },
                                extended_filetypes = {},
                                ignored_filetypes = {},
                            },
                        },

                        buffer = {
                            name = "Buffer",
                            module = "blink.cmp.sources.buffer",
                            score_offset = -3,
                            opts = {
                                max_items = 5,
                                min_keyword_length = 3,
                            },
                        },
                    },
                },

                fuzzy = {
                    use_frecency = true,
                    use_proximity = true,
                    max_items = 200,
                    sorts = { "label", "kind", "score" },
                },
            }
        end,

        opts_extend = { "sources.default" },
    },
}
