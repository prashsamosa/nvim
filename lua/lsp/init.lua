-- lua/lsp/init.lua
local M = {}

-- Enhanced capabilities with blink.cmp
local function get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
  end
  return capabilities
end

-- LSP handlers
local function setup_handlers()
  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
  }

  for method, handler in pairs(handlers) do
    vim.lsp.handlers[method] = handler
  end
end

-- Diagnostic configuration
local function setup_diagnostics()
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚",
        [vim.diagnostic.severity.WARN] = "󰀪",
        [vim.diagnostic.severity.INFO] = "󰋽",
        [vim.diagnostic.severity.HINT] = "󰌶",
      },
    },
    float = { border = "rounded", source = true },
  })
end

-- LSP keymaps
local function setup_keymaps(ev)
  local opts = { buffer = ev.buf, silent = true }
  local set = vim.keymap.set

  -- Navigation
  set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
  set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
  set("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Type definition" }))

  -- Documentation
  set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
  set("n", "gK", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
  set("i", "<C-h>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

  -- Actions
  set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
  set("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
end

-- LSP attach handler
local function on_attach(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client then return end

  -- Enable inlay hints if supported
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
  end

  -- Document highlighting
  if client.supports_method("textDocument/documentHighlight") then
    local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = ev.buf,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = ev.buf,
      callback = vim.lsp.buf.clear_references,
    })
  end

  setup_keymaps(ev)
end

-- Server configurations using Neovim 0.11+ native approach
function M.setup()
  setup_handlers()
  setup_diagnostics()

  -- Global LSP configuration for all servers
  vim.lsp.config('*', {
    root_markers = { '.git', 'package.json', 'go.mod', 'pyproject.toml', 'Cargo.toml' },
    capabilities = get_capabilities(),
  })

  -- Configure individual servers using vim.lsp.config (Neovim 0.11+)
  -- These will be automatically enabled by mason-lspconfig when installed

  -- Lua Language Server
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        diagnostics = { globals = { "vim" } },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME }
        },
        hint = { enable = true },
      },
    },
  })

  -- TypeScript Language Server
  vim.lsp.config("ts_ls", {
    settings = {
      typescript = {
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
  })

  -- Python Language Server
  vim.lsp.config("pyright", {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoImportCompletions = true,
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  })

  -- Go Language Server
  vim.lsp.config("gopls", {
    settings = {
      gopls = {
        gofumpt = true,
        staticcheck = true,
        usePlaceholders = true,
        completeUnimported = true,
        codelenses = { generate = true, test = true, tidy = true },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          parameterNames = true,
        },
      },
    },
  })

  -- Setup LSP attach autocmd
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
    callback = on_attach,
  })

  -- Go-specific keymaps
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "gomod", "gosum", "gotmpl" },
    callback = function(ev)
      local opts = { buffer = ev.buf, silent = true }
      local set = vim.keymap.set

      set("n", "<leader>gi", "<cmd>!goimports -w %<CR>", vim.tbl_extend("force", opts, { desc = "Go imports" }))
      set("n", "<leader>gt", "<cmd>!go test<CR>", vim.tbl_extend("force", opts, { desc = "Go test" }))
      set("n", "<leader>gr", "<cmd>!go run %<CR>", vim.tbl_extend("force", opts, { desc = "Go run" }))
    end,
  })
end

return M
