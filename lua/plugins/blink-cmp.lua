-- This file configures the 'blink.cmp' completion plugin for Neovim,
-- along with a compatibility layer and some related completion sources.
-- 'blink.cmp' is likely a fast and efficient completion engine written in Rust.

return {
    {
        "saghen/blink.compat",
        -- Use the latest release. This assumes you are also using the latest
        -- release for 'blink.cmp'. Using '*' for 'version' with lazy.nvim
        -- typically means to always use the newest available version.
        version = "*",
        -- This plugin is only needed by 'blink.cmp', so we mark it as lazy.
        -- lazy.nvim will automatically load it when 'blink.cmp' requires it.
        lazy = true,
        -- Ensure that the setup function of 'blink.compat' is called by lazy.nvim.
        -- Even if there are no specific options to configure for 'blink.compat' itself
        -- in this file, an empty 'opts' table ensures the plugin is properly initialized.
        opts = {},
    },
    {
        "saghen/blink.cmp",
        -- Optional dependencies that provide additional completion sources
        -- for 'blink.cmp'.
        dependencies = {
            "rafamadriz/friendly-snippets", -- A collection of pre-defined snippets.
            "moyiz/blink-emoji.nvim",     -- Provides emoji completion.
            "ray-x/cmp-sql",             -- Provides SQL completion.
        },

        -- Use a specific release tag to download pre-built binaries of 'blink.cmp'.
        -- This ensures you are using a specific version and can provide more
        -- stability than always using the latest.
        version = "1.*",
        -- AND/OR build from source. This requires a nightly build of Rust:
        -- https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you are using Nix, you can build from source using the latest nightly
        -- Rust environment defined in your Nix configuration:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- Configure the key mappings for 'blink.cmp'.
            keymap = {
                -- 'default' (recommended): Mappings similar to built-in Neovim
                -- completion (Ctrl+y to accept).
                -- 'super-tab': Mappings similar to VS Code (Tab to accept).
                -- 'enter': Enter key to accept.
                -- 'none': No default mappings are provided.
                preset = "default",
                -- Add a custom keybinding: Ctrl+z to accept the selected completion
                -- item and potentially trigger a fallback action if acceptance fails
                -- (though the exact fallback behavior depends on 'blink.cmp' internals).
                ["<C-Z>"] = { "accept", "fallback" },
            },

            -- Configure the appearance of the completion menu.
            appearance = {
                -- 'mono' (default): Use 'Nerd Font Mono' for better icon alignment.
                -- 'normal': Use 'Nerd Font'.
                nerd_font_variant = "mono",
            },

            -- Configuration for the completion documentation popup.
            completion = {
                -- (Default) Automatically show the documentation popup when a
                -- completion item is selected.
                documentation = { auto_show = true },
            },

            -- Configuration for signature help (displaying function/method parameters).
            signature = { enabled = true },

            -- Define the list of enabled completion sources and their providers.
            sources = {
                -- The 'default' group of sources. You can extend this list in other
                -- configuration files due to the 'opts_extend' setting below.
                default = {
                    "lsp",      -- Language Server Protocol completions.
                    "path",     -- File path completions.
                    "snippets", -- Completions from snippet engines (like friendly-snippets).
                    "buffer",   -- Completions from the current buffer.
                    "emoji",    -- Completions provided by 'blink-emoji.nvim'.
                    "sql",      -- Completions provided by 'cmp-sql' (via the compatibility layer).
                },
                -- Configuration for specific completion providers.
                providers = {
                    emoji = {
                        -- The Lua module that provides this source.
                        module = "blink-emoji",
                        -- The name to display for this source in the completion menu.
                        name = "Emoji",
                        -- Adjust the scoring offset to influence the order of emoji
                        -- suggestions. Higher values generally push the source higher.
                        score_offset = 15, -- Tune by preference
                        -- Options passed to the emoji completion source.
                        opts = { insert = true }, -- Insert the emoji character (default)
                                                 -- or complete its name (e.g., ":smile:").
                        -- Function to determine whether to show emoji completions
                        -- based on the current filetype.
                        should_show_items = function()
                            return vim.tbl_contains(
                                -- Enable emoji completion only for git commit messages and
                                -- Markdown files. By default (if this function is not
                                -- provided or returns true), it's enabled for all filetypes.
                                { "gitcommit", "markdown" },
                                vim.o.filetype
                            )
                        end,
                    },
                    sql = {
                        -- IMPORTANT: Use the same name as you would for nvim-cmp
                        -- if you were configuring it directly. This is how the
                        -- compatibility layer bridges the two completion engines.
                        name = "sql",
                        -- The Lua module that provides the compatibility layer for this source.
                        module = "blink.compat.source",

                        -- All 'blink.cmp' source configuration options work as normal here.
                        score_offset = -3,

                        -- This 'opts' table is passed directly to the proxied completion
                        -- source ('cmp-sql' in this case) as the `option` field in
                        -- nvim-cmp's source configuration.
                        --
                        -- This is NOT the same as the top-level 'opts' in this lazy.nvim
                        -- plugin specification.
                        opts = {},
                        -- Function to determine whether to show SQL completions based
                        -- on the current filetype.
                        should_show_items = function()
                            return vim.tbl_contains(
                                -- Enable SQL completion only for SQL files.
                                { "sql" },
                                vim.o.filetype
                            )
                        end,
                    },
                },
            },

            -- Configure the fuzzy matching algorithm.
            fuzzy = {
                -- (Default) Use the Rust-based fuzzy matcher for better performance
                -- and typo resistance.
                -- You can switch to a Lua implementation (`implementation = "lua"`)
                -- or prefer Rust but fallback to Lua if the Rust matcher is not
                -- available (`implementation = "prefer_rust"`).
                -- 'prefer_rust_with_warning' will use Rust if available and show a
                -- warning if it's not.
                implementation = "prefer_rust_with_warning",
            },
        },
        -- Extend the 'sources.default' list defined within the 'opts' table.
        -- This allows other plugin configurations to add or modify the default
        -- completion sources without completely overwriting them.
        opts_extend = { "sources.default" },
    },
}