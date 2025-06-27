return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim", opts = {} },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "j-hui/fidget.nvim",       opts = {} },
        { "b0o/schemastore.nvim" },
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
    },
    config = function()
        -- Disable intrusive progress notifications
        vim.lsp.handlers["$/progress"] = function(_, result, ctx)
            local client = vim.lsp.get_clients({ id = ctx.client_id })[1]
            if not client then return end

            -- Only show critical progress, hide workspace loading spam
            if result.value and result.value.message then
                local msg = result.value.message
                if msg:match("Loading workspace") or msg:match("Indexing") or msg:match("Analyzing") then
                    return -- Skip these notifications
                end
            end
        end

        -- Helper function for keymaps
        local function map(keys, fn, desc, mode, buf)
            vim.keymap.set(mode or "n", keys, fn, {
                buffer = buf,
                desc = "LSP: " .. desc,
                silent = true,
            })
        end

        -- LSP attach autocmd
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local buf = event.buf
                local client = vim.lsp.get_clients({ id = event.data.client_id })[1]
                if not client then return end

                -- Use fzf-lua if available, fallback to built-in
                local has_fzf, fzf = pcall(require, "fzf-lua")

                if has_fzf then
                    map("gd", fzf.lsp_definitions, "Go to Definition", "n", buf)
                    map("gr", fzf.lsp_references, "Go to References", "n", buf)
                    map("gI", fzf.lsp_implementations, "Go to Implementation", "n", buf)
                    map("<leader>td", fzf.lsp_typedefs, "Type Definition", "n", buf)
                    map("<leader>ds", fzf.lsp_document_symbols, "Document Symbols", "n", buf)
                    map("<leader>ws", fzf.lsp_live_workspace_symbols, "Workspace Symbols", "n", buf)
                else
                    map("gd", vim.lsp.buf.definition, "Go to Definition", "n", buf)
                    map("gr", vim.lsp.buf.references, "Go to References", "n", buf)
                    map("gI", vim.lsp.buf.implementation, "Go to Implementation", "n", buf)
                    map("<leader>td", vim.lsp.buf.type_definition, "Type Definition", "n", buf)
                end

                -- Core LSP mappings
                map("gD", vim.lsp.buf.declaration, "Go to Declaration", "n", buf)
                map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" }, buf)
                map("<leader>cr", vim.lsp.buf.rename, "Rename", "n", buf)
                map("K", vim.lsp.buf.hover, "Hover", "n", buf)
                map("<C-k>", vim.lsp.buf.signature_help, "Signature Help", "i", buf)

                -- Disable LSP formatting (handled by conform.nvim)
                if client.server_capabilities then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end

                -- Document highlighting
                if client.server_capabilities.documentHighlightProvider then
                    local group = vim.api.nvim_create_augroup("lsp-highlight-" .. buf, { clear = true })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = buf,
                        group = group,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = buf,
                        group = group,
                        callback = vim.lsp.buf.clear_references,
                    })
                end

                -- Inlay hints toggle
                if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                    map("<leader>ih", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
                    end, "Toggle Inlay Hints", "n", buf)
                end

                -- Code lens
                if client.server_capabilities.codeLensProvider then
                    local refresh_codelens = function()
                        pcall(vim.lsp.codelens.refresh, { bufnr = buf })
                    end

                    refresh_codelens()
                    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                        buffer = buf,
                        callback = refresh_codelens,
                    })
                    map("<leader>cl", vim.lsp.codelens.run, "Run Code Lens", "n", buf)
                end
            end,
        })

        -- Enhanced diagnostics configuration
        vim.diagnostic.config({
            severity_sort = true,
            underline = true,
            update_in_insert = false,
            virtual_text = {
                source = "if_many",
                spacing = 2,
                prefix = "●",
                format = function(d)
                    return #d.message > 60 and (d.message:sub(1, 57) .. "...") or d.message
                end,
            },
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

        -- Diagnostic keymaps
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1 })
        end, { desc = "LSP: Previous diagnostic" })

        vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = 1 })
        end, { desc = "LSP: Next diagnostic" })

        vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "LSP: Diagnostic loclist" })
        vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "LSP: Diagnostic quickfix" })
        vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "LSP: Show diagnostic" })

        -- Get LSP capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" },
        }

        -- Setup completion capabilities
        local has_blink, blink = pcall(require, "blink.cmp")
        if has_blink then
            capabilities = blink.get_lsp_capabilities(capabilities)
        elseif package.loaded["cmp_nvim_lsp"] then
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        end

        -- Server configurations
        local servers = {
            -- Lua
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            maxPreload = 100,
                            preloadFileSize = 1000,
                            ignoreDir = {
                                ".git",
                                "node_modules",
                                ".vscode",
                                "target",
                                "build",
                                "dist",
                            },
                            library = {
                                vim.env.VIMRUNTIME,
                                "${3rd}/luv/library",
                            },
                        },
                        diagnostics = {
                            globals = { "vim", "Snacks", "require", "pcall", "pairs", "ipairs" },
                            disable = { "missing-fields", "incomplete-signature-doc" },
                        },
                        completion = { callSnippet = "Replace" },
                        hint = { enable = true },
                        telemetry = { enable = false },
                        format = { enable = false },
                    },
                },
            },

            -- TypeScript/JavaScript
            ts_ls = {
                init_options = {
                    preferences = {
                        disableSuggestions = true,
                    },
                },
                settings = {
                    typescript = {
                        format = { enable = false },
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
                    javascript = {
                        format = { enable = false },
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

            -- Go
            gopls = {
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                            nilness = true,
                            unusedwrite = true,
                            useany = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                        codelenses = {
                            generate = true,
                            test = true,
                            tidy = true,
                            upgrade_dependency = true,
                        },
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            constantValues = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                        usePlaceholders = true,
                        completeUnimported = true,
                        matcher = "Fuzzy",
                        semanticTokens = true,
                        directoryFilters = {
                            "-.git",
                            "-node_modules",
                            "-vendor",
                        },
                    },
                },
            },

            -- Svelte
            svelte = {
                settings = {
                    svelte = {
                        plugin = {
                            html = { completions = { enable = true, emmet = false } },
                            svelte = { completions = { enable = true, emmet = false } },
                            css = { completions = { enable = true, emmet = true } },
                        },
                    },
                },
            },

            -- Python
            pyright = {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            autoImportCompletions = true,
                            stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
                        },
                    },
                },
            },

            -- Rust
            rust_analyzer = {
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        checkOnSave = { command = "clippy" },
                        procMacro = { enable = true },
                        diagnostics = { disabled = { "unresolved-proc-macro" } },
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
                            typeHints = {
                                enable = true,
                                hideClosureInitialization = false,
                                hideNamedConstructor = false,
                            },
                        },
                    },
                },
            },

            -- Tailwind CSS
            tailwindcss = {
                settings = {
                    tailwindCSS = {
                        experimental = {
                            classRegex = {
                                "tw`([^`]*)",
                                'tw="([^"]*)',
                                'tw={"([^"}]*)',
                                "tw\\.\\w+`([^`]*)",
                                "tw\\(.*?\\)`([^`]*)",
                            },
                        },
                    },
                },
            },

            -- JSON/YAML
            jsonls = {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                        format = { enable = false },
                    },
                },
            },

            yamlls = {
                settings = {
                    yaml = {
                        schemaStore = { enable = false, url = "" },
                        schemas = require("schemastore").yaml.schemas(),
                        format = { enable = false },
                        validate = true,
                        hover = true,
                        completion = true,
                    },
                },
            },

            -- Shell
            bashls = {
                settings = {
                    bashIde = {
                        globPattern = "*@(.sh|.inc|.bash|.command)",
                    },
                },
            },

            -- ESLint
            eslint = {
                settings = {
                    codeAction = {
                        disableRuleComment = {
                            enable = true,
                            location = "separateLine",
                        },
                        showDocumentation = {
                            enable = true,
                        },
                    },
                    codeActionOnSave = {
                        enable = false,
                        mode = "all",
                    },
                    format = false,
                    nodePath = "",
                    onIgnoredFiles = "off",
                    packageManager = "npm",
                    quiet = false,
                    rulesCustomizations = {},
                    run = "onType",
                    useESLintClass = false,
                    validate = "on",
                    workingDirectory = { mode = "location" },
                },
            },

            -- Emmet
            emmet_ls = {
                filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue" },
                settings = {},
            },
        }

        -- Tools to ensure are installed
        local ensure_installed = vim.tbl_keys(servers)
        vim.list_extend(ensure_installed, {
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
        })

        -- Setup mason-tool-installer
        require("mason-tool-installer").setup({
            ensure_installed = ensure_installed,
            auto_update = false,
            run_on_start = true,
        })

        -- Setup mason-lspconfig
        ---@diagnostic disable-next-line: missing-fields
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
            handlers = {
                function(server_name)
                    local config = servers[server_name] or {}
                    config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
                    require("lspconfig")[server_name].setup(config)
                end,
            },
        })

        -- Additional LSP configurations that don't use Mason
        local additional_servers = {}

        for server_name, config in pairs(additional_servers) do
            config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
            require("lspconfig")[server_name].setup(config)
        end
    end,
}
