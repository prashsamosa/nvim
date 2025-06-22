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

## ⌨️ Keybindings Overview

**Leader key:** `<Space>`

### 🌟 Essential Shortcuts

| Key               | Mode  | Description                    |
|:------------------|:------|:-------------------------------|
| `jk`              | `i`   | Exit Insert Mode               |
| `<leader><space>` | `n`   | Smart Find Files               |
| `<leader>e`       | `n`   | Toggle File Explorer           |
| `<leader>ff`      | `n`   | Find Files (FZF)               |
| `<leader>sg`      | `n`   | Search in Files                |
| `<C-s>`           | `n,i` | Quick Save                     |
| `<leader>nh`      | `n`   | Clear Search Highlights        |

### 🧭 Navigation & Search

| Key               | Mode  | Action                |
| ----------------- | ----- | --------------------- |
| `<leader><space>` | `n`   | Smart Find Files      |
| `<leader>e`       | `n`   | Toggle File Explorer  |
| `<leader>ff`      | `n`   | Find Files (FZF)      |
| `<leader>sg`      | `n`   | Search in Files       |
| `]] / [[`         | `n,t` | Next / Prev Reference |
| `<leader>fr`      | `n`   | Recent Files          |
| `<leader>sb`      | `n`   | Search in Buffer      |
| `<leader>sw`      | `n,x` | Search Word Under Cursor |
| `<leader>fg`      | `n`   | Find Git Files        |
| `<leader>fo`      | `n`   | Old Files             |
| `]t`              | `n`   | Next TODO Comment     |
| `[t`              | `n`   | Previous TODO Comment |

### ⚙️ LSP

| Key                 | Action                     |
| ------------------- | -------------------------- |
| `gd` / `gD` / `gr`  | Go to Def / Decl / Refs    |
| `gI`                | Go to Implementation       |
| `<leader>D`         | Type Definition            |
| `<leader>ca` / `cr` | Code Action / Rename       |
| `K` / `<C-k>`       | Hover / Signature Help     |
| `<leader>ds`        | Document Symbols           |
| `<leader>ws`        | Workspace Symbols          |
| `<leader>ih`        | Toggle Inlay Hints         |
| `<leader>cl`        | Run Code Lens              |
| `[d` / `]d`         | Prev / Next Diagnostic     |
| `<leader>dl` / `dq` | Diagnostic List / Quickfix |

### 🌳 File Explorer (NvimTree)

| Key          | Action                   |
| ------------ | ------------------------ |
| `<leader>e`  | Toggle NvimTree          |
| `a / d / r`  | Create / Delete / Rename |
| `c / x / p`  | Copy / Cut / Paste       |
| `F`          | Live Filter              |
| `gy / y / Y` | Copy Path to Clipboard   |

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
| `W`       | `n`  | Collapse all directories               |
| `E`       | `n`  | Expand all directories                 |
| `P`       | `n`  | Go to parent directory                 |
| `K`       | `n`  | Go to first sibling                    |
| `J`       | `n`  | Go to last sibling                     |
| `m`       | `n`  | Toggle bookmark                        |
| `s`       | `n`  | Open with system default application   |
| `<C-k>`   | `n`  | Show file info                         |
| `g?`      | `n`  | Show help                              |

### 🗂 Buffer Management

| Key                 | Action                        |
| ------------------- | ----------------------------- |
| `<A-,>` / `<A-.>`   | Prev / Next Buffer            |
| `<leader>bd` / `bo` | Delete / Delete Other Buffers |
| `<A-1>`–`<A-9>`     | Go to Buffer 1–9              |
| `<A-0>`             | Go to Last Buffer             |
| `<A-p>`             | Pin/Unpin Buffer              |

### 🪟 Window Management

| Key           | Action                      |
| ------------- | --------------------------- |
| `<C-h/j/k/l>` | Navigate Splits             |
| `sh / sv`     | Horizontal / Vertical Split |
| `<leader>sx`  | Close Split                 |

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

### 📑 Misc

| Key                 | Action                        |
| ------------------- | ----------------------------- |
| `<C-a>`             | Select All                    |
| `<leader>y / p`     | Yank / Paste System Clipboard |
| `<leader>L`         | Lazy                          |




### 🧪 Debugging

| Key                           | Action                  |
| ----------------------------- | ----------------------- |
| `<leader>dc`                  | Continue Execution      |
| `<leader>db`                  | Toggle Breakpoint       |
| `<leader>dB`                  | Conditional Breakpoint  |
| `<leader>du`                  | Toggle Debug UI         |
| `<leader>dsi` / `dso` / `dsO` | Step In / Over / Out    |
| `<leader>dr` / `dR`           | Run / Restart           |
| `<leader>dt` / `de` / `do`    | Terminate / Eval / REPL |
| `<leader>dbc`                 | Clear Breakpoints       |
| `<leader>dgt` / `dgl`         | Go Test Current / Last  |

