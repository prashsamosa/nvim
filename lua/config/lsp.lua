-- ================================================================================================
-- TITLE : Native LSP Configuration (Neovim 0.11+)
-- ABOUT : Configures LSP using native vim.lsp.enable() API without nvim-lspconfig
-- ================================================================================================

-- Setup diagnostics first
require('utils.diagnostics').setup()

-- Define LSP keymaps that will be applied on LSP attach
local function setup_lsp_keymaps(bufnr)
  local keymap = vim.keymap.set
  local opts = {
    noremap = true,
    silent = true,
    buffer = bufnr,
  }

  -- Native neovim keymaps
  keymap('n', '<leader>gD', vim.lsp.buf.definition, opts)
  keymap('n', '<leader>gS', function()
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
  end, opts)
  keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
  keymap('n', '<leader>D', function()
    vim.diagnostic.open_float({ scope = 'line' })
  end, opts)
  keymap('n', '<leader>d', vim.diagnostic.open_float, opts)
  keymap('n', '<leader>pd', vim.diagnostic.goto_prev, opts)
  keymap('n', '<leader>nd', vim.diagnostic.goto_next, opts)
  keymap('n', 'K', vim.lsp.buf.hover, opts)

  -- fzf-lua keymaps
  keymap('n', '<leader>gd', '<cmd>FzfLua lsp_finder<CR>', opts)
  keymap('n', '<leader>gr', '<cmd>FzfLua lsp_references<CR>', opts)
  keymap('n', '<leader>gt', '<cmd>FzfLua lsp_typedefs<CR>', opts)
  keymap('n', '<leader>ds', '<cmd>FzfLua lsp_document_symbols<CR>', opts)
  keymap('n', '<leader>ws', '<cmd>FzfLua lsp_workspace_symbols<CR>', opts)
  keymap('n', '<leader>gi', '<cmd>FzfLua lsp_implementations<CR>', opts)

  -- Order Imports (if supported)
  local client = vim.lsp.get_clients({ bufnr = bufnr })[1]
  if client and client.supports_method('textDocument/codeAction') then
    keymap('n', '<leader>oi', function()
      vim.lsp.buf.code_action({
        context = {
          only = { 'source.organizeImports' },
          diagnostics = {},
        },
        apply = true,
      })
      vim.defer_fn(function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, 50)
    end, opts)
  end
end

-- Setup LSP attach autocmd for keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(args)
    setup_lsp_keymaps(args.buf)
  end,
})

-- Get capabilities from nvim-cmp for autocompletion
local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp then
  vim.lsp.config('*', {
    capabilities = cmp_nvim_lsp.default_capabilities(),
  })
end

-- Enable all language servers
-- The configs are loaded automatically from ~/.config/nvim/lsp/<name>.lua
vim.lsp.enable({
  'lua_ls',
  'pyright',
  'gopls',
  'ts_ls',
  'jsonls',
  'bashls',
  'clangd',
  'dockerls',
  'emmet_ls',
  'yamlls',
  'efm',
})
