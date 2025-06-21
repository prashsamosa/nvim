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

        -- Symbols (Fixed to match README)
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

        -- Disable LSP formatting - let conform.nvim handle it
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

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
        filetypes = { "sh", "bash", "zsh" },
        settings = {
          bashIde = {
            globPattern = "**/*@(.sh|.inc|.bash|.command)",
          },
        },
      },

      marksman = {
        filetypes = { "markdown", "md" },
        single_file_support = true,
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
            format = { enable = false }, -- Disable LSP formatting
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

      -- Go LSP - Enhanced configuration
      gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
        single_file_support = true,
        settings = {
          gopls = {
            -- Analysis
            analyses = {
              unusedparams = true,
              shadow = true,
              fieldalignment = false, -- Can be noisy
              nilness = true,
              unusedwrite = true,
              useany = true,
            },
            staticcheck = true,
            gofumpt = true,

            -- Code lenses
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

            -- Inlay hints
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },

            -- Other settings
            usePlaceholders = true,
            completeUnimported = true,
            matcher = "Fuzzy",
            symbolMatcher = "fuzzy",
            semanticTokens = true,

            -- Disable formatting - conform.nvim handles this
            ["formatting.gofumpt"] = false,
            ["formatting.local"] = "",
          },
        },
        flags = {
          debounce_text_changes = 200,
        },
      },

      -- TypeScript/JavaScript
      ts_ls = {
        settings = {
          typescript = {
            format = { enable = false }, -- Disable LSP formatting
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
            format = { enable = false }, -- Disable LSP formatting
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

      -- Rust
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            checkOnSave = {
              command = "check", -- Use 'clippy' for more lints
            },
            procMacro = {
              enable = true,
            },
            inlayHints = {
              enable = true,
            },
            formatting = {
              enable = false, -- Disable LSP formatting
            },
          },
        },
      },

      -- JSON
      jsonls = {
        settings = {
          json = {
            schemas = get_schemas("json"),
            validate = { enable = true },
            format = { enable = false }, -- Disable LSP formatting
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
            format = { enable = false }, -- Disable LSP formatting
          },
        },
      },

      -- HTML
      html = {
        settings = {
          html = {
            format = { enable = false }, -- Disable LSP formatting
          },
        },
      },

      -- CSS
      cssls = {
        settings = {
          css = {
            format = { enable = false }, -- Disable LSP formatting
          },
        },
      },
    }

    -- Ensure installed tools
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, {
      -- Formatters (for conform.nvim)
      "stylua",      -- Lua formatter
      "prettierd",   -- Multi-language formatter
      "shfmt",       -- Shell formatter
      "goimports",   -- Go imports organizer
      "gofumpt",     -- Go formatter
      "black",       -- Python formatter
      "isort",       -- Python import sorter
      "rustfmt",     -- Rust formatter

      -- Linters and tools
      "delve",       -- Go debugger
      "golangci-lint", -- Go linter
    })

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = false,
      run_on_start = true,
    })

    -- Setup servers
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
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
