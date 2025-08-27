#!/bin/bash

# This script creates the directory structure and files for the Neovim
# configuration based on the provided text file.

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Creating Neovim configuration directories..."

# Define the base directory for the configuration.
CONFIG_DIR="$HOME/.config/nvim"

# Create the main directories first.
mkdir -p "$CONFIG_DIR"
mkdir -p "$CONFIG_DIR/lua/config"
mkdir -p "$CONFIG_DIR/lua/lsp/servers"
mkdir -p "$CONFIG_DIR/lua/plugins/coding"
mkdir -p "$CONFIG_DIR/lua/plugins/editor"
mkdir -p "$CONFIG_DIR/lua/plugins/lang"
mkdir -p "$CONFIG_DIR/lua/plugins/ui"
mkdir -p "$CONFIG_DIR/lua/plugins/util"

echo "Directory structure created successfully."

echo "Creating configuration files..."

# Create and populate the .editorconfig file.
cat > "$CONFIG_DIR/.editorconfig" << 'EOF'
# top-most EditorConfig file
root = true

# Lua files
[*.lua]
indent_style = space
indent_size = 2
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

# Markdown files
[*.md]
trim_trailing_whitespace = false

# JSON, YAML
[*.{json,yml,yaml}]
indent_style = space
indent_size = 2

# Shell scripts
[*.sh]
indent_style = space
indent_size = 2

# General fallback
[*]
end_of_line = lf
charset = utf-8
EOF

# Create and populate the init.lua file.
cat > "$CONFIG_DIR/init.lua" << 'EOF'
require("config.lazy")
EOF

# Create and populate lua/config/lazy.lua.
cat > "$CONFIG_DIR/lua/config/lazy.lua" << 'EOF'
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "lsp" },
    { import = "plugins.coding" },
    { import = "plugins.editor" },
    { import = "plugins.lang" },
    { import = "plugins.ui" },
    { import = "plugins.util" },
  },
  install = { colorscheme = { "github_dark_default" } },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin"
      }
    }
  }
})
EOF

# Create and populate lua/config/options.lua.
cat > "$CONFIG_DIR/lua/config/options.lua" << 'EOF'
-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Line numbers and UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.showmode = false
opt.laststatus = 3
opt.pumheight = 10
opt.cmdheight = 1

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.inccommand = "split"

-- Files
opt.undofile = true
opt.backup = false
opt.swapfile = false
opt.autowrite = true

-- Performance
opt.updatetime = 50
opt.timeoutlen = 300
opt.redrawtime = 10000

-- Clipboard and mouse
opt.clipboard = "unnamedplus"
opt.mouse = "a"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Completion (Enhanced for Neovim 0.11+)
opt.completeopt = { "menu", "menuone", "noselect", "popup" }
opt.pumblend = 10
opt.winblend = 0
opt.shortmess:append("c")

-- Visual elements
opt.termguicolors = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", extends = "❯", precedes = "❮" }

-- Folding (Enhanced Treesitter-based)
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""

-- Diff options (Enhanced for 0.11+)
opt.diffopt:append("algorithm:histogram")
opt.diffopt:append("linematch:60")

-- Neovim 0.11+ specific features
if vim.fn.has("nvim-0.11") == 1 then
  opt.smoothscroll = true
  opt.splitkeep = "cursor"
  opt.shortmess:append("WcC")
  opt.jumpoptions = "stack"
end

-- Performance optimizations
opt.maxmempattern = 5000
opt.regexpengine = 0
EOF

# Create and populate lua/config/keymaps.lua.
cat > "$CONFIG_DIR/lua/config/keymaps.lua" << 'EOF'
local map = vim.keymap.set

-- Better escape
map("i", "jk", "<ESC>")

-- Clear search highlighting
map("n", "<leader>nh", "<cmd>nohlsearch<CR>")

-- Increment/decrement numbers
map("n", "<leader>+", "<C-a>")
map("n", "<leader>-", "<C-x>")

-- Better paste in visual mode
map("v", "p", '"_dP')

-- System clipboard
map({ "n", "v" }, "<leader>y", '"+y')

-- Save file
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR><ESC>")

-- Better scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Window splits
map("n", "<leader>|", "<cmd>vsplit<CR>")
map("n", "<leader>\\", "<cmd>split<CR>")

-- Visual line movement (works with mini.move)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Terminal navigation
map("t", "<ESC><ESC>", "<C-\\><C-n>")
map("t", "<C-h>", "<cmd>wincmd h<CR>")
map("t", "<C-j>", "<cmd>wincmd j<CR>")
map("t", "<C-k>", "<cmd>wincmd k<CR>")
map("t", "<C-l>", "<cmd>wincmd l<CR>")

