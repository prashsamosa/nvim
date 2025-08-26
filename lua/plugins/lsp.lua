-- lua/plugins/lsp.lua - Neovim 0.11 Native LSP

return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {
            ui = { border = "rounded" },
        },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                -- Language Servers
                "lua-language-server",
                "typescript-language-server",
                "gopls",
                "pyright",
                "rust-analyzer",
                "tailwindcss-language-server",
                "json-lsp",
                "yaml-language-server",
                "bash-language-server",
                "emmet-language-server",

                -- Formatters
                "stylua",
                "prettierd",
                "shfmt",
                "goimports",
                "gofumpt",
                "black",
                "isort",

                -- Linters
                "eslint_d",
                "shellcheck",
            },
            auto_update = false,
            run_on_start = true,
        },
    },

    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            progress = {
                display = {
                    done_ttl = 3,
                    progress_icon = { pattern = "dots", period = 1 },
                },
            },
            notification = {
                window = {
                    winblend = 100,
                    border = "none",
                },
            },
        },
    },

    -- Optional dependencies for enhanced functionality
    { "b0o/schemastore.nvim", lazy = true },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },

    -- Native LSP configuration
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
            -- Neovim 0.11 simplified diagnostics
            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚",
                        [vim.diagnostic.severity.WARN] = "󰀪",
                        [vim.diagnostic.severity.INFO] = "󰋽",
                        [vim.diagnostic.severity.HINT] = "󰌶",
                    },
                },
                float = {
                    border = "rounded",
                    source = true,
                },
            })

            -- LSP handlers
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, { border = "rounded" }
            )
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help, { border = "rounded" }
            )

            local lspconfig = require("lspconfig")

            -- Get capabilities from blink.cmp if available
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local ok, blink = pcall(require, "blink.cmp")
            if ok then
                capabilities = blink.get_lsp_capabilities(capabilities)
            end

            -- Server configurations
            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = { callSnippet = "Replace" },
                            diagnostics = { globals = { "vim" } },
                            workspace = { checkThirdParty = false },
                        },
                    },
                },

                ts_ls = {
                    init_options = {
                        preferences = { disableSuggestions = true },
                    },
                },

                gopls = {
                    settings = {
                        gopls = {
                            gofumpt = true,
                            staticcheck = true,
                            usePlaceholders = true,
                            completeUnimported = true,
                            codelenses = {
                                generate = true,
                                test = true,
                                tidy = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                constantValues = true,
                                parameterNames = true,
                            },
                        },
                    },
                },

                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = "openFilesOnly",
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                },

                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = { allFeatures = true },
                            checkOnSave = {
                                command = "clippy",
                                extraArgs = { "--no-deps" },
                            },
                        },
                    },
                },

                jsonls = {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },

                yamlls = {
                    settings = {
                        yaml = {
                            schemaStore = { enable = false, url = "" },
                            schemas = require("schemastore").yaml.schemas(),
                        },
                    },
                },

                tailwindcss = {},
                bashls = {},
                emmet_language_server = {
                    filetypes = {
                        "html", "css", "scss", "javascript", "javascriptreact",
                        "typescript", "typescriptreact", "vue", "svelte"
                    },
                },
            }

            -- Setup servers
            for name, config in pairs(servers) do
                config.capabilities = capabilities
                lspconfig[name].setup(config)
            end

            -- LSP attach configuration
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
                callback = function(ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    -- Enable inlay hints if supported (Neovim 0.11+)
                    if client and client.supports_method("textDocument/inlayHint") then
                        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                    end

                    -- Setup buffer-local keymaps (defined in keymaps.lua via LspAttach autocmd)
                end,
            })
        end,
    },
}
