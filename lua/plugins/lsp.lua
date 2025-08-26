-- lua/plugins/lsp.lua - FIXED VERSION
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
                -- Formatters
                "stylua",
                "prettierd",
                "shfmt",
                "goimports",
                "gofumpt",
                "black",
                "isort",
                "rustfmt",

                -- Linters
                "eslint_d",
                "shellcheck",
                "markdownlint",

                -- Language Servers
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
                "emmet-language-server", -- Fixed: updated name
            },
            run_on_start = true,
            auto_update = false,
            debounce_hours = 5,
        },
    },

    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            progress = {
                ignore = { "Loading workspace", "Indexing", "Analyzing" },
                display = {
                    render_limit = 16,
                    done_ttl = 3,
                    done_icon = "✓",
                    done_style = "Constant",
                    progress_icon = { pattern = "dots", period = 1 },
                },
            },
            notification = {
                window = {
                    normal_hl = "Comment",
                    winblend = 100,
                    border = "none",
                    zindex = 45,
                    max_width = 0,
                    max_height = 0,
                    x_padding = 1,
                    y_padding = 0,
                    align = "bottom",
                    relative = "editor",
                },
            },
        },
    },

    { "b0o/schemastore.nvim", lazy = true },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
                { path = "LazyVim",            words = { "LazyVim" } },
            },
        },
    },

    -- Add this for better Lua LSP support
    { "Bilal2453/luvit-meta", lazy = true },

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
            -- Configure diagnostics
            vim.diagnostic.config({
                severity_sort = true,
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                float = {
                    border = "rounded",
                    source = "if_many",
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

            -- Configure LSP handlers
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded",
            })

            local lspconfig = require("lspconfig")

            -- Get blink.cmp capabilities if available
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local blink_ok, blink = pcall(require, "blink.cmp")
            if blink_ok then
                capabilities = blink.get_lsp_capabilities(capabilities)
            end

            -- Configure specific servers
            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.stdpath("config") .. "/lua"] = true,
                                },
                            },
                        },
                    },
                },

                ts_ls = {
                    init_options = {
                        preferences = {
                            disableSuggestions = true,
                        },
                    },
                },

                gopls = {
                    settings = {
                        gopls = {
                            gofumpt = true,
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = true,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                                vendor = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            analyses = {
                                fieldalignment = true,
                                nilness = true,
                                unusedparams = true,
                                unusedwrite = true,
                                useany = true,
                            },
                            usePlaceholders = true,
                            completeUnimported = true,
                            staticcheck = true,
                            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                            semanticTokens = true,
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
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                runBuildScripts = true,
                            },
                            checkOnSave = {
                                allFeatures = true,
                                command = "clippy",
                                extraArgs = { "--no-deps" },
                            },
                            procMacro = {
                                enable = true,
                                ignored = {
                                    ["async-trait"] = { "async_trait" },
                                    ["napi-derive"] = { "napi" },
                                    ["async-recursion"] = { "async_recursion" },
                                },
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
                            schemaStore = {
                                enable = false,
                                url = "",
                            },
                            schemas = require("schemastore").yaml.schemas(),
                        },
                    },
                },

                tailwindcss = {},
                svelte = {},
                bashls = {},
                eslint = {},
                emmet_language_server = {
                    filetypes = {
                        "css",
                        "eruby",
                        "html",
                        "javascript",
                        "javascriptreact",
                        "less",
                        "sass",
                        "scss",
                        "svelte",
                        "pug",
                        "typescriptreact",
                        "vue",
                    },
                },
            }

            -- Setup servers
            for server_name, config in pairs(servers) do
                config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
                lspconfig[server_name].setup(config)
            end

            -- LSP attach autocmd for notifications
            local lsp_group = vim.api.nvim_create_augroup("LspConfig", { clear = true })
            vim.api.nvim_create_autocmd("LspAttach", {
                group = lsp_group,
                callback = function(ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client then
                        -- Enable inlay hints if supported
                        if vim.lsp.inlay_hint then
                            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                        end

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
