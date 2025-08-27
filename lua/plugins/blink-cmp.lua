return {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    dependencies = "rafamadriz/friendly-snippets",

    opts = {
        keymap = {
            preset = "default",
            ["<CR>"] = { "accept", "fallback" },
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<C-j>"] = { "show_documentation", "hide_documentation" }, -- Fixed: Changed from C-d to avoid scroll conflict
            ["<C-e>"] = { "hide", "fallback" },
            ["<C-space>"] = { "show", "fallback" },
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },

        completion = {
            accept = { auto_brackets = { enabled = true } },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = { max_width = 80, max_height = 20, border = "rounded" },
            },
            menu = {
                border = "rounded",
                draw = {
                    columns = {
                        { "kind_icon" },
                        { "label",    "label_description", gap = 1 }
                    }
                },
            },
        },

        signature = {
            enabled = true,
            window = { border = "rounded" }
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
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
                        get_cwd = function(ctx) return vim.fn.expand(("#%d:p:h"):format(ctx.bufnr)) end
                    }
                },
                snippets = {
                    name = "Snippets",
                    module = "blink.cmp.sources.snippets",
                    score_offset = -3,
                    opts = {
                        friendly_snippets = true,
                        search_paths = { vim.fn.stdpath("config") .. "/snippets" }
                    },
                },
                buffer = {
                    name = "Buffer",
                    module = "blink.cmp.sources.buffer",
                    score_offset = -3,
                    opts = {
                        max_items = 5,
                        min_keyword_length = 3,
                        get_bufnrs = function()
                            return vim.tbl_filter(
                                function(buf) return vim.bo[buf].buftype ~= "nofile" end,
                                vim.api.nvim_list_bufs()
                            )
                        end
                    },
                },
            },
        },
    },

    opts_extend = { "sources.default" },
}