-- Diagnostics
map("n", "<leader>df", vim.diagnostic.open_float)

-- Quickfix navigation
map("n", "]q", "<cmd>cnext<CR>")
map("n", "[q", "<cmd>cprev<CR>")

-- Select all
map("n", "<C-a>", "ggVG")

-- Global inlay hints toggle
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })
EOF

# Create and populate lua/config/autocmds.lua.
cat > "$CONFIG_DIR/lua/config/autocmds.lua" << 'EOF'
local augroup = vim.api.nvim_create_augroup("BasicConfig", { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-resize windows
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  command = "wincmd =",
})

-- Create parent directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
EOF

# Create and populate lua/lsp/init.lua.
cat > "$CONFIG_DIR/lua/lsp/init.lua" << 'EOF'
return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = { ui = { border = "rounded" } },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "williamboman/mason.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- LSP servers
        "lua-language-server", "typescript-language-server", "gopls", "pyright",
        "rust-analyzer", "tailwindcss-language-server", "json-lsp",
        "yaml-language-server", "bash-language-server", "emmet-language-server",
        -- Formatters
        "stylua", "prettierd", "prettier", "shfmt", "goimports", "gofumpt",
        "ruff", "black", "isort", "clang-format", "sqlfmt", "markdownlint",
        -- Linters
        "eslint_d", "shellcheck",
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      progress = {
        display = { done_ttl = 3, progress_icon = { pattern = "dots", period = 1 } },
      },
      notification = { window = { winblend = 100, border = "none" } },
    },
  },

  { "b0o/schemastore.nvim", lazy = true },
  { "folke/lazydev.nvim", ft = "lua", opts = {} },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "j-hui/fidget.nvim",
      "b0o/schemastore.nvim",
      "folke/lazydev.nvim",
    },
    config = function()
      require("lsp.handlers").setup()

      local servers = {
        lua_ls = require("lsp.servers.lua_ls"),
        ts_ls = require("lsp.servers.ts_ls"),
        gopls = require("lsp.servers.gopls"),
        pyright = require("lsp.servers.pyright"),
        rust_analyzer = require("lsp.servers.rust_analyzer"),
        jsonls = require("lsp.servers.jsonls"),
        yamlls = require("lsp.servers.yamlls"),
        tailwindcss = require("lsp.servers.tailwindcss"),
        bashls = require("lsp.servers.bashls"),
        emmet_language_server = require("lsp.servers.emmet_ls"),
      }

      local capabilities = require("lsp.handlers").capabilities

      for name, config in pairs(servers) do
        require("lspconfig")[name].setup(vim.tbl_deep_extend("force", {
          capabilities = capabilities,
        }, config))
      end
    end,
  },
}
EOF

# Create and populate lua/lsp/handlers.lua.
cat > "$CONFIG_DIR/lua/lsp/handlers.lua" << 'EOF'
local M = {}

function M.setup()
  -- Diagnostic configuration
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
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

  -- LSP handlers with rounded borders
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

  -- LspAttach autocmd for keymaps and features
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local opts = { buffer = ev.buf, silent = true }

      -- Enable inlay hints if supported
      if client and client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
      end

      -- Document highlight
      if client and client.supports_method("textDocument/documentHighlight") then
        local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
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

      -- LSP keymaps
      local map = vim.keymap.set
      map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
      map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
      map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to Implementation" }))
      map("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Type Definition" }))
      map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
      map("n", "gK", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature Help" }))
      map("i", "<C-h>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature Help" }))
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Action" }))
      map("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename Symbol" }))

      -- Buffer-specific inlay hints toggle
      if client and client.supports_method("textDocument/inlayHint") then
        map("n", "<leader>lh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
        end, vim.tbl_extend("force", opts, { desc = "Toggle Buffer Inlay Hints" }))
      end
    end,
  })
end

-- Enhanced capabilities with blink.cmp (latest 2024/2025 practices)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" }
}

-- Enhanced blink.cmp integration
local ok, blink = pcall(require, "blink.cmp")
if ok then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

M.capabilities = capabilities

return M
EOF

# Create and populate lua/lsp/servers/ts_ls.lua.
cat > "$CONFIG_DIR/lua/lsp/servers/ts_ls.lua" << 'EOF'
return {
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
}
EOF

