# 🚀 My Neovim Configuration

[![Neovim](https://img.shields.io/badge/Neovim-0.10+-green.svg)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-blue.svg)](https://lua.org/)

A modern, feature-rich Neovim configuration focused on productivity, debugging, and Go development.

## ✨ Features

- **🔌 Plugin Management**: Lazy loading with [lazy.nvim](https://github.com/folke/lazy.nvim)
- **⚡ Fast Completion**: [blink.cmp](https://github.com/Saghen/blink.cmp) for lightning-fast autocompletion
- **🔍 Advanced Search**: Multiple search backends (Snacks, FZF, Mini)
- **🐛 Full Debugging Support**: Complete DAP setup for Go, JavaScript/TypeScript, Python, C#
- **🐹 Go Development**: Comprehensive Go tooling with [go.nvim](https://github.com/ray-x/go.nvim)
- **📂 File Management**: Multiple file explorers (Oil, Neo-tree, Mini.files)
- **🎨 Beautiful UI**: GitHub theme with enhanced visual elements
- **🔧 LSP Integration**: Full Language Server Protocol support with Mason

## 📋 Prerequisites

### Required Dependencies
- **Neovim** 0.10+ (strongly recommended)
- **Git** - Version control system
- **Node.js** 18+ - For Language Servers and debuggers
- **Nerd Font** - For consistent icons (recommended: JetBrains Mono Nerd Font)

### Essential Tools
```bash
# Install via your package manager
# Ubuntu/Debian
sudo apt install ripgrep fd-find

# macOS
brew install ripgrep fd

# Arch Linux
sudo pacman -S ripgrep fd

# Windows (via Chocolatey)
choco install ripgrep fd
```

### Language-Specific Dependencies

#### Go Development
```bash
# Install Go toolchain
go install golang.org/x/tools/gopls@latest              # Language Server
go install github.com/go-delve/delve/cmd/dlv@latest     # Debugger
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest  # Linter
```

#### JavaScript/TypeScript Debugging
```bash
# Node.js debugger (auto-installed via Mason)
npm install -g js-debug-adapter
```

#### Python Development
```bash
# Python debugger
pip install debugpy
# LaTeX rendering (optional)
pip install pylatexenc
```

#### C# Development
- **.NET SDK** 6.0+ - For C# development and debugging
- **netcoredbg** - Auto-installed via Mason

### Optional Enhancements
- **Rust** - For potentially faster fuzzy matching
- **stylua** - Lua formatter (auto-installed via Mason)
- **lazygit** - Enhanced Git UI experience

## 🚀 Installation

### 1. Backup Existing Configuration
```bash
# Create timestamped backup
BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
[ -d ~/.config/nvim ] && mv ~/.config/nvim "$BACKUP_DIR"
[ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.backup.$(date +%Y%m%d_%H%M%S)
[ -d ~/.local/state/nvim ] && mv ~/.local/state/nvim ~/.local/state/nvim.backup.$(date +%Y%m%d_%H%M%S)
[ -d ~/.cache/nvim ] && mv ~/.cache/nvim ~/.cache/nvim.backup.$(date +%Y%m%d_%H%M%S)
```

### 2. Clone Configuration
```bash
git clone <your-repo-url> ~/.config/nvim
```

### 3. First Launch
```bash
nvim
```

**First Launch Process:**
1. Lazy.nvim will automatically install all plugins
2. Mason will install LSP servers, formatters, and debuggers
3. Treesitter will compile syntax parsers
4. Run `:checkhealth` to verify installation

### 4. Post-Installation Commands
```vim
:TSUpdate          " Update Treesitter parsers
:MasonInstallAll   " Install all configured tools
:GoInstallBinaries " Install Go development tools
```

## ⌨️ Key Bindings

**Leader Key:** `<Space>`

### 🌟 Essential Shortcuts

| Key               | Mode  | Description                    |
|:------------------|:------|:-------------------------------|
| `jk`              | `i`   | Exit Insert Mode               |
| `<leader><space>` | `n`   | Smart Find Files               |
| `<leader>e`       | `n`   | File Explorer                  |
| `<leader>sg`      | `n`   | Search in Files                |
| `<leader>ff`      | `n`   | Find Files (FZF)               |
| `<C-s>`           | `n,i` | Quick Save                     |
| `<leader>nh`      | `n`   | Clear Search Highlights        |

### 🐛 Debugging Commands

| Key             | Mode | Description                        |
|:----------------|:-----|:-----------------------------------|
| `<leader>dc`    | `n`  | Debug: Start/Continue              |
| `<leader>db`    | `n`  | Debug: Toggle Breakpoint           |
| `<leader>dB`    | `n`  | Debug: Conditional Breakpoint      |
| `<leader>du`    | `n`  | Debug: Toggle UI                   |
| `<leader>dsi`   | `n`  | Debug: Step Into                   |
| `<leader>dso`   | `n`  | Debug: Step Over                   |
| `<leader>dsO`   | `n`  | Debug: Step Out                    |
| `<leader>dr`    | `n`  | Debug: Run Last Configuration      |
| `<leader>dR`    | `n`  | Debug: Restart                     |
| `<leader>dt`    | `n`  | Debug: Terminate                   |
| `<leader>de`    | `n,v`| Debug: Evaluate Expression         |
| `<leader>do`    | `n`  | Debug: Open REPL                   |
| `<leader>dbc`   | `n`  | Debug: Clear All Breakpoints       |
| `<leader>dgt`   | `n`  | Debug: Go Test (current function)  |
| `<leader>dgl`   | `n`  | Debug: Go Last Test                |

### 🐹 Go Development

| Key             | Mode  | Description                |
|:----------------|:------|:---------------------------|
| `<leader>ga`    | `n`   | Alternate File             |
| `<leader>gvs`   | `n`   | Alternate Vertical Split   |
| `<leader>ghs`   | `n`   | Alternate Horizontal Split |
| `<leader>oi`    | `n`   | Organize Imports           |
| `<leader>of`    | `n`   | Go Format                  |
| `<leader>ot`    | `n`   | Go Mod Tidy                |
| `<leader>bb`    | `n`   | Build Package              |
| `<leader>br`    | `n`   | Run Package                |
| `<leader>tp`    | `n`   | Test Package               |
| `<leader>tf`    | `n`   | Test Function              |
| `<leader>tc`    | `n`   | Test Coverage              |
| `<leader>gta`   | `n,v` | Add Tags                   |
| `<leader>gtr`   | `n,v` | Remove Tags                |
| `<leader>gc`    | `n`   | Generate Comment           |
| `<leader>gs`    | `n`   | Fill Struct                |
| `<leader>gI`    | `n`   | Implement Interface        |

### 📊 LSP (Language Server Protocol)

| Key          | Mode  | Description                |
|:-------------|:------|:---------------------------|
| `gd`         | `n`   | Go to Definition           |
| `gD`         | `n`   | Go to Declaration          |
| `gr`         | `n`   | Go to References           |
| `gI`         | `n`   | Go to Implementation       |
| `<leader>ca` | `n,x` | Code Action                |
| `<leader>cr` | `n`   | Rename Symbol              |
| `K`          | `n`   | Show Hover Information     |
| `<leader>ds` | `n`   | Document Symbols           |
| `<leader>ws` | `n`   | Workspace Symbols          |
| `[d`         | `n`   | Previous Diagnostic        |
| `]d`         | `n`   | Next Diagnostic            |
| `<leader>dl` | `n`   | Open Diagnostic List       |

### 🔍 Search & Navigation

| Key          | Mode  | Description                       |
|:-------------|:------|:----------------------------------|
| `<leader>sg` | `n`   | Search in Files (Live Grep)       |
| `<leader>sb` | `n`   | Search in Buffer                   |
| `<leader>sw` | `n,x` | Search Word Under Cursor           |
| `<leader>fr` | `n`   | Recent Files                       |
| `<leader>fg` | `n`   | Find Git Files                     |
| `<leader>fo` | `n`   | Old Files                          |
| `]]`         | `n,t` | Next Reference                     |
| `[[`         | `n,t` | Previous Reference                 |
| `]t`         | `n`   | Next TODO Comment                  |
| `[t`         | `n`   | Previous TODO Comment              |

### 📂 File Management

| Key               | Mode | Description                    |
|:------------------|:-----|:-------------------------------|
| `<leader>e`       | `n`  | File Explorer (Snacks)         |
| `<leader>me`      | `n`  | Mini Files (current file)      |
| `<leader>mE`      | `n`  | Mini Files (cwd)               |
| `-`               | `n`  | Open Oil File Manager          |
| `<leader>cR`      | `n`  | Rename File                    |

### 📑 Buffer Management

| Key             | Mode | Description                          |
|:----------------|:-----|:-------------------------------------|
| `<A-,>`         | `n`  | Previous Buffer                      |
| `<A-.>`         | `n`  | Next Buffer                          |
| `<A-1>`–`<A-9>` | `n`  | Go to Buffer 1–9                     |
| `<A-0>`         | `n`  | Go to Last Buffer                    |
| `<A-p>`         | `n`  | Pin/Unpin Buffer                     |
| `<leader>bd`    | `n`  | Delete Buffer                        |
| `<leader>bo`    | `n`  | Close All But Current/Pinned         |

### 🪟 Window Management

| Key          | Mode | Description           |
|:-------------|:-----|:----------------------|
| `<C-h>`      | `n`  | Navigate Left         |
| `<C-j>`      | `n`  | Navigate Down         |
| `<C-k>`      | `n`  | Navigate Up           |
| `<C-l>`      | `n`  | Navigate Right        |
| `sh`         | `n`  | Split Horizontally    |
| `sv`         | `n`  | Split Vertically      |
| `<leader>sx` | `n`  | Close Current Split   |

### 📚 Git Operations

| Key          | Mode  | Description             |
|:-------------|:------|:------------------------|
| `<leader>gs` | `n`   | Git Status              |
| `<leader>gb` | `n`   | Git Branches            |
| `<leader>gl` | `n`   | Git Log                 |
| `<leader>gd` | `n`   | Git Diff Hunks          |
| `<leader>gg` | `n`   | Open Lazygit            |
| `<leader>gn` | `n`   | Open Neogit             |

### 💻 Terminal

| Key          | Mode | Description                        |
|:-------------|:-----|:-----------------------------------|
| `<C-\>`      | `n`  | Toggle Terminal                    |
| `<leader>tt` | `n`  | Toggle Terminal (Floating)         |
| `<leader>th` | `n`  | Toggle Terminal (Horizontal)       |
| `<leader>tv` | `n`  | Toggle Terminal (Vertical)         |

## 🔌 Plugin Ecosystem

### Core Framework
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager with lazy loading
- **[Snacks.nvim](https://github.com/folke/snacks.nvim)** - Collection of useful utilities

### 🚀 Completion & LSP
- **[blink.cmp](https://github.com/Saghen/blink.cmp)** - Fast completion engine
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configurations
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - Tool installer
- **[fidget.nvim](https://github.com/j-hui/fidget.nvim)** - LSP progress UI

### 🐛 Debugging
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)** - Debug Adapter Protocol
- **[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)** - Beautiful debugging UI
- **[nvim-dap-go](https://github.com/leoluz/nvim-dap-go)** - Go debugging support
- **[nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)** - Inline variable display

### 📂 File Management
- **[oil.nvim](https://github.com/stevearc/oil.nvim)** - File explorer as buffer
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - Modern file tree
- **[mini.files](https://github.com/echasnovski/mini.files)** - Minimal file navigation
- **[fzf-lua](https://github.com/ibhagwan/fzf-lua)** - Fuzzy finder

### ⚡ Syntax & Editing
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Advanced syntax highlighting
- **[render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)** - Enhanced Markdown
- **[mini.nvim](https://github.com/echasnovski/mini.nvim)** - Modular utilities

### 🐹 Go Development
- **[go.nvim](https://github.com/ray-x/go.nvim)** - Complete Go development suite
- **[guihua.lua](https://github.com/ray-x/guihua.lua)** - GUI library for go.nvim

### 🎨 UI & Theme
- **[github-nvim-theme](https://github.com/projekt0n/github-nvim-theme)** - GitHub theme
- **[barbar.nvim](https://github.com/romgrk/barbar.nvim)** - Enhanced tabline

### 🔧 Git Integration
- **[neogit](https://github.com/NeogitOrg/neogit)** - Magit-like Git interface
- **[diffview.nvim](https://github.com/sindrets/diffview.nvim)** - Git diff interface

## 🐛 Debugging Setup

This configuration includes comprehensive debugging support for multiple languages:

### Supported Languages
- **Go** - Full debugging with Delve
- **JavaScript/TypeScript** - Node.js and browser debugging
- **Python** - Python debugger integration
- **C#** - .NET Core debugging

### Debug Features
- **Breakpoints** - Set, remove, and manage breakpoints
- **Variable Inspection** - Inline variable values and watch expressions
- **Step Debugging** - Step into, over, and out of functions
- **REPL** - Interactive debugging console
- **Launch Configurations** - Support for `.vscode/launch.json`
- **UI Integration** - Beautiful debugging interface

### Debug Configuration Files
The debugger supports `.vscode/launch.json` files for project-specific configurations.

## 🔧 Configuration Issues Fixed

### Issues Identified and Resolved:

1. **DAP Configuration** (`paste-2.txt`):
   - ✅ Added proper Mason path detection for debuggers
   - ✅ Enhanced Go debugging with fallback delve detection
   - ✅ Improved JavaScript/TypeScript browser debugging
   - ✅ Added proper sign definitions for breakpoints
   - ✅ Fixed launch.json integration

2. **Go Configuration** (`paste-3.txt`):
   - ✅ Added proper blink.cmp integration check
   - ✅ Enhanced LSP configuration with gopls settings
   - ✅ Added comprehensive Go-specific keymaps
   - ✅ Improved auto-formatting on save
   - ✅ Added proper error handling and notifications

3. **README Structure**:
   - ✅ Reorganized for better readability
   - ✅ Added debugging section with comprehensive shortcuts
   - ✅ Enhanced installation instructions
   - ✅ Added troubleshooting section
   - ✅ Improved plugin descriptions

## 🛠️ Troubleshooting

### Common Issues

**Plugin Installation Fails**
```bash
# Clear plugin cache and reinstall
rm -rf ~/.local/share/nvim
nvim --headless +q
nvim
```

**LSP Not Working**
```vim
:LspInfo          " Check LSP status
:Mason            " Verify tools installation
:checkhealth lsp  " Diagnose LSP issues
```

**Go Tools Missing**
```vim
:GoInstallBinaries  " Install Go development tools
:checkhealth go     " Check Go setup
```

**Debugger Issues**
```vim
:checkhealth dap    " Check DAP configuration
:Mason              " Verify debugger installation
```

### Health Checks
```vim
:checkhealth        " General health check
:checkhealth lsp    " LSP-specific check
:checkhealth dap    " Debug adapter check
:checkhealth go     " Go tooling check
```

## 📋 TODO

- [ ] Add more language-specific debugging configurations
- [ ] Integrate AI-powered code completion
- [ ] Add project templates
- [ ] Enhance terminal integration
- [ ] Add custom snippets

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Test your changes thoroughly
4. Submit a pull request

## 📄 License

This configuration is available under the MIT License. See LICENSE file for details.

---

**Note**: This configuration is optimized for development productivity. Customize keybindings and settings according to your workflow preferences.