### 🐹 Go Development

| Key                        | Description                             |
| -------------------------- | --------------------------------------- |
| `<leader>ga`               | Alternate File                          |
| `<leader>gvs`              | Alternate Vertical Split                |
| `<leader>ghs`              | Alternate Horizontal Split              |
| `<leader>gx`               | Run Current File                        |
| `<leader>oi`               | Organize Imports                        |
| `<leader>of`               | Go Format                               |
| `<leader>ot`               | Go Mod Tidy                             |
| `<leader>bb`               | Build Package                           |
| `<leader>br`               | Run Package                             |
| `<leader>tp` / `tf` / `tF` | Test Package / Func / File              |
| `<leader>tc`               | Test Coverage                           |
| `<leader>tC`               | Toggle Coverage                         |
| `<leader>gta` / `gtr`      | Add / Remove Tags                       |
| `<leader>gat` / `get`      | Add / Example Test                      |
| `<leader>gc` / `gs` / `gr` | Comment / Fill Struct / Generate Return |
| `<leader>gj`               | JSON to Struct                          |
| `<leader>gI` / `gG` / `gm` | Implement / Generate / Mocks            |
| `<leader>gL` / `gV` / `gD` | Lint / Vet / Doc                        |
| `<leader>gDb`              | Go Doc Browser                          |
| `<leader>gcb`              | Coverage Browser                        |


<!-- | `<leader>c`         | Open Config Directory         | -->
<!-- | `<leader>L / M`     | Lazy / Mason UI               | -->
<!-- | `<leader>w / q / x` | Save / Quit / Save+Quit       | -->


---

## 🌳 NvimTree Features

### 🖼 UI Enhancements

* Git & LSP diagnostics
* Nerd Font icons
* Transparent background integration
* Highlighted folders and files

### 🧠 Functional Additions

* Smart window picker
* Bookmarks for frequent files
* System open (`s`)
* Auto resize on file open
* Dotfile toggle

### File Operations
- **Create**: Press `a`, then enter filename (add `/` at end for directory)
- **Delete**: Press `d` to delete selected file/directory
- **Rename**: Press `r` to rename file/directory
- **Copy/Cut/Paste**: Use `c`, `x`, `p` respectively
- **Live Filter**: Press `F` and start typing to filter files

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

---

## 🚀 Quick Usage Tips

1. **Search**: `<leader><space>`, `<leader>sg`
2. **Debug**: `<leader>db`, `<leader>dc`
3. **Go Dev**: `<leader>ga`, `<leader>tp`
4. **File Explorer**: `<leader>e`, `F`, `g?`
5. **Git**: `<leader>gg` (Lazygit), `<leader>gs` (status)

## 💡 Tips

- **Leader Key Sequences**: Most commands start with `<leader>` (Space key)
- **Go Development**: All Go-specific commands are prefixed with `g` after leader
- **Debugging**: All debug commands are prefixed with `d` after leader
- **Terminal**: Use `<C-\>` for quick terminal toggle or `<leader>tt/th/tv` for specific layouts
- **Buffer Navigation**: Use `Alt` + `,` and `.` for quick buffer switching
- **NvimTree**: Use `<leader>e` for file explorer, `F` for filtering, and `g?` for help
- **File Operations**: In NvimTree, use `a` for create, `d` for delete, `r` for rename
- **Git Integration**: NvimTree shows git status; use different colors for modified, staged, and untracked files
- **Diagnostics**: LSP errors and warnings appear as icons in NvimTree next to affected files

## 📝 Mode Legend

- `n` = Normal mode
- `i` = Insert mode
- `v` = Visual mode
- `x` = Visual mode (character-wise)
- `t` = Terminal mode

---

## 📘 Notes

* Uses LazyVim plugin manager
* Snacks.nvim handles UI, toggle, picker, and other utilities
* LSPs, formatters, debuggers installed with Mason
* Full Go developer experience supported (build, lint, test, mock)

## ❓ FAQ / Troubleshooting

### Treesitter not working?

```vim
:TSUpdate
```

### Missing LSP or formatter?

```vim
:MasonInstallAll
```

### Debugging doesn't work?

Ensure `debugpy`, `dlv`, or `js-debug-adapter` are installed.

---

<!-- Happy Hacking ✨ -->