# Create and populate lua/lsp/servers/gopls.lua.
cat > "$CONFIG_DIR/lua/lsp/servers/gopls.lua" << 'EOF'
return {
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
}
EOF

# Create and populate lua/lsp/servers/pyright.lua.
cat > "$CONFIG_DIR/lua/lsp/servers/pyright.lua" << 'EOF'
return {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoImportCompletions = true,
      },
    },
  },
}
EOF

# Create and populate lua/lsp/servers/lua_ls.lua.
cat > "$CONFIG_DIR/lua/lsp/servers/lua_ls.lua" << 'EOF'
return {
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      hint = { enable = true },
    },
  },
}
EOF

# Create and populate lua/lsp/servers/rust_analyzer.lua.
cat > "$CONFIG_DIR/lua/lsp/servers/rust_analyzer.lua" << 'EOF'
return {
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = { command = "clippy" },
      inlayHints = {
        bindingModeHints = { enable = false },
        chainingHints = { enable = true },
        closingBraceHints = { enable = true, minLines = 25 },
        closureReturnTypeHints = { enable = "never" },
        lifetimeElisionHints = { enable = "never", useParameterNames = false },
        maxLength = 25,
        parameterHints = { enable = true },
        reborrowHints = { enable = "never" },
        renderColons = true,
        typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
      },
    },
  },
}
EOF

# Create and populate lua/lsp/servers/jsonls.lua.
cat > "$CONFIG_DIR/lua/lsp/servers/jsonls.lua" << 'EOF'
return {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}
EOF

# Create and populate lua/lsp/servers/yamlls.lua.
cat > "$CONFIG_DIR/lua/lsp/servers/yamlls.lua" << 'EOF'
return {
  settings = {
    yaml = {
      schemaStore = { enable = false, url = "" },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}
EOF

# Create and populate lua/lsp/servers/tailwindcss.lua.
cat > "$CONFIG_DIR/lua/lsp/servers/tailwindcss.lua" << 'EOF'
return {}
EOF

# Create and populate lua/lsp/servers/bashls.lua.
cat > "$CONFIG_DIR/lua/lsp/servers/bashls.lua" << 'EOF'
return {}
EOF

# Create and populate lua/lsp/servers/emmet_ls.lua.
cat > "$CONFIG_DIR/lua/lsp/servers/emmet_ls.lua" << 'EOF'
return {
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
}
EOF

# Create and populate lua/plugins/coding/blink-cmp.lua.
cat > "$CONFIG_DIR/lua/plugins/coding/blink-cmp.lua" << 'EOF'
return {
  "saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  dependencies = "rafamadriz/friendly-snippets",
  opts = {
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-d>"] = { "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-space>"] = { "show", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
        -- Enhanced auto-brackets for 2024/2025
        create_undo_point = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
        window = { max_width = 80, max_height = 20, border = "rounded" },
      },
      menu = {
        border = "rounded",
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 }
          }
        },
      },
    },
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      -- Enhanced source configuration for better performance
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          enabled = true,
          transform_items = function(_, items)
            -- Sort by relevance and limit items for better performance
            table.sort(items, function(a, b) return (a.score or 0) > (b.score or 0) end)
            return vim.list_slice(items, 1, math.min(#items, 50))
          end,
        },
      },
    },
  },
}
EOF

# Create and populate lua/plugins/coding/conform.lua.
cat > "$CONFIG_DIR/lua/plugins/coding/conform.lua" << 'EOF'
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    { "<leader>f", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, mode = { "n", "v" }, desc = "Format", },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      go = { "goimports", "gofumpt" },
      rust = { "rustfmt" },
      sql = { "sqlfmt" },
      sh = { "shfmt" },
      python = { "ruff_format", "ruff_fix" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      markdown = { "markdownlint", "prettier", stop_after_first = true },
      ["_"] = { "trim_whitespace" },
    },
    format_on_save = function(bufnr)
      -- Don't format certain filetypes
      local ft = vim.bo[bufnr].filetype
      if vim.tbl_contains({ "sql" }, ft) then return end
      -- Skip large files and node_modules
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("node_modules") or vim.api.nvim_buf_get_lines(bufnr, 0, -1, false, true)[0] > 1000 then
        return
      end
      -- Fallback to default if not configured
      local conform = require("conform")
      if not conform.formatters[conform.get_formatter_list(bufnr)[1]] then
        return
      end
      conform.format({ bufnr = bufnr, lsp_format = "fallback" })
    end,
  },
}
EOF

echo "All files created and populated successfully."
echo "You can now run 'nvim' to use your new configuration."
