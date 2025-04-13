-- This file configures the Language Server Protocol (LSP) client in Neovim
-- using 'nvim-lspconfig', along with related plugins for managing and
-- enhancing the LSP experience.

return {
    -- Main LSP Configuration plugin. Provides the framework for configuring
    -- and managing language server connections.
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically installs LSP servers and related tools to Neovim's
        -- standard path. Mason must be loaded before its dependents.
        -- `opts = {}` is equivalent to `require('mason').setup({})`, using
        -- the default configuration for Mason.
        { "williamboman/mason.nvim", opts = {} },
        -- Bridges 'nvim-lspconfig' and 'mason.nvim', making it easier to
        -- configure and install LSP servers.
        "williamboman/mason-lspconfig.nvim",
        -- Installs and manages other development tools (like formatters, linters)
        -- that LSP servers might depend on or recommend.
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- Provides useful status updates and progress information during LSP
        -- operations (e.g., initialization, formatting).
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        -- ===== Brief Aside: What is LSP? =====
        --
        -- LSP stands for Language Server Protocol. It's a protocol that allows
        -- editors and language tooling to communicate in a standardized way.
        --
        -- A "server" (Language Server) is a standalone tool built to understand
        -- a specific language (e.g., `gopls` for Go, `lua_ls` for Lua,
        -- `rust_analyzer` for Rust). These servers communicate with a "client"
        -- (in this case, Neovim) to provide features like:
        --  - Go to definition
        --  - Find references
        --  - Autocompletion
        --  - Symbol Search
        --  - and more!
        --
        -- Language Servers are external tools that need to be installed
        -- separately. This is where `mason` and related plugins come in.
        --
        -- For the difference between LSP and Treesitter, see `:help lsp-vs-treesitter`.

        -- This autocommand is executed every time an LSP attaches to a buffer
        -- (i.e., when you open a file type that has an associated LSP server).
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                -- Helper function to create LSP-related key mappings for the current buffer.
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Jump to the definition of the word under the cursor (<C-]> by default).
                -- To jump back, press <C-t>.
                map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")

                -- Find references for the word under the cursor.
                map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under the cursor.
                map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")

                -- Jump to the type definition of the word under the cursor.
                map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")

                -- Fuzzy find all symbols in the current document.
                map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")

                -- Fuzzy find all symbols in the current workspace (project).
                map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

                -- Rename the variable under the cursor.
                map("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")

                -- Execute a code action (e.g., quick fixes). Cursor needs to be on
                -- an error or suggestion.
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

                -- Goto declaration (often goes to the header file in C/C++).
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- Helper function to check if a client supports a specific method.
                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has("nvim-0.11") == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
                end

                -- Highlight references of the word under the cursor when the cursor
                -- rests there (CursorHold) and clear them when the cursor moves.
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if
                    client
                    and client_supports_method(
                        client,
                        vim.lsp.protocol.Methods.textDocument_documentHighlight,
                        event.buf
                    )
                then
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

                    -- Clear references when the LSP detaches from the buffer.
                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                        end,
                    })
                end

                -- Toggle inlay hints (if supported by the language server).
                if
                    client
                    and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })

        -- Configure diagnostic display (errors, warnings, hints).
        vim.diagnostic.config({
            severity_sort = true, -- Sort diagnostics by severity.
            float = { border = "rounded", source = "if_many" }, -- Floating window options.
            underline = { severity = vim.diagnostic.severity.ERROR }, -- Underline errors.
            signs = { -- Configure signs in the sign column.
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN] = "󰀪 ",
                    [vim.diagnostic.severity.INFO] = "󰋽 ",
                    [vim.diagnostic.severity.HINT] = "󰌶 ",
                },
            },
            virtual_text = { -- Configure virtual text display of diagnostics.
                source = "if_many",
                spacing = 2,
                format = function(diagnostic)
                    local diagnostic_message = {
                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                    }
                    return diagnostic_message[diagnostic.severity]
                end,
            },
        })

        -- Get default LSP client capabilities and extend them with capabilities
        -- needed for 'blink.cmp' (completion plugin).
        local original_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)
        -- You might have other completion plugins; this line shows how to merge
        -- their capabilities as well (commented out here).
        -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        -- Define the language servers to enable. Mason will automatically
        -- try to install these if they are not already present.
        local servers = {
            bashls = {},
            marksman = {},
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            -- rust_analyzer = {},
            -- ... etc. See `:help lspconfig-all` for a full list.

            -- Configuration for the Lua language server.
            lua_ls = {
                -- Add settings specific to lua_ls here
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' }, -- Adjust if needed (e.g., 'Lua 5.1')
                        diagnostics = {
                            -- Add "Snacks" to the list of recognized globals
                            globals = { 'vim', 'require', 'Snacks' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            -- You might want to add your config directory to the library path
                            -- library = vim.list_extend(vim.api.nvim_get_runtime_file("", true), {
                            --   vim.fn.expand("~/.config/nvim/lua"),
                            -- }),
                            checkThirdParty = false, -- Avoid warnings for plugins not explicitly in workspace
                        },
                        telemetry = { enable = false },
                        -- You can add other lua_ls settings here, like:
                        -- completion = { callSnippet = 'Replace' },
                    },
                },
            },
        }

        -- Ensure the defined servers and tools are installed using Mason.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua",    -- Lua code formatter.
            "prettierd", -- JavaScript/TypeScript formatter (daemon for speed).
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        -- Setup 'mason-lspconfig' to handle the configuration of the installed
        -- language servers.
        require("mason-lspconfig").setup({
            ensure_installed = {}, -- Explicitly empty, as tool installation is handled by mason-tool-installer.
            automatic_installation = false, -- Prevent automatic installation by mason-lspconfig.
            handlers = {
                -- This function is called for each language server that Mason
                -- installs. It sets up the server using 'lspconfig'.
                function(server_name)
                    local server = servers[server_name] or {}
                    -- Merge default capabilities with server-specific capabilities,
                    -- allowing overrides from the `servers` table.
                    -- This line correctly includes the 'settings' defined above.
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    -- Call the setup function for the specific LSP server from 'lspconfig'.
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}