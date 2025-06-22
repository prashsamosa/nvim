return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
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
      local function get_schemas(type)
        local schemastore = require("schemastore")
        return schemastore[type].schemas()
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, fn, desc, mode)
            vim.keymap.set(mode or "n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", require("fzf-lua").lsp_definitions, "Go to Definition")
          map("gr", require("fzf-lua").lsp_references, "Go to References")
          map("gI", require("fzf-lua").lsp_implementations, "Go to Implementation")
          map("gD", vim.lsp.buf.declaration, "Go to Declaration")
          map("<leader>td", require("fzf-lua").lsp_typedefs, "Type Definition")
          map("<leader>ds", require("fzf-lua").lsp_document_symbols, "Document Symbols")
          map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "Workspace Symbols")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
          map("<leader>cr", vim.lsp.buf.rename, "Rename")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<C-k>", vim.lsp.buf.signature_help, "Signature Help", "i")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            local function supports(method)
              return client.supports_method and client:supports_method(method)
            end

            if supports("textDocument/documentHighlight") then
              local group = vim.api.nvim_create_augroup("lsp-highlight-" .. event.buf, { clear = true })
              vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = group,
                callback = vim.lsp.buf.document_highlight,
              })
              vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = group,
                callback = vim.lsp.buf.clear_references,
              })
              vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("lsp-detach-" .. event.buf, { clear = true }),
                callback = function()
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds({ group = group })
                end,
              })
            end

            if supports("textDocument/inlayHint") and vim.lsp.inlay_hint then
              map("<leader>ih", function()
                local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
              end, "Toggle Inlay Hints")
            end

            if supports("textDocument/codeLens") then
              vim.lsp.codelens.refresh()
              vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = event.buf,
                callback = vim.lsp.codelens.refresh,
              })
              map("<leader>cl", vim.lsp.codelens.run, "Run Code Lens")
            end
          end
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        update_in_insert = false,
        virtual_text = {
          source = "if_many",
          spacing = 2,
          prefix = "●",
          format = function(d)
            return #d.message > 60 and (d.message:sub(1, 60) .. "...") or d.message
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

      vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev({ float = true })
      end, { desc = "Prev diagnostic" })

      vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_next({ float = true })
      end, { desc = "Next diagnostic" })

      vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic list" })
      vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic quickfix" })

      local base_capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = package.loaded["blink.cmp"]
        and require("blink.cmp").get_lsp_capabilities(base_capabilities)
        or base_capabilities

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
              workspace = { checkThirdParty = false },
              diagnostics = {
                globals = { "vim", "Snacks" },
                disable = { "missing-fields" },
              },
              completion = { callSnippet = "Replace" },
              hint = { enable = true },
              telemetry = { enable = false },
              format = { enable = false },
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
        gopls = {
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
          single_file_support = true,
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
              completeUnimported = true,
              matcher = "Fuzzy",
              symbolMatcher = "fuzzy",
              semanticTokens = true,
              ["formatting.gofumpt"] = false,
              ["formatting.local"] = "",
            },
          },
          flags = { debounce_text_changes = 200 },
        },
        ts_ls = {
          settings = {
            typescript = {
              format = { enable = false },
              inlayHints = { includeInlayParameterNameHints = "all" },
            },
            javascript = {
              format = { enable = false },
              inlayHints = { includeInlayParameterNameHints = "all" },
            },
          },
        },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = { command = "check" },
              procMacro = { enable = true },
              inlayHints = { enable = true },
              formatting = { enable = false },
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = get_schemas("json"),
              validate = { enable = true },
              format = { enable = false },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = { enable = false, url = "" },
              schemas = get_schemas("yaml"),
              format = { enable = false },
            },
          },
        },
        html = {
          settings = {
            html = { format = { enable = false } },
          },
        },
        cssls = {
          settings = {
            css = { format = { enable = false } },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, {
        "stylua",
        "prettierd",
        "shfmt",
        "goimports",
        "gofumpt",
        "black",
        "isort",
        "rustfmt",
        "delve",
        "golangci-lint",
      })

      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
        auto_update = false,
        run_on_start = true,
      })

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

      vim.notify("LSP configuration loaded", vim.log.levels.INFO, { title = "lspconfig" })
    end,
  },
}
