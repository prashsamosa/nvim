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

            local lsp_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })
            vim.api.nvim_create_autocmd("LspAttach", {
                group = lsp_group,
                callback = function(ev)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
                    end

                    map("<leader>fgd", function() require("fzf-lua").lsp_definitions() end, "Go to Definition (FZF)")
                    map("<leader>fgr", function() require("fzf-lua").lsp_references() end, "Go to References (FZF)")
                    map("<leader>fgi", function() require("fzf-lua").lsp_implementations() end,
                        "Go to Implementation (FZF)")
                    map("<leader>fgt", function() require("fzf-lua").lsp_typedefs() end, "Type Definition (FZF)")
                    map("<leader>fds", function() require("fzf-lua").lsp_document_symbols() end, "Document Symbols (FZF)")
                    map("<leader>fws", function() require("fzf-lua").lsp_workspace_symbols() end,
                        "Workspace Symbols (FZF)")

                    map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
                    map("gd", vim.lsp.buf.definition, "Go to Definition")
                end,
            })
        end,
    },
}
