return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    -- Helper function to safely require schemastore
    local function get_schemas(type)
      local ok, schemastore = pcall(require, "schemastore")
      if not ok then
        return {}
      end
      return schemastore[type].schemas()
    end

    -- LSP attach autocmd
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, fn, desc, mode)
          vim.keymap.set(mode or "n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Navigation
        map("gd", require("fzf-lua").lsp_definitions, "Go to Definition")
        map("gr", require("fzf-lua").lsp_references, "Go to References")
        map("gI", require("fzf-lua").lsp_implementations, "Go to Implementation")
        map("gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("<leader>D", require("fzf-lua").lsp_typedefs, "Type Definition")

        -- Symbols
        map("<leader>ds", require("fzf-lua").lsp_document_symbols, "Document Symbols")
        map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "Workspace Symbols")

        -- Code actions
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("<leader>cr", vim.lsp.buf.rename, "Rename")

        -- Documentation
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<C-k>", vim.lsp.buf.signature_help, "Signature Help", "i")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        -- Check if client supports method (compatible with both 0.10 and 0.11)
        local supports = function(method)
          if vim.fn.has("nvim-0.11") == 1 then
            return client:supports_method(method, event.buf)
          else
            return client.supports_method(method, { bufnr = event.buf })
          end
        end

        -- Document highlighting
        if supports(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_group = vim.api.nvim_create_augroup("lsp-highlight-" .. event.buf, { clear = true })

          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach-" .. event.buf, { clear = true }),
            callback = function(ev)
              if ev.buf == event.buf then
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = highlight_group })
              end
            end,
          })
        end

        -- Inlay hints
        if supports(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("<leader>ih", function()
            if vim.fn.has("nvim-0.10") == 1 then
              local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
              vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
            end
          end, "Toggle Inlay Hints")
        end

        -- Code lens
        if supports(vim.lsp.protocol.Methods.textDocument_codeLens) then
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = event.buf,
            callback = vim.lsp.codelens.refresh,
          })
          map("<leader>cl", vim.lsp.codelens.run, "Run Code Lens")
        end
      end,
    })

    -- Diagnostic configuration
    vim.diagnostic.config({
      severity_sort = true,
      underline = true,
      update_in_insert = false,
      virtual_text = {
        source = "if_many",
        spacing = 2,
        prefix = "●",
        format = function(diagnostic)
          local max_width = 60
          if #diagnostic.message > max_width then
            return diagnostic.message:sub(1, max_width) .. "..."
          end
          return diagnostic.message
        end,
      },
      float = {
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
        focusable = false,
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
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })
    vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Open diagnostic quickfix" })

    -- Get capabilities
    local base_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = base_capabilities

    -- Integrate with completion
    if package.loaded["blink.cmp"] then
      capabilities = require("blink.cmp").get_lsp_capabilities(base_capabilities)
    end

    -- Server configurations
    local servers = {
      bashls = {
        filetypes = { "sh", "bash" },
      },

      marksman = {
        filetypes = { "markdown", "md" },
      },

      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
              },
            },
            completion = { callSnippet = "Replace" },
            diagnostics = {
              globals = { "vim", "Snacks" },
              disable = { "missing-fields" },
            },
            hint = { enable = true },
            telemetry = { enable = false },
          },
        },
      },

      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
        },
      },

      -- Go LSP is handled by go.nvim, but we include basic config as fallback
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
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
            usePlaceholders = true,
          },
        },
      },

      -- JSON
      jsonls = {
        settings = {
          json = {
            schemas = get_schemas("json"),
            validate = { enable = true },
          },
        },
      },

      -- YAML
      yamlls = {
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = get_schemas("yaml"),
          },
        },
      },
    }

    -- Ensure installed tools
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, {
      "stylua",      -- Lua formatter
      "prettierd",   -- Multi-language formatter
      "shfmt",       -- Shell formatter
      "goimports",   -- Go imports organizer
      "gofumpt",     -- Go formatter
      "delve",       -- Go debugger
    })

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = false,
      run_on_start = true,
    })

    -- Setup servers
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

    vim.notify("LSP configuration loaded", vim.log.levels.INFO, { title = "lspconfig" })
  end,
}
