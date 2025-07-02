return {
    -- Keep Mason for tool installation
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },

    -- Mason tool installer for formatters and linters
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
                -- LSP servers (fallback for non-builtin setup)
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
            auto_update = false,
            run_on_start = true,
        }
    },

    -- Keep essential LSP plugins
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            notification = {
                window = {
                    winblend = 0,
                },
            },
        },
    },

    {
        "b0o/schemastore.nvim",
        lazy = true,
    },

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

    -- Main LSP configuration using Neovim 0.11 APIs
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
            -- Disable intrusive progress notifications
            vim.lsp.handlers["$/progress"] = function(_, result, ctx)
                local client = vim.lsp.get_clients({ id = ctx.client_id })[1]
                if not client then return end

                if result.value and result.value.message then
                    local msg = result.value.message
                    if msg:match("Loading workspace") or msg:match("Indexing") or msg:match("Analyzing") then
                        return
                    end
                end
            end

            -- Enhanced diagnostics configuration (0.11 style)
            vim.diagnostic.config({
                severity_sort = true,
                underline = true,
                update_in_insert = false,
                -- Virtual text is now opt-in in 0.11
                virtual_text = {
                    source = "if_many",
                    spacing = 2,
                    prefix = "●",
                    format = function(d)
                        return #d.message > 60 and (d.message:sub(1, 57) .. "...") or d.message
                    end,
                },
                -- Enable new virtual lines feature
                virtual_lines = {
                    current_line = true, -- Only show for current line
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

            -- Set window border for LSP floating windows
            vim.o.winborder = 'rounded'

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

                    -- Custom keymaps (will not override 0.11 defaults)
                    if has_fzf then
                        map("gd", fzf.lsp_definitions, "Go to Definition", "n", buf)
                        map("gr", fzf.lsp_references, "Go to References", "n", buf)
                        map("gI", fzf.lsp_implementations, "Go to Implementation", "n", buf)
                        map("<leader>td", fzf.lsp_typedefs, "Type Definition", "n", buf)
                        map("<leader>ds", fzf.lsp_document_symbols, "Document Symbols", "n", buf)
                        map("<leader>ws", fzf.lsp_live_workspace_symbols, "Workspace Symbols", "n", buf)
                    end

                    -- Additional custom mappings
                    map("gD", vim.lsp.buf.declaration, "Go to Declaration", "n", buf)
                    map("K", vim.lsp.buf.hover, "Hover", "n", buf)

                    -- Enable built-in auto-completion
                    if client.supports_method('textDocument/completion') then
                        vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
                    end

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

            -- Custom diagnostic keymaps (supplement the new defaults)
            vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "LSP: Diagnostic loclist" })
            vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "LSP: Diagnostic quickfix" })
            vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "LSP: Show diagnostic" })

            -- Setup LSP servers using new 0.11 APIs
            -- This will scan for config files in ~/.config/nvim/lsp/
            vim.lsp.enable({
                'lua_ls',
                'ts_ls',
                'gopls',
                'svelte',
                'pyright',
                'rust_analyzer',
                'tailwindcss',
                'jsonls',
                'yamlls',
                'bashls',
                'eslint',
                'emmet_ls'
            })
        end,
    },
}
