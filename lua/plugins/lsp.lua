-- lua/plugins/lsp.lua - FIXED VERSION (Remove duplicate FZF keymaps)
return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "stylua",
                "prettierd",
                "shfmt",
                "goimports",
                "gofumpt",
                "black",
                "isort",
                "rustfmt",
                "eslint_d",
                "shellcheck",
                "markdownlint",
                "lua-language-server",
                "typescript-language-server",
                "gopls",
                "svelte-language-server",
                "pyright",
                "rust-analyzer",
                "tailwindcss-language-server",
                "json-lsp",
                "yaml-language-server",
                "bash-language-server",
                "eslint-lsp",
                "emmet-ls",
            },
            run_on_start = true,
            auto_update = false,
        },
    },

    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            progress = {
                ignore = { "Loading workspace", "Indexing", "Analyzing" },
            },
        },
    },

    { "b0o/schemastore.nvim", lazy = true },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                vim.env.VIMRUNTIME,
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                "LazyVim",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "j-hui/fidget.nvim",
            "b0o/schemastore.nvim",
            "folke/lazydev.nvim",
        },
        config = function()
            vim.diagnostic.config({
                severity_sort = true,
                underline = true,
                update_in_insert = false,
                virtual_text = true,
                virtual_lines = { current_line = true },
                float = {
                    border = "rounded",
                    source = true,
                    header = "",
                    prefix = "",
                    focusable = false,
                    max_width = 100,
                    wrap = true,
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚",
                        [vim.diagnostic.severity.WARN] = "󰀪",
                        [vim.diagnostic.severity.INFO] = "󰋽",
                        [vim.diagnostic.severity.HINT] = "󰌶",
                    },
                },
            })

            vim.opt.winborder = "rounded"

            vim.lsp.enable({
                "lua_ls",
                "ts_ls",
                "gopls",
                "svelte",
                "pyright",
                "rust_analyzer",
                "tailwindcss",
                "jsonls",
                "yamlls",
                "bashls",
                "eslint",
                "emmet_ls",
            })

            -- REMOVED: Duplicate FZF-lua keymaps (now in main keymaps.lua)
            -- This prevents conflicts and centralizes keymap management

            -- Only keep basic LSP attach notification
            local lsp_group = vim.api.nvim_create_augroup("LspConfig", { clear = true })
            vim.api.nvim_create_autocmd("LspAttach", {
                group = lsp_group,
                callback = function(ev)
                    -- Optional: Add any LSP-specific setup here that doesn't involve keymaps
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client then
                        vim.notify(
                            string.format("LSP attached: %s", client.name),
                            vim.log.levels.INFO,
                            { title = "LSP" }
                        )
                    end
                end,
            })
        end,
    },
}
