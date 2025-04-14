-- Configure the Language Server Protocol (LSP) client in Neovim.
-- Uses 'nvim-lspconfig' for server management and enhances the LSP experience.

return {
    -- Core LSP configuration plugin.
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Manages LSP servers and tools. Loaded before dependents.
        { "williamboman/mason.nvim", opts = {} },
        -- Bridges 'nvim-lspconfig' and 'mason.nvim' for easier LSP setup.
        "williamboman/mason-lspconfig.nvim",
        -- Manages other development tools (formatters, linters).
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- Provides LSP status updates and progress information.
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        -- ===== Brief Overview: Language Server Protocol (LSP) =====
        -- LSP standardizes communication between editors and language tooling (Language Servers).
        -- Language Servers (e.g., gopls, lua_ls, rust_analyzer) provide features like:
        -- - Go to definition, Find references, Autocompletion, Symbol Search, etc.
        -- 'nvim-lspconfig' is the LSP client in Neovim, and 'mason.nvim' helps install the servers.
        -- See `:help lsp-vs-treesitter` for the difference between LSP and Treesitter.

        -- Autocommand executed when an LSP attaches to a buffer.
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                -- Helper to create LSP key mappings for the current buffer.
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Navigation
                map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
                map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
                map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
                map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- Find Symbols
                map("<leader>dS", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
                map("<leader>wS", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

                -- Editing
                map("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

                -- Document Highlight (on CursorHold)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has("nvim-0.11") == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
                end

                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })
                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                        end,
                    })
                end

                -- Toggle Inlay Hints
                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })

        -- Configure diagnostic display.
        vim.diagnostic.config({
            severity_sort = true,
            float = { border = "rounded", source = "if_many" },
            underline = { severity = vim.diagnostic.severity.ERROR },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN] = "󰀪 ",
                    [vim.diagnostic.severity.INFO] = "󰋽 ",
                    [vim.diagnostic.severity.HINT] = "󰌶 ",
                },
            },
            virtual_text = {
                source = "if_many",
                spacing = 2,
                format = function(diagnostic)
                    return diagnostic.message
                end,
            },
        })

        -- Get LSP capabilities for 'blink.cmp'.
        local original_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

        -- Define language servers to enable (Mason will install if needed).
        local servers = {
            bashls = {},
            marksman = {},
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            -- rust_analyzer = {},
            -- ... (add other servers as needed)

            -- Lua Language Server configuration.
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim', 'require', 'Snacks' } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
                        telemetry = { enable = false },
                        -- completion = { callSnippet = 'Replace' }, -- Example completion setting
                    },
                },
            },

            -- Elixir Language Server configuration.
            elixirls = {
                settings = { dialyzerEnabled = false, enableTestLenses = false },
                filetypes = { "elixir", "ex", "exs", "heex", "eex" },
            },
        }

        -- Ensure specified servers and tools are installed.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, { "stylua", "prettierd", "elixirls" })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        -- Configure 'mason-lspconfig' to set up installed language servers.
        require("mason-lspconfig").setup({
            ensure_installed = {}, -- Installation handled by mason-tool-installer.
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}