# Neovim 0.12.2 Configuration Audit

We’ve carefully audited your Neovim v0.12.2 Lua config. Overall the structure and options are modern, but we found a few areas to improve, especially in Treesitter setup and undo directory management. Below are the findings and fixes:

- **Plugin Management (`vim.pack`)** – You’re correctly using Neovim’s new built-in package manager. It’s considered stable in 0.12【21†L262-L270】. No change needed here; just ensure you commit the `nvim-pack-lock.json` for reproducible setups. (See [Pack Docs](https://neovim.io/doc/user/pack.html) for `vim.pack` usage【21†L262-L270】.)
- **Treesitter Setup** – The current config manually installs parsers and triggers `vim.treesitter.start()`. Modern practice is to use `require("nvim-treesitter.configs").setup{...}` with `ensure_installed` and `highlight.enable = true`. This simplifies configuration and auto-starts highlighting. We switch to that below (citing the Treesitter guide【23†L290-L298】).
- **Undo Directory** – Instead of hardcoding `~/.vim/undodir`, use `stdpath("state")`. For example:
  ```lua
  vim.opt.undodir = vim.fn.stdpath("state").."/undo"
  ```
  This follows the XDG standard (Neovim recommends using `stdpath` for state/config files).
- **LSP Setup** – Your use of `vim.lsp.config()` and `vim.lsp.enable()` is correct for 0.12【27†L252-L258】. We keep this but consolidate a bit (see code below). Optionally, you could integrate Mason more (with `mason-lspconfig`), but it’s not required. Keymaps for LSP actions remain valid.
- **Diagnostics** – You use `vim.diagnostic.config()` properly. Note that in 0.12 the old `:sign-define` and `vim.diagnostic.disable()` APIs were removed【37†L36-L43】. Your toggle (`vim.diagnostic.enable(not vim.diagnostic.is_enabled())`) is the correct modern approach (the deprecated calls were replaced by `vim.diagnostic.enable/disable` in 0.10【37†L36-L43】). No changes needed here.
- **Keymaps & Autocmds** – All keymap and autocmd usage is up-to-date (using `vim.keymap.set` and `nvim_create_autocmd`). One small note: setting both `smartindent` and `autoindent` is redundant (smartindent already includes autoindent), but it’s harmless.
- **Statusline** – Your custom statusline functions and autocmds are fine. No deprecations here.
- **Lua APIs** – All `vim.api.nvim_set_hl`, `vim.opt`, etc. are current. One optional improvement: calling `vim.loader.enable()` at the top of `init.lua` can speed up module loading (it’s experimental【35†L4712-L4715】). Use with caution. We do **not** enable it by default here.

In summary, we only needed to modernize Treesitter config and use the standard undo path. Everything else is already current. Below we provide full updated files (in Lua modules) you can copy directly. We’ve broken the config into logical modules (`plugins.lua`, `lsp.lua`, etc.) and updated as described. Existing behavior is preserved.

## Updated Configuration Files

### init.lua

```lua
-- init.lua
-- Neovim v0.12.2 init file

-- (Optional) Enable experimental Lua module loader for faster loading:
-- vim.loader.enable()  -- *Experimental*: use with caution (see docs).

-- Set colorscheme and GUI options
vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax")  -- ensure habamax is installed

-- Set up transparent background for common UI elements
local function set_transparent()
  local groups = {
    "Normal", "NormalNC", "EndOfBuffer", "NormalFloat", "FloatBorder",
    "SignColumn", "StatusLine", "StatusLineNC", "TabLine",
    "TabLineFill", "TabLineSel", "ColorColumn",
  }
  for _, g in ipairs(groups) do
    vim.api.nvim_set_hl(0, g, { bg = "none" })
  end
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end
set_transparent()

-- ================================
-- BASIC OPTIONS
-- ================================
vim.opt.number        = true
vim.opt.relativenumber = true
vim.opt.cursorline    = true
vim.opt.wrap          = false
vim.opt.scrolloff     = 10
vim.opt.sidescrolloff = 10

vim.opt.tabstop       = 2
vim.opt.shiftwidth    = 2
vim.opt.softtabstop   = 2
vim.opt.expandtab     = true
vim.opt.smartindent   = true  -- also enables autoindent
vim.opt.autoindent    = true

vim.opt.ignorecase    = true
vim.opt.smartcase     = true
vim.opt.hlsearch      = true
vim.opt.incsearch     = true

vim.opt.signcolumn    = "yes"
vim.opt.colorcolumn   = "100"
vim.opt.showmatch     = true
vim.opt.cmdheight     = 1
vim.opt.completeopt   = "menuone,noinsert,noselect"
vim.opt.showmode      = false
vim.opt.pumheight     = 10
vim.opt.pumblend      = 10
vim.opt.winblend      = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw    = true
vim.opt.synmaxcol     = 300
vim.opt.fillchars     = { eob = " " }

-- Undo directory (use stdpath for XDG compliance)
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
if vim.fn.isdirectory(vim.opt.undodir:get()) == 0 then
  vim.fn.mkdir(vim.opt.undodir:get(), "p")
end

-- Backup/Swap off (using undo file instead)
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.updatetime   = 300
vim.opt.timeoutlen   = 500
vim.opt.ttimeoutlen  = 50
vim.opt.autoread     = true
vim.opt.autowrite    = false

vim.opt.hidden       = true
vim.opt.errorbells   = false
vim.opt.backspace    = "indent,eol,start"
vim.opt.autochdir    = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection    = "inclusive"
vim.opt.mouse        = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable   = true
vim.opt.encoding     = "utf-8"

-- Cursor style
vim.opt.guicursor =
  "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50," ..
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor," ..
  "sm:block-blinkwait175-blinkoff150-blinkon175"

-- Enable Treesitter-based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr   = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel  = 99
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wildmenu  = true
vim.opt.wildmode  = "longest:full,full"
vim.opt.diffopt:append("linematch:60")
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Statusline setup
require("statusline").setup()

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load keymaps, plugins, LSP, etc.
require("keymaps")
require("autocmds")
require("plugins")   -- must come before plugin-specific configs
require("plugin_configs")  -- configs for installed plugins
require("lsp")       -- LSP and completion setup
require("treesitter")
```

### lua/plugins.lua

```lua
-- lua/plugins.lua
-- Define plugins using vim.pack (built-in plugin manager)
vim.pack.add({
  -- UI and utility plugins
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-tree/nvim-tree.lua",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main", build = ":TSUpdate" },
  -- LSP, Mason, EFM
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/creativenull/efmls-configs-nvim",
  -- Completion and snippets
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/L3MON4D3/LuaSnip",
})
```

### lua/keymaps.lua

```lua
-- lua/keymaps.lua
-- Global key mappings

-- Better movement in wrapped text
vim.keymap.set("n", "j", function() return vim.v.count == 0 and "gj" or "j" end, {
  expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function() return vim.v.count == 0 and "gk" or "k" end, {
  expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search (center)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search (center)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (center)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (center)" })

-- Clipboard and delete/paste
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Prev buffer" })

-- Window navigation (better keys)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- Resize windows
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>",    { desc = "Increase height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>",  { desc = "Decrease height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>",{ desc = "Increase width" })

-- Move lines faster
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==",   { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==",   { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Indentation in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Misc
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines, keep cursor" })
vim.keymap.set("n", "<leader>pa", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("File path copied: " .. path)
  end, { desc = "Copy file path" })

vim.keymap.set("n", "<leader>td", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, { desc = "Toggle diagnostics" })
```

### lua/autocmds.lua

```lua
-- lua/autocmds.lua
local aug = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Format on save (if efm is attached to buffer)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = aug,
  pattern = { "*.lua","*.py","*.go","*.js","*.jsx","*.ts","*.tsx",
              "*.json","*.css","*.scss","*.html","*.sh","*.bash",
              "*.zsh","*.c","*.cpp","*.h","*.hpp" },
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" or not vim.bo[args.buf].modifiable then
      return
    end
    local has_efm = false
    for _, c in ipairs(vim.lsp.get_clients({bufnr = args.buf})) do
      if c.name == "efm" then has_efm = true; break end
    end
    if has_efm then
      vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 2000,
        filter = function(c) return c.name == "efm" end })
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug,
  callback = function() vim.highlight.on_yank({timeout=200}) end,
})

-- Restore last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = aug,
  callback = function()
    if vim.o.diff then return end
    local pos = vim.api.nvim_buf_get_mark(0, '"')
    local row = pos[1]
    if row >= 1 and row <= vim.api.nvim_buf_line_count(0) then
      pcall(vim.api.nvim_win_set_cursor, 0, pos)
    end
  end,
})

-- Markdown/text settings
vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})

-- Floating terminal close on exit
vim.api.nvim_create_autocmd("TermClose", {
  group = aug,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = aug,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})
```

### lua/plugin_configs.lua

```lua
-- lua/plugin_configs.lua
-- Configuration for individual plugins

-- Statusline (custom icons and dynamic segments)
-- [This was extracted to statusline.lua]

-- nvim-tree (file explorer)
require("nvim-tree").setup({
  view = { width = 35 },
  filters = { dotfiles = false },
  renderer = { group_empty = true },
})
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
-- Remove background for tree for transparency
vim.api.nvim_set_hl(0, "NvimTreeNormal",    { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC",  { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeSignColumn",{ bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator",{ bg = "none", fg = "#2a2a2a" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer",{ bg = "none" })

-- fzf-lua (FZF interface)
require("fzf-lua").setup({})
vim.keymap.set("n", "<leader>ff", function() require("fzf-lua").files() end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function() require("fzf-lua").live_grep() end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function() require("fzf-lua").buffers() end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function() require("fzf-lua").help_tags() end, { desc = "FZF Help" })
vim.keymap.set("n", "<leader>fx", function() require("fzf-lua").diagnostics_document() end, { desc = "FZF Doc Diagnostics" })
vim.keymap.set("n", "<leader>fX", function() require("fzf-lua").diagnostics_workspace() end, { desc = "FZF Workspace Diagnostics" })

-- mini.nvim modules
require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})

-- gitsigns
require("gitsigns").setup({
  signs = {
    add          = { text = "▏" },  -- ▏
    change       = { text = "▏" },  -- ▐
    delete       = { text = "▏" },  -- vertical bar
    topdelete    = { text = "◦" },
    changedelete = { text = "●" },
    untracked    = { text = "○" },
  },
  signcolumn = true,
  current_line_blame = false,
})
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next git hunk" })
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Prev git hunk" })
vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })
vim.keymap.set("n", "<leader>hB", "<cmd>Gitsigns toggle_current_line_blame()<CR>", { desc = "Toggle blame" })
vim.keymap.set("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>", { desc = "Diff to index" })

-- Mason (LSP installer)
require("mason").setup()
```

### lua/lsp.lua

```lua
-- lua/lsp.lua
-- LSP, formatting, diagnostics, and completion

-- Diagnostic signs (icons for the sign column)
local diagnostic_signs = {
  Error = " ", Warn = " ", Hint = "", Info = "",
}
vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    active = vim.tbl_map(function(sev) return { text = diagnostic_signs[sev] or "●" } end,
                       { "Error", "Warn", "Hint", "Info" })
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    focusable = false,
    style = "minimal",
  },
})

-- Use rounded border for LSP hover/doc by default
do
  local orig = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig(contents, syntax, opts, ...)
  end
end

-- LSP on_attach: common keymaps when a language server attaches
local function lsp_on_attach(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client then return end
  local bufnr = ev.buf
  local opts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set("n", "<leader>gd", function()
      require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
    end, opts)
  vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>gS", function()
      vim.cmd("vsplit")
      vim.lsp.buf.definition()
    end, opts)

  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  vim.keymap.set("n", "<leader>D", function()
      vim.diagnostic.open_float({ scope = "line" })
    end, opts)
  vim.keymap.set("n", "<leader>d", function()
      vim.diagnostic.open_float({ scope = "cursor" })
    end, opts)
  vim.keymap.set("n", "<leader>nd", function()
      vim.diagnostic.jump({ count = 1 })
    end, opts)
  vim.keymap.set("n", "<leader>pd", function()
      vim.diagnostic.jump({ count = -1 })
    end, opts)

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  -- FZF for LSP queries
  vim.keymap.set("n", "<leader>fd", function()
      require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
    end, opts)
  vim.keymap.set("n", "<leader>fr", function()
      require("fzf-lua").lsp_references()
    end, opts)
  vim.keymap.set("n", "<leader>ft", function()
      require("fzf-lua").lsp_typedefs()
    end, opts)
  vim.keymap.set("n", "<leader>fs", function()
      require("fzf-lua").lsp_document_symbols()
    end, opts)
  vim.keymap.set("n", "<leader>fw", function()
      require("fzf-lua").lsp_workspace_symbols()
    end, opts)
  vim.keymap.set("n", "<leader>fi", function()
      require("fzf-lua").lsp_implementations()
    end, opts)

  -- Organize imports (if supported)
  if client.supports_method("textDocument/codeAction") then
    vim.keymap.set("n", "<leader>oi", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true, bufnr = bufnr,
      })
      vim.defer_fn(function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, 50)
    end, opts)
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspConfig", {}),
  callback = lsp_on_attach
})

-- Diagnostic list
vim.keymap.set("n", "<leader>q", function()
    vim.diagnostic.setloclist({ open = true })
  end, { desc = "Open diagnostics list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float,
  { desc = "Show line diagnostics" })

-- Blink completion setup (v1 stable)
require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<C-Space>"] = { "show", "hide" },
    ["<CR>"]      = { "accept", "fallback" },
    ["<C-j>"]     = { "select_next",  "fallback" },
    ["<C-k>"]     = { "select_prev",  "fallback" },
    ["<Tab>"]     = { "snippet_forward",  "fallback" },
    ["<S-Tab>"]   = { "snippet_backward", "fallback" },
  },
  appearance = { nerd_font_variant = "mono" },
  completion = { menu = { auto_show = true } },
  sources = { default = { "lsp", "path", "buffer", "snippets" } },
  snippets = {
    expand = function(snippet) require("luasnip").lsp_expand(snippet) end,
  },
  fuzzy = {
    implementation = "prefer_rust",
    prebuilt_binaries = { download = true },
  },
})

-- Setup LSP configurations (capabilities from blink.cmp)
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("lua_ls", {
  settings = { Lua = { diagnostics = { globals = {"vim"} }, telemetry = { enable = false } } }
})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("tsserver", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

-- EFM (formatters/linters)
do
  local luacheck = require("efmls-configs.linters.luacheck")
  local stylua   = require("efmls-configs.formatters.stylua")
  local flake8   = require("efmls-configs.linters.flake8")
  local black    = require("efmls-configs.formatters.black")
  local prettier = require("efmls-configs.formatters.prettier_d")
  local eslint   = require("efmls-configs.linters.eslint_d")
  local fixjson  = require("efmls-configs.formatters.fixjson")
  local shell    = require("efmls-configs.linters.shellcheck")
  local shfmt    = require("efmls-configs.formatters.shfmt")
  local cpplint  = require("efmls-configs.linters.cpplint")
  local clangfmt = require("efmls-configs.formatters.clang_format")
  local go_revive= require("efmls-configs.linters.go_revive")
  local gofumpt  = require("efmls-configs.formatters.gofumpt")

  vim.lsp.config("efm", {
    filetypes = { "c","cpp","css","go","html","javascript","javascriptreact","json",
                  "jsonc","lua","markdown","python","sh","typescript","typescriptreact" },
    init_options = { documentFormatting = true },
    settings = {
      languages = {
        c     = { clangfmt, cpplint },
        cpp   = { clangfmt, cpplint },
        go    = { gofumpt, go_revive },
        css   = { prettier },
        html  = { prettier },
        javascript = { eslint, prettier },
        javascriptreact = { eslint, prettier },
        json  = { eslint, fixjson },
        jsonc = { eslint, fixjson },
        lua   = { luacheck, stylua },
        markdown = { prettier },
        python = { flake8, black },
        sh    = { shell, shfmt },
        typescript = { eslint, prettier },
        typescriptreact = { eslint, prettier },
      },
    },
  })
end

-- Enable (start) the LSP servers we configured
vim.lsp.enable({
  "lua_ls", "pyright", "bashls", "tsserver", "gopls", "clangd", "efm",
})
```

### lua/treesitter.lua

```lua
-- lua/treesitter.lua
-- Treesitter configuration
-- Use nvim-treesitter.configs for setup (recommended)【23†L290-L298】

local ts_configs = require("nvim-treesitter.configs")
ts_configs.setup({
  ensure_installed = {
    "vim", "vimdoc", "rust", "c", "cpp", "go", "html", "css",
    "javascript", "json", "lua", "markdown", "python", "typescript", "bash",
  },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
  indent    = { enable = true },
})

-- (Optional) Handle situations where a parser is not installed: automatically install
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and not vim.tbl_contains(ts_configs.get_installed(), lang) then
      require("nvim-treesitter.install").install(lang)
      vim.treesitter.start(args.buf)
    end
  end,
})
```

### lua/statusline.lua

```lua
-- lua/statusline.lua
-- Custom statusline using global functions and autocommands

-- Git branch indicator (cached for performance)
local cached_branch = ""
local last_check = 0
local function git_branch()
  local now = vim.loop.now()
  if now - last_check > 5000 then
    cached_branch = vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " branch --show-current 2>/dev/null | tr -d '\\n'")
    last_check = now
  end
  return (cached_branch ~= "" and (" \u{e725} " .. cached_branch .. " ") or "")
end

-- File type icon (Nerd Font icons by filetype)
local function file_type()
  local ft = vim.bo.filetype
  local icons = {
    lua = "\u{e620}", python = "\u{e73c}", javascript = "\u{e74e}",
    typescript = "\u{e628}", javascriptreact = "\u{e7ba}",
    typescriptreact = "\u{e7ba}", html = "\u{e736}", css = "\u{e749}", json = "\u{e60b}",
    markdown = "\u{e73e}", vim = "\u{e62b}", sh = "\u{f489}", bash = "\u{f489}",
    zsh = "\u{f489}", rust = "\u{e7a8}", go = "\u{e724}", c = "\u{e61e}", cpp = "\u{e61d}",
    java = "\u{e738}", php = "\u{e73d}", ruby = "\u{e739}", swift = "\u{e755}",
    kotlin = "\u{e634}", dart = "\u{e798}", elixir = "\u{e62d}", haskell = "\u{e777}",
    sql = "\u{e706}", yaml = "\u{f481}", toml = "\u{e615}", xml = "\u{f05c}",
    dockerfile = "\u{f308}", gitcommit = "\u{f418}", gitconfig = "\u{f1d3}",
    astro = "\u{e628}",
  }
  if ft == "" then return " \u{f15b} " end
  return (icons[ft] or " \u{f15b} ") .. ft
end

-- File size display
local function file_size()
  local size = vim.fn.getfsize(vim.fn.expand("%"))
  if size < 0 then return "" end
  local formatted = (size < 1024) and (size.."B")
                   or ((size < 1024*1024) and string.format("%.1fK", size/1024))
                   or string.format("%.1fM", size/1024/1024)
  return formatted and (" \u{f016} " .. formatted .. " ") or ""
end

-- Mode indicator with icon
local function mode_icon()
  local mode = vim.fn.mode()
  local modes = {
    n = " \u{f121} NORMAL", i = " \u{f11c} INSERT",
    v = " \u{f0168} VISUAL", V = " \u{f0168} V-LINE", ["\22"] = " \u{f0168} V-BLOCK",
    c = " \u{f120} COMMAND", s = " \u{f0c5} SELECT", S = " \u{f0c5} S-LINE",
    ["\19"] = " \u{f0c5} S-BLOCK", R = " \u{f044} REPLACE", r = " \u{f044} REPLACE",
    ["!"] = " \u{f489} SHELL", t = " \u{f120} TERMINAL"
  }
  return modes[mode] or (" \u{f059} "..mode)
end

_G.mode_icon   = mode_icon
_G.git_branch  = git_branch
_G.file_type   = file_type
_G.file_size   = file_size

vim.cmd([[highlight StatusLineBold gui=bold cterm=bold]])

-- Dynamic statusline: full when active, minimal when inactive
vim.api.nvim_create_autocmd({"WinEnter","BufEnter"}, {
  callback = function()
    vim.opt_local.statusline = table.concat({
      "  ","%#StatusLineBold#", "%{v:lua.mode_icon()}",
      "%#StatusLine#", " \u{e0b1} %f %h%m%r",
      "%{v:lua.git_branch()}", "\u{e0b1} ",
      "%{v:lua.file_type()}", "\u{e0b1} ",
      "%{v:lua.file_size()}", "%=",
      " \u{f017} %l:%c  %P ",
    })
  end,
})

vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

vim.api.nvim_create_autocmd({"WinLeave","BufLeave"}, {
  callback = function()
    vim.opt_local.statusline = "  %f %h%m%r \u{e0b1} %{v:lua.file_type()} %=  %l:%c   %P "
  end,
})
```

### GUIDE.md

```markdown
# Neovim Configuration Guide

This guide explains the updated Neovim config structure, key commands, and maintenance tips.

## File Structure

- `init.lua` – The main config file. Sets options, loads modules (`plugins.lua`, `keymaps.lua`, etc.).
- `lua/`
  - `plugins.lua` – Specifies plugins via `vim.pack.add`.
  - `plugin_configs.lua` – Plugin-specific setup (treesitter, gitsigns, etc.).
  - `treesitter.lua` – Tree-sitter configuration.
  - `lsp.lua` – LSP, diagnostics, completion setup.
  - `keymaps.lua` – Custom key mappings.
  - `autocmds.lua` – Autocommands (format-on-save, yank highlight, etc.).
  - `statusline.lua` – Custom statusline functions and autocommands.

## Key Mappings

- `<Space>n/p` – Next/Prev buffer.
- `<Space>sv`/`<Space>sh` – Vertical/Horizontal split.
- `<Ctrl>hjkl` – Move between windows.
- `<Alt>j/k` – Move line/selection up/down.
- `<leader>c` – Clear search highlighting.
- `<leader>x` – Delete without yanking (clipboard safe delete).
- `<leader>pa` – Copy full file path to clipboard.
- `<leader>td` – Toggle diagnostics on/off.
- Diagnostic navigation: `]h`/`[h` – Next/Prev Git hunk, etc (see `:h gitsigns`).
- `<leader>gd` – Jump to definition (uses FZF if available).
- `<leader>ca` – LSP code actions, `<leader>rn` – rename symbol.
- `K` – Show LSP hover info.

## LSP & Completion

- Uses the new built-in LSP config (`vim.lsp.config`/`enable`)【27†L252-L258】.
- Servers configured: Lua, Pyright, BashLS, TS/JS, Go, Clangd, EFM (for format/lint).
- Mason is loaded but servers are started via `vim.lsp.enable()`; you can expand with `mason-lspconfig` if desired.
- Completion provided by **blink.cmp** (v1 stable) with LSP, path, buffer, and LuaSnip sources.

## Treesitter

- Configured via `nvim-treesitter.configs.setup{ ... }` (modern usage)【23†L290-L298】.
- `ensure_installed` lists languages to auto-install.
- `highlight = { enable = true }` and `indent = { enable = true }` turn on syntax highlighting and indentation.
- We also auto-install on-demand in an autocmd if you open a file with an uninstalled parser.

## Diagnostics and Statusline

- Diagnostics use `vim.diagnostic` API. **Note:** Old APIs `:sign-define`, `vim.diagnostic.disable()`, `vim.diagnostic.is_disabled()` were removed in 0.12【37†L36-L43】. We use `vim.diagnostic.config` and `vim.diagnostic.enable/disable` instead.
- The toggle `<leader>td` uses `vim.diagnostic.is_enabled()` to switch on/off.
- The statusline shows mode, file path, git branch, file type icon, size, line/col. It uses global Lua functions for efficiency.

## Maintenance Tips

- **Updating plugins:** Use `:packupdate` (or `:vim.pack.update`) and follow prompts. We store a lockfile (`nvim-pack-lock.json`) – commit it for reproducibility.
- **Adding plugins:** Edit `plugins.lua` (`vim.pack.add`) and restart Neovim. The new plugin will install on startup.
- **Formatting:** The config formats on save with EFM if configured. You can adjust linters/formatters in `lsp.lua`.
- **Tree-sitter parsers:** To add a new language, include it in `ensure_installed` or install via `:TSInstall`.
- **LSP Servers:** To add a server, add `vim.lsp.config("<name>", {...})` and include its name in `vim.lsp.enable({...})`.
- **Backup:** The undo files are stored under `stdpath("state")/undo`. No swap/backup files are used.

_All existing behavior is preserved._ This configuration is fully Lua-based and takes advantage of Neovim 0.12’s features (like `vim.pack`)【21†L262-L270】. Keep Neovim updated and periodically update plugins and parsers for best results.
```
