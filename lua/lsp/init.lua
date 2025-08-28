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

-- Server configurations
function M.setup()
  setup_handlers()
  setup_diagnostics()

  -- Global LSP configuration
  vim.lsp.config('*', {
    root_markers = { '.git', 'package.json', 'go.mod', 'pyproject.toml', 'Cargo.toml' },
    capabilities = get_capabilities(),
  })

  -- Load server configurations
  require("lsp.typescript")
  require("lsp.python")
  require("lsp.golang")
  require("lsp.lua")

  -- Setup LSP attach autocmd
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
    callback = on_attach,
  })
end

return M
