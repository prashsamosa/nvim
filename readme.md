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

## ⌨️ Key Bindings

**Leader Key:** `<Space>`

### 🌟 Essential Shortcuts

| Key               | Mode  | Description                    |
|:------------------|:------|:-------------------------------|
| `jk`              | `i`   | Exit Insert Mode               |
| `<leader><space>` | `n`   | Smart Find Files               |
| `<leader>e`       | `n`   | File Explorer (NvimTree)       |
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
| `<leader>gG`    | `n`   | Go Generate                |
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

### 📂 File Management with NvimTree

| Key               | Mode | Description                        |
|:------------------|:-----|:-----------------------------------|
| `<leader>e`       | `n`  | Toggle NvimTree File Explorer      |

#### 🌳 NvimTree Navigation

| Key       | Mode | Description (within NvimTree)           |
|:----------|:-----|:---------------------------------------|
| `q`       | `n`  | Close NvimTree                         |
| `<CR>`    | `n`  | Open file or toggle directory          |
| `o`       | `n`  | Open file or toggle directory          |
| `<C-v>`   | `n`  | Open file in vertical split            |
| `<C-x>`   | `n`  | Open file in horizontal split          |
| `<C-t>`   | `n`  | Open file in new tab                   |
| `<Tab>`   | `n`  | Preview file                           |
| `I`       | `n`  | Toggle dotfiles visibility             |
| `H`       | `n`  | Toggle hidden files                    |
| `R`       | `n`  | Refresh NvimTree                       |
| `a`       | `n`  | Create new file/directory              |
| `d`       | `n`  | Delete file/directory                  |
| `r`       | `n`  | Rename file/directory                  |
| `x`       | `n`  | Cut file/directory                     |
| `c`       | `n`  | Copy file/directory                    |
| `p`       | `n`  | Paste file/directory                   |
| `y`       | `n`  | Copy name to clipboard                 |
| `Y`       | `n`  | Copy relative path to clipboard        |
| `gy`      | `n`  | Copy absolute path to clipboard        |
| `s`       | `n`  | Open with system default application   |
| `W`       | `n`  | Collapse all directories               |
| `E`       | `n`  | Expand all directories                 |
| `P`       | `n`  | Go to parent directory                 |
| `K`       | `n`  | Go to first sibling                    |
| `J`       | `n`  | Go to last sibling                     |
| `m`       | `n`  | Toggle bookmark                        |
| `F`       | `n`  | Live filter (search)                   |
| `<C-k>`   | `n`  | Show file info                         |
| `g?`      | `n`  | Show help                              |

#### 🔖 NvimTree File Operations
- **Create**: Press `a`, then enter filename (add `/` at end for directory)
- **Delete**: Press `d` to delete selected file/directory
- **Rename**: Press `r` to rename file/directory
- **Copy/Cut/Paste**: Use `c`, `x`, `p` respectively
- **Live Filter**: Press `F` and start typing to filter files

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

## 🌳 NvimTree Features

### Visual Enhancements
- **Git Integration**: Shows git status icons for files and directories
- **Diagnostics**: Displays LSP diagnostic icons next to files with issues
- **Transparent Background**: Integrates seamlessly with your colorscheme
- **Custom Icons**: Uses Nerd Font icons for better visual distinction
- **Syntax Highlighting**: Folder and file names are color-coded

### Advanced Features
- **Live Filter**: Press `F` in NvimTree and start typing to filter files
- **Window Picker**: When opening files, intelligently picks the best window
- **Auto Resize**: Automatically adjusts window size when opening files
- **Bookmarks**: Toggle bookmarks on frequently accessed files/directories
- **System Integration**: Open files with system default applications using `s`

### File Operations
- **Smart Creation**: Create files and directories with `a` (add `/` for directories)
- **Safe Deletion**: Delete files with confirmation prompts
- **Clipboard Integration**: Copy file paths to system clipboard
- **Batch Operations**: Cut, copy, and paste multiple files

### Customization
- **Sorting**: Files are sorted by name with folders first
- **Custom Filters**: Excludes system files like `.DS_Store` and `thumbs.db`
- **Git Aware**: Respects `.gitignore` files and shows git status
- **Diagnostic Integration**: Shows LSP errors, warnings, and hints

## 📝 Mode Legend

- `n` = Normal mode
- `i` = Insert mode
- `v` = Visual mode
- `x` = Visual mode (character-wise)
- `t` = Terminal mode

## 🚀 Quick Start Guide

1. **File Navigation**: Use `<leader><space>` for quick file finding or `<leader>e` for NvimTree explorer
2. **File Management**: Use `<leader>e` to open NvimTree, then use `a` to create, `d` to delete, `r` to rename files
3. **Code Navigation**: Use `gd` for definitions, `gr` for references
4. **Debugging**: Start with `<leader>db` to set breakpoints, then `<leader>dc` to start debugging
5. **Go Development**: Use `<leader>ga` to switch between files, `<leader>tp` to run tests
6. **Search**: Use `<leader>sg` for project-wide search or `F` in NvimTree for file filtering
7. **Git**: Use `<leader>gg` for Lazygit or individual git commands

## 💡 Tips

- **Leader Key Sequences**: Most commands start with `<leader>` (Space key)
- **Go Development**: All Go-specific commands are prefixed with `g` after leader
- **Debugging**: All debug commands are prefixed with `d` after leader
- **Terminal**: Use `<C-\>` for quick terminal toggle
- **Buffer Navigation**: Use `Alt` + `,` and `.` for quick buffer switching
- **NvimTree**: Use `<leader>e` for file explorer, `F` for filtering, and `g?` for help
- **File Operations**: In NvimTree, use `a` for create, `d` for delete, `r` for rename
- **Git Integration**: NvimTree shows git status; use different colors for modified, staged, and untracked files
- **Diagnostics**: LSP errors and warnings appear as icons in NvimTree next to affected files

## 🔧 NvimTree Configuration Highlights

- **Auto-reload**: Files are automatically refreshed when changed externally
- **Git Integration**: Full git status integration with custom icons
- **Diagnostics**: LSP diagnostic integration with severity-based icons
- **Custom Filtering**: System files are hidden, but dotfiles are visible by default
- **Window Management**: Smart window picking when opening files
- **Transparency**: Seamless integration with transparent colorschemes
- **Performance**: Optimized for large directories and git repositories
