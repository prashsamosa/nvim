return {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
  
          -- LSP navigation and information keymaps
          map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
          map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
          map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
          map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
          map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
          map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
          map("<leader>cr", vim.lsp.buf.rename, "[R]ename")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  
          -- Version-compatible method support check
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end
  
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          
          -- Document highlighting on cursor hold
          if client and client_supports_method(
              client,
              vim.lsp.protocol.Methods.textDocument_documentHighlight,
              event.buf
          ) then
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
  
          -- Inlay hints toggle
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>ih", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Toggle Inlay Hints")
          end
        end,
      })
  
      -- Diagnostic Configuration
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
  
      -- Setup LSP capabilities with blink.cmp
      local original_capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)
  
      -- Configure language servers
      local servers = {
        bashls = {},
        marksman = {},
        lua_ls = {},
        -- Add other servers as needed
      }
  
      -- Ensure tools are installed
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",    -- Lua formatter
        "prettierd", -- JavaScript/TypeScript formatter
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
  
      -- Setup Mason LSP configuration
      require("mason-lspconfig").setup({
        ensure_installed = {},
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