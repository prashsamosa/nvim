# 🚀 Neovim Configuration

---

## 📦 Prerequisites

### 🔧 Core Requirements

* **Neovim** 0.10+
* **Git** (version control)
* **Node.js** 18+ (LSPs and debugging)
* **Nerd Font** (e.g. JetBrains Mono Nerd Font)

### 🔍 Essential Tools

```bash
# Ubuntu/Debian example
sudo apt install ripgrep fd-find
```

### 🐹 Go Development

```bash
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

### 🧠 JavaScript / TypeScript

```bash
npm install -g js-debug-adapter
```

### 🐍 Python

```bash
pip install debugpy pylatexenc
```

### ✨ Optional Enhancements

* `stylua` - Lua formatter (auto-installed)
* `lazygit` - Git UI
* `rust` - Optional dependency for faster FZF

### 🛠 First Launch

1. Plugins auto-installed via Lazy.nvim
2. Mason installs all tools
3. Treesitter compiles all parsers
4. Verify with `:checkhealth`

### 🔄 Post-Install

```vim
:TSUpdate
:MasonInstallAll
:GoInstallBinaries
```

---

## 🔌 Plugin Architecture

### Core Plugin Stack

- **📂 File Management**: Mini.files (file explorer) + Snacks.picker (fuzzy finder)
- **🗂 Buffer Management**: Barbar.nvim (enhanced bufferline)
- **🎨 UI Framework**: Snacks.nvim (notifications, dashboard, pickers)
- **⚡ Mini Ecosystem**: Mini.nvim suite (AI, surround, pairs, comment, etc.)
- **🌳 Syntax**: Treesitter + LSP integration
- **🐛 Debugging**: DAP with language-specific adapters
- **🗄️ Database**: vim-dadbod-ui for database management

### Key Features

- **Smart Dashboard**: Custom ASCII art with quick actions
- **Enhanced Bufferline**: Visual buffer tabs with git status
- **File Explorer**: Mini.files with GitHub-themed colors
- **Fuzzy Finding**: Snacks.picker for files, grep, git operations
- **Session Management**: Auto-save/restore with Mini.sessions
- **Zen Mode**: Distraction-free coding environment
- **Database UI**: Interactive database management with vim-dadbod

---

## ⌨️ Keybindings Overview

**Leader key:** `<Space>`

### 🌟 Essential Shortcuts

| Key               | Mode  | Description                    |
|:------------------|:------|:-------------------------------|
| `jk`              | `i`   | Exit Insert Mode               |
| `<leader><space>` | `n`   | Smart Find Files               |
| `<leader>me`      | `n`   | Toggle Mini File Explorer      |
| `<leader>ff`      | `n`   | Find Files (Snacks)           |
| `<leader>sg`      | `n`   | Search in Files                |
| `<C-s>`           | `n,i` | Quick Save                     |
| `<leader>nh`      | `n`   | Clear Search Highlights        |

### 🧭 Navigation & Search

| Key               | Mode  | Action                         |
|:------------------|:------|:-------------------------------|
| `<leader><space>` | `n`   | Smart Find Files (Snacks)     |
| `<leader>me`      | `n`   | Toggle Mini File Explorer      |
| `<leader>mE`      | `n`   | Open Mini Files at Current     |
| `<leader>ff`      | `n`   | Find Files                     |
| `<leader>fg`      | `n`   | Find Git Files                 |
| `<leader>fr`      | `n`   | Recent Files                   |
| `<leader>fc`      | `n`   | Find Config File               |
| `<leader>fp`      | `n`   | Projects                       |
| `<leader>mp`      | `n`   | Mini Pick Files                |
| `<leader>mg`      | `n`   | Mini Grep Live                 |
| `<leader>sb`      | `n`   | Search Buffer Lines            |
| `<leader>sB`      | `n`   | Grep Open Buffers              |
| `<leader>sw`      | `n,x` | Search Word Under Cursor       |
| `]] / [[`         | `n,t` | Next / Prev Reference          |

### 📂 Mini File Explorer

| Key       | Mode | Description (within Mini.files)        |
|:----------|:-----|:---------------------------------------|
| `q`       | `n`  | Close Mini Files                       |
| `l / L`   | `n`  | Go in / Go in plus                     |
| `h / H`   | `n`  | Go out / Go out plus                   |
| `<C-s>`   | `n`  | Split horizontal                       |
| `<C-v>`   | `n`  | Split vertical                         |
| `<C-t>`   | `n`  | Open in new tab                        |
| `g.`      | `n`  | Toggle dotfiles                        |
| `g~`      | `n`  | Set CWD to current directory           |
| `gy`      | `n`  | Yank path to clipboard                 |
| `gx`      | `n`  | Open with system default               |
| `m`       | `n`  | Mark set                               |
| `'`       | `n`  | Mark goto                              |
| `=`       | `n`  | Synchronize                            |
| `@`       | `n`  | Reveal CWD                             |
| `g?`      | `n`  | Show help                              |

#### 📚 Mini Files Bookmarks

Automatically set bookmarks:
- `c` - Config directory (⚙️)
- `d` - Data directory (💾)
- `h` - Home directory (🏠)
- `w` - Working directory (💼)
- `r` - Project root (📂, if .git exists)

### 🗂 Buffer Management (Barbar)

| Key                 | Mode | Action                           |
|:------------------- |:-----|:--------------------------------|
| `<A-,>` / `<A-.>`   | `n`  | Previous / Next Buffer          |
| `<A-S-,>` / `<A-S-.>`| `n` | Move Buffer Left / Right        |
| `<A-1>`–`<A-9>`     | `n`  | Jump to Buffer 1–9              |
| `<A-0>`             | `n`  | Jump to Last Buffer             |
| `<A-p>`             | `n`  | Pin/Unpin Buffer                |
| `<leader>bc`        | `n`  | Close Current Buffer            |
| `<leader>bo`        | `n`  | Close All But Current/Pinned    |
| `<leader>mb`        | `n`  | Delete Buffer (Mini)            |
| `<leader>mB`        | `n`  | Force Delete Buffer (Mini)      |

### ⚙️ LSP

| Key                 | Mode | Action                          |
|:--------------------|:-----|:--------------------------------|
| `gd` / `gD` / `gr`  | `n`  | Go to Def / Decl / Refs         |
| `gI`                | `n`  | Go to Implementation            |
| `<leader>td`         | `n`  | Type Definition                 |
| `<leader>ca` / `cr` | `n`  | Code Action / Rename            |
| `K` / `<C-k>`       | `n`  | Hover / Signature Help          |
| `<leader>ds`        | `n`  | Document Symbols                |
| `<leader>ws`        | `n`  | Workspace Symbols               |
| `<leader>uh`        | `n`  | Toggle Inlay Hints              |
| `<leader>cl`        | `n`  | Run Code Lens                   |
| `[d` / `]d`         | `n`  | Prev / Next Diagnostic          |
| `<leader>dl` / `dq` | `n`  | Diagnostic List / Quickfix      |

### 🪟 Window Management

| Key           | Mode | Action                           |
|:--------------|:-----|:---------------------------------|
| `<C-h/j/k/l>` | `n`  | Navigate Splits                  |
| `sh / sv`     | `n`  | Horizontal / Vertical Split      |
| `<leader>sx`  | `n`  | Close Split                      |
| `<leader>z`   | `n`  | Toggle Zen Mode                  |
| `<leader>Z`   | `n`  | Zoom Current Window              |

### 📚 Git Operations

| Key          | Mode  | Description                     |
|:-------------|:------|:--------------------------------|
| `<leader>gs` | `n`   | Git Status                      |
| `<leader>gb` | `n`   | Git Branches                    |
| `<leader>gl` | `n`   | Git Log                         |
| `<leader>gL` | `n`   | Git Log Line                    |
| `<leader>gd` | `n`   | Git Diff                        |
| `<leader>gf` | `n`   | Git Log File                    |
| `<leader>gS` | `n`   | Git Stash                       |
| `<leader>gB` | `n,v` | Git Browse                      |
| `<leader>gg` | `n`   | Open Lazygit                    |

### 🔧 Mini Plugins

| Key              | Mode | Description                     |
|:-----------------|:-----|:--------------------------------|
| `gcc`            | `n`  | Comment Line                    |
| `gc`             | `v`  | Comment Selection               |
| `sa` / `sd` / `sr`| `n` | Surround Add / Delete / Replace |
| `<leader>ms`     | `n`  | Write Session                   |
| `<leader>mr`     | `n`  | Read Last Session               |
| `<leader>md`     | `n`  | Delete Session                  |

### 🎛 Toggle Options

| Key          | Mode | Description                     |
|:-------------|:-----|:--------------------------------|
| `<leader>us` | `n`  | Toggle Spelling                 |
| `<leader>uw` | `n`  | Toggle Wrap                     |
| `<leader>uL` | `n`  | Toggle Relative Number          |
| `<leader>ud` | `n`  | Toggle Diagnostics              |
| `<leader>ul` | `n`  | Toggle Line Number              |
| `<leader>uc` | `n`  | Toggle Conceal                  |
| `<leader>uT` | `n`  | Toggle Treesitter               |
| `<leader>ub` | `n`  | Toggle Background (dark/light)  |
| `<leader>uh` | `n`  | Toggle Inlay Hints              |
| `<leader>uD` | `n`  | Toggle Dim                      |

### 💻 Terminal

| Key          | Mode | Description                        |
|:-------------|:-----|:-----------------------------------|
| `<C-\>`      | `n`  | Toggle Terminal                    |
| `<leader>tt` | `n`  | Toggle Terminal (Floating)         |
| `<leader>th` | `n`  | Toggle Terminal (Horizontal)       |
| `<leader>tv` | `n`  | Toggle Terminal (Vertical)         |

### 🗄️ Database Operations (vim-dadbod-ui)

| Key          | Mode | Description                        |
|:-------------|:-----|:-----------------------------------|
| `<leader>Do` | `n`  | Open Database UI                   |
| `<leader>Du` | `n`  | Toggle Database UI                 |
| `<leader>Dc` | `n`  | Close Database UI                  |
| `<leader>Dr` | `n`  | Find Database Buffer               |
| `<leader>Da` | `n`  | Add Database Connection            |

### 📑 Miscellaneous

| Key                 | Mode | Action                           |
|:------------------- |:-----|:---------------------------------|
| `<C-a>`             | `n`  | Select All                       |
| `<leader>y / p`     | `n`  | Yank / Paste System Clipboard    |
| `<leader>L`         | `n`  | Lazy Plugin Manager              |
| `<leader>,`         | `n`  | Switch Buffers                   |
| `<leader>:`         | `n`  | Command History                  |
| `<leader>n`         | `n`  | Notification History             |
| `<leader>.`         | `n`  | Scratch Buffer                   |
| `<leader>S`         | `n`  | Select Scratch                   |
| `<leader>un`        | `n`  | Hide Notifications               |
| `<leader>cR`        | `n`  | Rename File                      |
| `<leader>bd`        | `n`  | Delete Buffer (Snacks)           |
| `<leader>ba`        | `n`  | Delete All Buffers               |
| `<leader>bo`        | `n`  | Delete Other Buffers             |

### 🧪 Debugging (DAP)

| Key                           | Mode | Action                         |
|:------------------------------|:-----|:-------------------------------|
| `<leader>dc`                  | `n`  | Continue Execution             |
| `<leader>db`                  | `n`  | Toggle Breakpoint              |
| `<leader>dB`                  | `n`  | Conditional Breakpoint         |
| `<leader>du`                  | `n`  | Toggle Debug UI                |
| `<leader>dsi` / `dso` / `dsO` | `n`  | Step In / Over / Out           |
| `<leader>dR`                  | `n`  | Restart Debug Session          |
| `<leader>dt`                  | `n`  | Terminate Debug Session        |
| `<leader>de`                  | `n,v`| Evaluate Expression            |
| `<leader>do`                  | `n`  | Open Debug REPL                |
| `<leader>dO`                  | `n`  | Toggle Debug REPL              |
| `<leader>dgt` / `dgl`         | `n`  | Go Test Current / Last         |

### 🐹 Go Development

| Key                        | Mode | Description                             |
|:---------------------------|:-----|:----------------------------------------|
| `<leader>ga`               | `n`  | Alternate File                          |
| `<leader>gvs`              | `n`  | Alternate Vertical Split                |
| `<leader>ghs`              | `n`  | Alternate Horizontal Split              |
| `<leader>gx`               | `n`  | Run Current File                        |
| `<leader>oi`               | `n`  | Organize Imports                        |
| `<leader>of`               | `n`  | Go Format                               |
| `<leader>ot`               | `n`  | Go Mod Tidy                             |
| `<leader>bb`               | `n`  | Build Package                           |
| `<leader>br`               | `n`  | Run Package                             |
| `<leader>tp` / `tf` / `tF` | `n`  | Test Package / Func / File              |
| `<leader>tc`               | `n`  | Test Coverage                           |
| `<leader>tC`               | `n`  | Toggle Coverage                         |
| `<leader>gta` / `gtr`      | `n`  | Add / Remove Tags                       |
| `<leader>gat` / `get`      | `n`  | Add / Example Test                      |
| `<leader>gc` / `gs` / `gr` | `n`  | Comment / Fill Struct / Generate Return |
| `<leader>gj`               | `n`  | JSON to Struct                          |
| `<leader>gI` / `gG` / `gm` | `n`  | Implement / Generate / Mocks            |
| `<leader>gL` / `gV` / `gD` | `n`  | Lint / Vet / Doc                        |
| `<leader>gDb`              | `n`  | Go Doc Browser                          |
| `<leader>gcb`              | `n`  | Coverage Browser                        |
