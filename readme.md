# 🚀 Neovim Configuration

A comprehensive, modern Neovim configuration designed to provide a powerful, efficient, and aesthetically pleasing development environment. This setup leverages a curated plugin ecosystem to enhance coding, debugging, and Git workflows.

## 📦 Prerequisites

### 🔧 Core Requirements

- **Neovim** (v0.10.0 or later)
- **Git** - For version control and plugin management
- **Node.js** (v18+) - Essential for Language Servers and debugging adapters
- **Nerd Font** - A patched font (e.g., JetBrains Mono Nerd Font) for proper icon display

### 🔍 Essential CLI Tools

```bash
# Debian/Ubuntu
sudo apt install ripgrep fd-find
```

### 🐹 Go Development

```bash
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

### 🧠 JavaScript/TypeScript Development

```bash
npm install -g js-debug-adapter
```

### 🐍 Python Development

```bash
pip install debugpy pylatexenc
```

### ✨ Optional Enhancements

- **stylua** - Lua formatter (auto-installed by Mason)
- **lazygit** - Terminal UI for Git
- **rust** - For faster fzf-lua performance

## 🚀 Installation

1. **Clone the repository:**
   ```bash
   git clone <your-config-repo-url> ~/.config/nvim
   ```

2. **Launch Neovim:**
   ```bash
   nvim
   ```

3. **Automatic setup:**
   - Lazy.nvim will bootstrap and install plugins
   - Mason will install Language Servers and tools
   - Treesitter will compile syntax parsers

4. **Verify installation:**
   ```vim
   :checkhealth
   ```

### 🔄 Manual Commands (if needed)

```vim
:TSUpdate              " Update Treesitter parsers
:MasonInstallAll       " Install all Mason tools
:GoInstallBinaries     " Install Go binaries
```

## 🔌 Plugin Architecture

### Core Stack

- **[Lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager with lazy loading
- **[GitHub Theme](https://github.com/projekt0n/github-nvim-theme)** - Consistent dark theme
- **[Lualine](https://github.com/nvim-lualine/lualine.nvim)** - Clean statusline
- **[Which-key](https://github.com/folke/which-key.nvim)** - Keybinding discovery
- **[Mini.nvim](https://github.com/echasnovski/mini.nvim)** - Collection of small, efficient plugins

### LSP & Completion

- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP integration
- **[Mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP server management
- **[Blink.cmp](https://github.com/saghen/blink.cmp)** - Completion engine
- **[go.nvim](https://github.com/ray-x/go.nvim)** - Go development tools
- **[SchemaStore](https://github.com/b0o/schemastore.nvim)** - JSON/YAML schema validation

### File Management

- **[nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)** - Tree-style file explorer
- **[Oil.nvim](https://github.com/stevearc/oil.nvim)** - Buffer-based file explorer
- **[Barbar.nvim](https://github.com/romgrk/barbar.nvim)** - Enhanced buffer tabs

### Version Control

- **[Neogit](https://github.com/NeogitOrg/neogit)** - Comprehensive Git client
- **[Gitsigns](https://github.com/lewis6991/gitsigns.nvim)** - Git status indicators

### Debugging

- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)** - Debug Adapter Protocol
- **[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)** - Debug UI
- **[nvim-dap-go](https://github.com/leoluz/nvim-dap-go)** - Go debugging
- **[nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)** - Inline debug info

### Utilities

- **[fzf-lua](https://github.com/ibhagwan/fzf-lua)** - Fast fuzzy finder
- **[Conform.nvim](https://github.com/stevearc/conform.nvim)** - Code formatting
- **[Snacks.nvim](https://github.com/folke/snacks.nvim)** - Useful utilities
- **[Todo Comments](https://github.com/folke/todo-comments.nvim)** - Highlight TODO comments
- **[ToggleTerm](https://github.com/akinsho/toggleterm.nvim)** - Terminal management
- **[vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)** - Database interface

## ⌨️ Keybindings

**Leader key:** `<Space>`

### 🌟 General

| Key | Mode | Action |
|-----|------|--------|
| `jk` | Insert | Exit Insert Mode |
| `<leader>nh` | Normal | Clear Search Highlights |
| `<leader><space>` | Normal | Fuzzy Find Files |
| `<leader>+` | Normal | Increment Number |
| `<C-a>` | Normal | Select All |
| `<leader>L` | Normal | Open Lazy Plugin Manager |

### 🧭 Navigation & Search (fzf-lua)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find Files |
| `<leader>fc` | Find in Config Directory |
| `<leader>fg` | Live Grep |
| `<leader>f/` | Grep Current Buffer |
| `<leader>fo` | Recent Files |
| `<leader>f<space>` | Open Buffers |
| `<leader>fb` | Commands |
| `<leader>fw` | Find Word Under Cursor |
| `<leader>fh` | Help Tags |
| `<leader>fk` | Keymaps |
| `<leader>fd` | Diagnostics |
| `<leader>fr` | Resume Last Search |

### 📂 File Explorers

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle NvimTree |
| `-` | Open Oil (floating) |

### 🗂 Buffer Management

| Key | Action |
|-----|--------|
| `<A-,>` / `<A-.>` | Previous/Next Buffer |
| `<A-S-,>` / `<A-S-.>` | Move Buffer Left/Right |
| `<A-1>`–`<A-9>` | Jump to Buffer 1-9 |
| `<leader>bc` | Close Current Buffer |
| `<leader>bo` | Close All But Current |
| `<leader>bd` | Delete Buffer |

### ⚙️ LSP & Code Actions

| Key | Action |
|-----|--------|
| `gd` | Go to Definition |
| `gD` | Go to Declaration |
| `gr` | Go to References |
| `gI` | Go to Implementation |
| `<leader>td` | Type Definition |
| `<leader>ca` | Code Action |
| `<leader>cr` | Rename Symbol |
| `K` | Hover Documentation |
| `<leader>ds` | Document Symbols |
| `<leader>ws` | Workspace Symbols |
| `<leader>ih` | Toggle Inlay Hints |
| `[d` / `]d` | Previous/Next Diagnostic |

### 🪟 Window Management

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate Windows |
| `sh` | Horizontal Split |
| `sv` | Vertical Split |
| `<leader>z` | Toggle Zen Mode |
| `<leader>Z` | Zoom Current Window |

### 📚 Git Operations

| Key | Action |
|-----|--------|
| `<leader>gn` | Open Neogit |
| `<leader>gs` | Git Status |
| `<leader>gb` | Git Branches |
| `<leader>gl` | Git Log |
| `<leader>gd` | Git Diff |
| `<leader>gg` | Open Lazygit |

### 🧪 Debugging (DAP)

| Key | Action |
|-----|--------|
| `<leader>Dc` | Start/Continue Debug |
| `<leader>Dsi` | Step Into |
| `<leader>DsO` | Step Over |
| `<leader>Dso` | Step Out |
| `<leader>Db` | Toggle Breakpoint |
| `<leader>DB` | Conditional Breakpoint |
| `<leader>Dt` | Toggle Debug UI |

### 💻 Terminal

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle Terminal |
| `<leader>tt` | Toggle Floating Terminal |
| `<leader>th` | Toggle Horizontal Terminal |
| `<leader>tv` | Toggle Vertical Terminal |

### 🗄️ Database Operations

| Key | Action |
|-----|--------|
| `<leader>Do` | Open DB UI |
| `<leader>Du` | Toggle DB UI |
| `<leader>DCc` | Close DB UI |
| `<leader>Dr` | Find DB Buffer |

### 🐹 Go Development

| Key | Action |
|-----|--------|
| `<leader>ga` | Alternate File |
| `<leader>gx` | Run Current File |
| `<leader>oi` | Organize Imports |
| `<leader>ot` | Go Mod Tidy |
| `<leader>bb` | Build Package |
| `<leader>br` | Run Package |
| `<leader>tp/tf/tF` | Test Package/Func/File |
| `<leader>tc` | Show Test Coverage |
| `<leader>gta/gtr` | Add/Remove Struct Tags |
| `<leader>gc` | Generate Comment |
| `<leader>gs` | Fill Struct |
| `<leader>gI` | Implement Interface |

### 🔧 Mini Plugins

| Key | Action |
|-----|--------|
| `gcc` | Comment Line |
| `gc` | Comment Selection (Visual) |
| `sa` | Surround Add |
| `sd` | Surround Delete |
| `sr` | Surround Replace |
| `<leader>ms` | Write Session |
| `<leader>mr` | Read Last Session |

### 🎛 Toggle Options

| Key | Action |
|-----|--------|
| `<leader>us` | Toggle Spelling |
| `<leader>uw` | Toggle Wrap |
| `<leader>uL` | Toggle Relative Numbers |
| `<leader>ud` | Toggle Diagnostics |
| `<leader>ul` | Toggle Line Numbers |
| `<leader>ub` | Toggle Dark/Light Theme |

## 💡 Troubleshooting

### Keybinding Conflicts
If you encounter unexpected behavior:
```vim
:verbose map <keybinding>
```
This shows which plugin defines the mapping.

### File Explorer Conflicts
- **Primary nvim-tree**: Set `oil.lua`'s `default_file_explorer = false`
- **Primary oil**: Comment out nvim-tree in `lazy.lua`

### Icon Issues
If icons are missing, temporarily disable `mini.icons` to test if it conflicts with `nvim-web-devicons`.

### Indentation Problems
1. Check if language parser is installed: `:TSInstall <language>`
2. Verify `indent = { enable = true }` in treesitter config
3. Review global `vim.opt` settings

## 🤝 Contributing

Feel free to open issues or pull requests for:
- Bug fixes
- Feature suggestions
- Documentation improvements
- Performance optimizations

## 📄 License

This configuration is provided as-is for educational and personal use.
