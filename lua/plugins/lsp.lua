-- Configure Language Server Protocol (LSP) for enhanced development features.
-- This setup uses nvim-lspconfig for core LSP functionality, mason.nvim for LSP server management,
-- and other utilities for a better LSP experience.

return {
  -- Main LSP Configuration
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim.
    -- Mason must be loaded before its dependents. `opts = {}` is the same as calling `require('mason').setup({})`.
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    -- **What is LSP?**
    -- Language Server Protocol (LSP) is a standardized communication protocol between
    -- code editors/IDEs and language servers. Language servers provide language-specific
    -- features like autocompletion, error checking (diagnostics), go-to-definition,
    -- find-references, etc. This allows Neovim to offer rich editing support for
    -- various programming languages.

    -- This function gets run when an LSP attaches to a particular buffer.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        -- Helper function for mapping LSP keybindings.
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Key mappings for LSP functionality (using built-in commands).
        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
        map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
        map("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")
        map("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Document Highlight (when cursor is held).
        local client_supports_method = function(client, method, bufnr)
          if vim.fn.has("nvim-0.11") == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        if client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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

        -- Toggle Inlay Hints (if supported).
        if client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    -- Diagnostic Configuration.
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

    -- LSP Server Configuration using lspconfig.
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- If you are using nvim-cmp for autocompletion, you need to pass its capabilities
    -- to ensure proper integration with LSP features.
    -- capabilities = require('cmp_nvim_lsp').default_capabilities()

    local servers = {
      bashls = {},
      marksman = {},
      -- Add more servers as needed, for example:
      -- lua_ls = {
      --   settings = {
      --     Lua = {
      --       completion = { callSnippet = 'Replace' },
      --     },
      --   },
      -- },
      -- pyright = {},
      -- rust_analyzer = {},
      -- tsserver = {},
    }

    for server_name, config in pairs(servers) do
      lspconfig[server_name].setup {
        capabilities = capabilities,
        -- Add server-specific configurations here. For example, to disable formatting
        -- for bashls:
        -- flags = {
        --   debounce_text_changes = 150,
        -- },
        settings = config.settings,
      }
    end

    -- Setup Mason to manage Language Servers.
    require("mason").setup()

    -- Setup mason-lspconfig to configure LSP servers installed by Mason.
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers), -- Ensure the listed servers are installed.
      automatic_installation = true,           -- Automatically install missing servers.
    })

    -- Setup Mason Tool Installer for formatters and linters (optional).
    require("mason-tool-installer").setup({
      ensure_installed = { "stylua", "prettierd" }, -- Example formatters to ensure are installed.
    })
  end,
}