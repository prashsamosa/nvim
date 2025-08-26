return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = { ui = { border = "rounded" } },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = "williamboman/mason.nvim",
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                "lua-language-server", "typescript-language-server", "gopls", "pyright",
                "rust-analyzer", "tailwindcss-language-server", "json-lsp", "yaml-language-server",
                "bash-language-server", "emmet-language-server", "stylua", "prettierd",
                "shfmt", "goimports", "gofumpt", "black", "isort", "eslint_d", "shellcheck",
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
                display = { done_ttl = 3, progress_icon = { pattern = "dots", period = 1 } },
            },
            notification = { window = { winblend = 100, border = "none" } },
        },
    },

    { "b0o/schemastore.nvim", lazy = true },
    { "folke/lazydev.nvim",   ft = "lua", opts = {} },

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
            -- Neovim 0.11: Virtual text is now opt-in, explicitly enable it
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
                float = { border = "rounded", source = true },
            })

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
                { border = "rounded" })

            local lspconfig = require("lspconfig")
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            -- Enhanced capabilities for better LSP experience
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.textDocument.completion.completionItem.resolveSupport = {
                properties = { "documentation", "detail", "additionalTextEdits" }
            }

            -- Check if blink.cmp is available for enhanced capabilities
            local ok, blink = pcall(require, "blink.cmp")
            if ok then
                capabilities = blink.get_lsp_capabilities(capabilities)
            end

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = { callSnippet = "Replace" },
                            diagnostics = { globals = { "vim" } },
                            workspace = { checkThirdParty = false },
                            hint = { enable = true }, -- Enable inlay hints
                        },
                    },
                },
                ts_ls = {
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                    },
                },
                gopls = {
                    settings = {
                        gopls = {
                            gofumpt = true,
                            staticcheck = true,
                            usePlaceholders = true,
                            completeUnimported = true,
                            codelenses = { generate = true, test = true, tidy = true },
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
                                typeCheckingMode = "basic",
                                autoImportCompletions = true,
                                inlayHints = {
                                    variableTypes = true,
                                    functionReturnTypes = true,
                                },
                            },
                        },
                    },
                },
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = { allFeatures = true },
                            checkOnSave = { command = "clippy" },
                            inlayHints = {
                                bindingModeHints = { enable = false },
                                chainingHints = { enable = true },
                                closingBraceHints = { enable = true, minLines = 25 },
                                closureReturnTypeHints = { enable = "never" },
                                lifetimeElisionHints = { enable = "never", useParameterNames = false },
                                maxLength = 25,
                                parameterHints = { enable = true },
                                reborrowHints = { enable = "never" },
                                renderColons = true,
                                typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
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
                    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
                },
            }

            for name, config in pairs(servers) do
                config.capabilities = capabilities
                lspconfig[name].setup(config)
            end

            -- Enhanced LSP attach autocmd
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
                callback = function(ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client and client.supports_method("textDocument/inlayHint") then
                        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                    end

                    -- Enable completion triggered by <c-x><c-o> for builtin completion
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Set up buffer-local keymaps only once per buffer
                    local opts = { buffer = ev.buf, silent = true }

                    -- Only set up LSP mappings if they haven't been set already
                    if not vim.b.lsp_keymaps_set then
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition,
                            vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
                        vim.keymap.set("n", "gr", vim.lsp.buf.references,
                            vim.tbl_extend("force", opts, { desc = "References" }))
                        vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
                            vim.tbl_extend("force", opts, { desc = "Go to Implementation" }))
                        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition,
                            vim.tbl_extend("force", opts, { desc = "Type Definition" }))
                        vim.keymap.set("n", "K", vim.lsp.buf.hover,
                            vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
                        vim.keymap.set("n", "gK", vim.lsp.buf.signature_help,
                            vim.tbl_extend("force", opts, { desc = "Signature Help" }))
                        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help,
                            vim.tbl_extend("force", opts, { desc = "Signature Help" }))
                        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
                            vim.tbl_extend("force", opts, { desc = "Code Action" }))
                        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename,
                            vim.tbl_extend("force", opts, { desc = "Rename Symbol" }))

                        if client and client.supports_method("textDocument/inlayHint") then
                            vim.keymap.set("n", "<leader>lh", function()
                                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
                                    { bufnr = ev.buf })
                            end, vim.tbl_extend("force", opts, { desc = "Toggle Inlay Hints" }))
                        end

                        vim.b.lsp_keymaps_set = true
                    end
                end,
            })
        end,
    },
}
