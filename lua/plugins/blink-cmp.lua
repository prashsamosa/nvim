-- Configure the 'blink.cmp' completion plugin for Neovim,
-- providing a fast and efficient completion experience.

return {
    -- Compatibility layer for 'blink.cmp' with other completion sources.
    {
        "saghen/blink.compat",
        version = "*", -- Use the latest release
        lazy = true,   -- Load only when needed by 'blink.cmp'
        opts = {},    -- Ensure setup function is called
    },

    -- The core 'blink.cmp' completion engine.
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets", -- Collection of pre-defined code snippets.
            "moyiz/blink-emoji.nvim",     -- Provides emoji completions.
            "ray-x/cmp-sql",               -- Provides SQL completions (via compatibility layer).
        },

        version = "1.*", -- Use a specific major version for stability
        -- build = 'cargo build --release', -- Uncomment to build from source (requires Rust nightly)
        -- build = 'nix run .#build-plugin', -- Uncomment for Nix build

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- Key mappings for the completion menu.
            keymap = {
                preset = "default", -- Use default mappings (Ctrl+y to accept)
                ["<C-Z>"] = { "accept", "fallback" }, -- Custom mapping to accept with Ctrl+z
            },

            -- Appearance of the completion menu.
            appearance = {
                nerd_font_variant = "mono", -- Use 'Nerd Font Mono' for icon alignment
            },

            -- Documentation popup configuration.
            completion = {
                documentation = { auto_show = true }, -- Automatically show documentation
            },

            -- Signature help configuration.
            signature = { enabled = true }, -- Enable displaying function parameters

            -- Enabled completion sources and their configuration.
            sources = {
                default = {
                    "lsp",      -- Language Server Protocol completions
                    "path",     -- File path completions
                    "snippets", -- Completions from snippet engines
                    "buffer",   -- Completions from the current buffer
                    "emoji",    -- Completions from 'blink-emoji.nvim'
                    "sql",      -- Completions from 'cmp-sql' (via blink.compat)
                },
                providers = {
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15, -- Adjust scoring for priority
                        opts = { insert = true }, -- Insert the emoji character
                        should_show_items = function()
                            -- Enable emoji completion for git commit and markdown files only
                            return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
                        end,
                    },
                    sql = {
                        name = "sql", -- Must match the name used in nvim-cmp
                        module = "blink.compat.source",
                        score_offset = -3,
                        opts = {}, -- Options passed to 'cmp-sql'
                        should_show_items = function()
                            -- Enable SQL completion for SQL files only
                            return vim.tbl_contains({ "sql" }, vim.o.filetype)
                        end,
                    },
                },
            },

            -- Fuzzy matching configuration.
            fuzzy = {
                implementation = "prefer_rust_with_warning", -- Use Rust matcher if available
            },
        },
        -- Extend the default sources list for other plugins to contribute
        opts_extend = { "sources.default" },
    },
}