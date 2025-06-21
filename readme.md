# 🚀 My Neovim Configuration

[![Neovim](https://img.shields.io/badge/Neovim-0.10+-green.svg)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-blue.svg)](https://lua.org/)


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

### Optional Enhancements
- **Rust** - For potentially faster fuzzy matching
- **stylua** - Lua formatter (auto-installed via Mason)
- **lazygit** - Enhanced Git UI experience


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

# 🚀 Neovim Configuration

# 🚀 Neovim Configuration

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
| `<leader>gx`    | `n`   | Run Current File           |
| `<leader>tp`    | `n`   | Test Package               |
| `<leader>tf`    | `n`   | Test Function              |
| `<leader>tF`    | `n`   | Test File                  |
| `<leader>tc`    | `n`   | Test Coverage              |
| `<leader>tC`    | `n`   | Toggle Coverage            |
| `<leader>gta`   | `n,v` | Add Tags                   |
| `<leader>gtr`   | `n,v` | Remove Tags                |
| `<leader>gat`   | `n`   | Add Test                   |
| `<leader>get`   | `n`   | Add Example Test           |
| `<leader>gc`    | `n`   | Generate Comment           |
| `<leader>gs`    | `n`   | Fill Struct                |
| `<leader>gr`    | `n`   | Generate Return            |
| `<leader>gj`    | `n`   | JSON to Struct             |
| `<leader>gI`    | `n`   | Implement Interface        |
| `<leader>gg`    | `n`   | Go Generate                |
| `<leader>gm`    | `n`   | Generate Mocks             |
| `<leader>gL`    | `n`   | Go Lint                    |
| `<leader>gV`    | `n`   | Go Vet                     |
| `<leader>gD`    | `n`   | Go Doc                     |
| `<leader>gDb`   | `n`   | Go Doc Browser             |
| `<leader>gcb`   | `n`   | Coverage Browser           |

### 📊 LSP (Language Server Protocol)

| Key          | Mode  | Description                |
|:-------------|:------|:---------------------------|
| `gd`         | `n`   | Go to Definition           |
| `gD`         | `n`   | Go to Declaration          |
| `gr`         | `n`   | Go to References           |
| `gI`         | `n`   | Go to Implementation       |
| `<leader>D`  | `n`   | Type Definition            |
| `<leader>ca` | `n,x` | Code Action                |
| `<leader>cr` | `n`   | Rename Symbol              |
| `K`          | `n`   | Show Hover Information     |
| `<C-k>`      | `i`   | Signature Help             |
| `<leader>ds` | `n`   | Document Symbols           |
| `<leader>ws` | `n`   | Workspace Symbols          |
| `<leader>ih` | `n`   | Toggle Inlay Hints         |
| `<leader>cl` | `n`   | Run Code Lens              |
| `[d`         | `n`   | Previous Diagnostic        |
| `]d`         | `n`   | Next Diagnostic            |
| `<leader>dl` | `n`   | Open Diagnostic List       |
| `<leader>dq` | `n`   | Open Diagnostic Quickfix   |

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

### ⚙️ General Editing

| Key          | Mode  | Description             |
|:-------------|:------|:------------------------|
| `<leader>w`  | `n`   | Save File               |
| `<leader>q`  | `n`   | Quit                    |
| `<leader>Q`  | `n`   | Quit All                |
| `<leader>x`  | `n`   | Save and Quit           |
| `<C-a>`      | `n`   | Select All              |
| `<leader>y`  | `n,v` | Copy to System Clipboard|
| `<leader>p`  | `n,v` | Paste from System Clipboard|

### 🔧 Configuration

| Key          | Mode | Description                   |
|:-------------|:-----|:------------------------------|
| `<leader>L`  | `n`  | Open Lazy (Plugin Manager)    |
| `<leader>M`  | `n`  | Open Mason (Tool Installer)   |
| `<leader>c`  | `n`  | Open Config Directory         |

## 📝 Mode Legend

- `n` = Normal mode
- `i` = Insert mode
- `v` = Visual mode
- `x` = Visual mode (character-wise)
- `t` = Terminal mode

## 🚀 Quick Start Guide

1. **File Navigation**: Use `<leader><space>` for quick file finding
2. **Code Navigation**: Use `gd` for definitions, `gr` for references
3. **Debugging**: Start with `<leader>db` to set breakpoints, then `<leader>dc` to start debugging
4. **Go Development**: Use `<leader>ga` to switch between files, `<leader>tp` to run tests
5. **Search**: Use `<leader>sg` for project-wide search
6. **Git**: Use `<leader>gg` for Lazygit or individual git commands

## 💡 Tips

- **Leader Key Sequences**: Most commands start with `<leader>` (Space key)
- **Go Development**: All Go-specific commands are prefixed with `g` after leader
- **Debugging**: All debug commands are prefixed with `d` after leader
- **Terminal**: Use `<C-\>` for quick terminal toggle
- **Buffer Navigation**: Use `Alt` + `,` and `.` for quick buffer switching



































































