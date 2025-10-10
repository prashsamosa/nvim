## 📁 Directory Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── .luacheckrc                # Luacheck configuration
├── .luarc.json                # Lua language server config
├── lsp/                       # 🆕 Native LSP server configs (Neovim 0.11+)
│   ├── lua_ls.lua             # Lua language server
│   ├── pyright.lua            # Python language server
│   ├── gopls.lua              # Go language server
│   ├── ts_ls.lua              # TypeScript/JavaScript server
│   ├── jsonls.lua             # JSON language server
│   ├── bashls.lua             # Bash language server
│   ├── clangd.lua             # C/C++ language server
│   ├── dockerls.lua           # Docker language server
│   ├── emmet_ls.lua           # Emmet language server
│   ├── yamlls.lua             # YAML language server
│   ├── tailwindcss.lua        # Tailwind CSS server
│   └── efm.lua                # EFM (formatters/linters)
└── lua/
    ├── config/                # Core configuration
    │   ├── autocmds.lua       # Auto-commands
    │   ├── globals.lua        # Global variables
    │   ├── keymaps.lua        # Key mappings
    │   ├── lazy.lua           # Plugin manager setup
    │   ├── lsp.lua            # 🆕 Native LSP initialization
    │   └── options.lua        # Neovim options
    ├── plugins/               # Plugin configurations
    │   ├── lsp-dependencies.lua # 🆕 Mason & EFM configs
    │   ├── [plugin-name].lua  # Individual plugin configs
    │   └── ...
    └── utils/                 # Utility modules
        └── diagnostics.lua   # Diagnostic configuration
```

## 🎯 What's New in This Config

This configuration uses **Neovim 0.11+ native LSP** features:
- ✅ No `nvim-lspconfig` plugin dependency
- ✅ LSP configs in `lsp/` folder (native format)
- ✅ Uses `vim.lsp.enable()` and `vim.lsp.config()` APIs
- ✅ Faster startup and better performance
- ✅ Future-proof with core Neovim APIs

## ⚙️ Core Configuration

### Leader Keys

- **Leader**: `<Space>`
- **Local Leader**: `<Space>`

### Key Mappings

#### Navigation & Movement

| Key           | Mode   | Action                             |
| ------------- | ------ | ---------------------------------- |
| `<C-h/j/k/l>` | Normal | Navigate windows                   |
| `<C-d>/<C-u>` | Normal | Half page up/down (centered)       |
| `n/N`         | Normal | Next/prev search result (centered) |

#### Buffer & File Management

| Key             | Mode   | Action               |
| --------------- | ------ | -------------------- |
| `<leader>e`     | Normal | Toggle file explorer |
| `<leader>m`     | Normal | Focus file explorer  |
| `<leader>bn/bp` | Normal | Next/previous buffer |
| `<leader>rc`    | Normal | Edit config file     |

#### Fuzzy Finding (FZF)

| Key             | Mode   | Action                     |
| --------------- | ------ | -------------------------- |
| `<leader>ff`    | Normal | Find files                 |
| `<leader>fg`    | Normal | Live grep                  |
| `<leader>fb`    | Normal | Find buffers               |
| `<leader>fh`    | Normal | Help tags                  |
| `<leader>fs/fS` | Normal | Document/workspace symbols |

#### LSP Operations

| Key          | Mode   | Action                                |
| ------------ | ------ | ------------------------------------- |
| `<leader>gd` | Normal | LSP finder (definitions + references) |
| `<leader>gD` | Normal | Go to definition                      |
| `<leader>gS` | Normal | Go to definition in split             |
| `<leader>gr` | Normal | Show references                       |
| `<leader>gi` | Normal | Go to implementation                  |
| `<leader>gt` | Normal | Go to type definition                 |
| `<leader>ca` | Normal | Code actions                          |
| `<leader>rn` | Normal | Rename symbol                         |
| `<leader>oi` | Normal | Organize imports                      |
| `K`          | Normal | Hover documentation                   |

#### Diagnostics

| Key             | Mode   | Action                          |
| --------------- | ------ | ------------------------------- |
| `<leader>d`     | Normal | Show diagnostics (cursor)       |
| `<leader>D`     | Normal | Show diagnostics (line)         |
| `<leader>nd/pd` | Normal | Next/previous diagnostic        |
| `<leader>xx`    | Normal | Workspace diagnostics (Trouble) |
| `<leader>xX`    | Normal | Buffer diagnostics (Trouble)    |

#### Window Management

| Key              | Mode   | Action                        |
| ---------------- | ------ | ----------------------------- |
| `<leader>sv/sh`  | Normal | Split vertically/horizontally |
| `<C-Up/Down>`    | Normal | Resize height                 |
| `<C-Left/Right>` | Normal | Resize width                  |

## 🔧 LSP Servers

Configured language servers (installed via Mason):

- **Lua**: lua-language-server
- **Python**: pyright
- **Go**: gopls
- **TypeScript/JavaScript**: typescript-language-server
- **JSON**: vscode-json-language-server
- **Bash**: bash-language-server
- **C/C++**: clangd
- **Docker**: dockerfile-language-server-nodejs
- **Emmet**: emmet-ls
- **YAML**: yaml-language-server
- **Tailwind CSS**: tailwindcss-language-server
- **Formatters/Linters**: efm-langserver

## 📦 Plugin Management

This config uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

Key commands:
- `:Lazy` - Open plugin manager
- `:Lazy sync` - Install/update/clean plugins
- `:Lazy check` - Check for plugin updates

## 🛠️ Mason (LSP/Formatter/Linter Installer)

Use Mason to install language servers, formatters, and linters:

```vim
:Mason
```

Within Mason:
- `i` - Install package
- `U` - Update package
- `X` - Uninstall package
- `g?` - Help

## 🔍 Diagnostics & Troubleshooting

Check LSP status:
```vim
:LspInfo         " Show attached LSP clients
:LspLog          " View LSP logs
:checkhealth lsp " Check LSP health
```

## 📝 Adding a New LSP Server

1. Create config file: `~/.config/nvim/lsp/<server_name>.lua`
```lua
return {
  cmd = { 'language-server-command', '--stdio' },
  filetypes = { 'filetype' },
  root_markers = { 'project-marker', '.git' },
  settings = {},
}
```

2. Enable it in `lua/config/lsp.lua`:
```lua
vim.lsp.enable({
  'lua_ls',
  'your_new_server',  -- Add here
  -- ... other servers
})
```

3. Install via Mason: `:Mason`

## 🎨 Theme

Using [material.nvim](https://github.com/marko-cerovac/material.nvim) with the "darker" variant.

## 🚀 Performance

Optimizations enabled:
- Global statusline
- Lazy loading for most plugins
- Treesitter-based folding
- Native LSP (no plugin overhead)

## 📚 Additional Resources

- [Neovim LSP Documentation](https://neovim.io/doc/user/lsp.html)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/mason-org/mason.nvim)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

---

**Note**: This config requires Neovim 0.11+ for native LSP support.
