return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} }, -- LSP progress notifications
  },
  config = function()
    -- Helper function to get JSON/YAML schemas from schemastore
    local function get_schemas(type)
      local schemastore = require("schemastore")
      return schemastore[type].schemas()
    end

    -- Auto-command that runs when LSP attaches to a buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        -- Helper function to create keymaps with consistent options
        local map = function(keys, fn, desc, mode)
          vim.keymap.set(mode or "n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Navigation keymaps using fzf-lua for better UX
        map("gd", require("fzf-lua").lsp_definitions, "Go to Definition")
        map("gr", require("fzf-lua").lsp_references, "Go to References")
        map("gI", require("fzf-lua").lsp_implementations, "Go to Implementation")
        map("gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("<leader>D", require("fzf-lua").lsp_typedefs, "Type Definition")

        -- Symbol search keymaps
        map("<leader>ds", require("fzf-lua").lsp_document_symbols, "Document Symbols")
        map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "Workspace Symbols")

        -- Code action and refactoring keymaps
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("<leader>cr", vim.lsp.buf.rename, "Rename")

        -- Documentation keymaps
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<C-k>", vim.lsp.buf.signature_help, "Signature Help", "i")

        -- Get the LSP client for this buffer
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Disable LSP formatting in favor of dedicated formatters (like conform.nvim)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        -- Helper function to check if client supports a specific method
        local function supports(method)
          return client.supports_method(method)
        end

        -- Document highlighting: highlight symbol under cursor
        if supports("textDocument/documentHighlight") then
          local group = vim.api.nvim_create_augroup("lsp-highlight-" .. event.buf, { clear = true })

          -- Highlight on cursor hold
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = group,
            callback = vim.lsp.buf.document_highlight,
          })

          -- Clear highlights on cursor move
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = group,
            callback = vim.lsp.buf.clear_references,
          })

          -- Clean up when LSP detaches
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach-" .. event.buf, { clear = true }),
            callback = function()
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = group })
            end,
          })
        end

        -- Inlay hints: show type hints inline in code
        if supports("textDocument/inlayHint") then
          map("<leader>ih", function()
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
            vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
          end, "Toggle Inlay Hints")
        end

        -- Code lens: show actionable metadata above code
        if supports("textDocument/codeLens") then
          -- Refresh code lens on buffer enter and changes
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = event.buf,
            callback = vim.lsp.codelens.refresh,
          })
          map("<leader>cl", vim.lsp.codelens.run, "Run Code Lens")
        end
      end,
    })

    -- Configure diagnostic display options
    vim.diagnostic.config({
      severity_sort = true, -- Sort diagnostics by severity
      underline = true,     -- Underline problematic code
      update_in_insert = false, -- Don't update diagnostics in insert mode
      virtual_text = {
        source = "if_many", -- Show source only if multiple sources
        spacing = 2,        -- Spacing between text and virtual text
        prefix = "●",       -- Prefix character for virtual text
        -- Truncate long diagnostic messages
        format = function(d)
          return #d.message > 60 and (d.message:sub(1, 60) .. "...") or d.message
        end,
      },
      -- Floating window configuration for diagnostics
      float = {
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
        focusable = false
      },
      -- Custom icons for different diagnostic severities
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚",
          [vim.diagnostic.severity.WARN] = "󰀪",
          [vim.diagnostic.severity.INFO] = "󰋽",
          [vim.diagnostic.severity.HINT] = "󰌶",
        },
      },
    })

    -- Global diagnostic navigation keymaps
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic list" })
    vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic quickfix" })

    -- Setup LSP capabilities with completion support
    local base_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = package.loaded["blink.cmp"]
      and require("blink.cmp").get_lsp_capabilities(base_capabilities)
      or base_capabilities

    -- LSP server configurations
    local servers = {
      -- Bash/Shell scripting
      bashls = {
        filetypes = { "sh", "bash", "zsh" },
        settings = {
          bashIde = {
            globPattern = "**/*@(.sh|.inc|.bash|.command)"
          }
        },
      },

      -- Markdown support
      marksman = {
        filetypes = { "markdown", "md" },
        single_file_support = true
      },

      -- Lua language server (optimized for Neovim)
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" }, -- Use LuaJIT runtime
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
            },
            completion = { callSnippet = "Replace" },
            diagnostics = {
              globals = { "vim", "Snacks" }, -- Recognize vim and Snacks as globals
              disable = { "missing-fields" } -- Disable annoying missing-fields warnings
            },
            hint = { enable = true }, -- Enable inlay hints
            telemetry = { enable = false }, -- Disable telemetry
            format = { enable = false }, -- Disable built-in formatting
          },
        },
      },

      -- Python language server
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic", -- Basic type checking
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
        },
      },

      -- Go language server with extensive configuration
      gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
        single_file_support = true,
        settings = {
          gopls = {
            -- Static analysis options
            analyses = {
              unusedparams = true,  -- Report unused parameters
              shadow = true,        -- Report variable shadowing
              nilness = true,       -- Report nil pointer dereferences
              unusedwrite = true,   -- Report unused writes
              useany = true,        -- Suggest using 'any' instead of 'interface{}'
            },
            staticcheck = true,   -- Enable staticcheck integration
            gofumpt = true,      -- Use gofumpt for formatting
            -- Code lens options
            codelenses = {
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            -- Inlay hints configuration
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
            ["formatting.gofumpt"] = false, -- Disable to use external formatter
            ["formatting.local"] = "",
          },
        },
        flags = { debounce_text_changes = 200 }, -- Reduce server load
      },

      -- TypeScript/JavaScript language server
      ts_ls = {
        settings = {
          typescript = {
            format = { enable = false }, -- Use external formatter
            inlayHints = { includeInlayParameterNameHints = "all" }
          },
          javascript = {
            format = { enable = false }, -- Use external formatter
            inlayHints = { includeInlayParameterNameHints = "all" }
          },
        },
      },

      -- Rust language server
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true }, -- Enable all Cargo features
            checkOnSave = { command = "check" }, -- Use cargo check on save
            procMacro = { enable = true }, -- Enable procedural macros
            inlayHints = { enable = true },
            formatting = { enable = false }, -- Use external formatter
          },
        },
      },

      -- JSON language server with schema validation
      jsonls = {
        settings = {
          json = {
            schemas = get_schemas("json"), -- Use schemastore for validation
            validate = { enable = true },
            format = { enable = false }, -- Use external formatter
          },
        },
      },

      -- YAML language server with schema validation
      yamlls = {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" }, -- Disable default store
            schemas = get_schemas("yaml"), -- Use schemastore for validation
            format = { enable = false }, -- Use external formatter
          },
        },
      },

      -- HTML language server
      html = {
        settings = {
          html = {
            format = { enable = false } -- Use external formatter
          }
        }
      },

      -- CSS language server
      cssls = {
        settings = {
          css = {
            format = { enable = false } -- Use external formatter
          }
        }
      },
    }

    -- Tools to ensure are installed via Mason
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, {
      -- Formatters
      "stylua",     -- Lua formatter
      "prettierd",  -- JavaScript/TypeScript/JSON/CSS formatter
      "shfmt",      -- Shell script formatter
      "goimports",  -- Go import organizer
      "gofumpt",    -- Go formatter
      "black",      -- Python formatter
      "isort",      -- Python import sorter
      "rustfmt",    -- Rust formatter

      -- Debuggers and linters
      "delve",         -- Go debugger
      "golangci-lint", -- Go linter
    })

    -- Setup Mason tool installer
    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = false, -- Don't auto-update tools
      run_on_start = true, -- Install missing tools on startup
    })

    -- Setup Mason LSP config with automatic installation
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
      handlers = {
        -- Default handler for all servers
        function(server_name)
          local config = servers[server_name] or {}
          -- Merge capabilities with server-specific config
          config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
          require("lspconfig")[server_name].setup(config)
        end,
      },
    })

    -- Notification that LSP setup is complete
    vim.notify("LSP configuration loaded", vim.log.levels.INFO, { title = "lspconfig" })
  end,
}
