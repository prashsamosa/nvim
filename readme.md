# 🚀 Neovim Configuration

![Neovim Version](https://img.shields.io/badge/Neovim-0.10+-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=green)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20Windows-blue.svg?style=flat-square)

## 📋 Prerequisites

### Essential Requirements

| Tool | Version | Purpose |
|:------------|:-----------|:----------------------------------|
| **Neovim** | `≥ 0.10.0` | Core editor |
| **Git** | `Latest` | Version control & plugin management |
| **Nerd Font** | `Latest` | Icons & glyphs (e.g., JetBrains Mono) |

### CLI Tools

```bash
# Ubuntu/Debian
sudo apt install ripgrep fd-find
```

### Language-Specific Tools

Ensure these are installed for optimal language support:

<details>
<summary><strong>🐹 Go Development</strong></summary>

```bash
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

</details>

<details>
<summary><strong>🐍 Python</strong></summary>

```bash
pip install debugpy black isort
```

</details>

<details>
<summary><strong>🦀 Rust</strong></summary>

```bash
rustup component add rust-analyzer
rustup component add rustfmt
```

</details>

## 📦 Installation

1. **Backup existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone the repository**:
   ```bash
   git clone https://github.com/prashsamosa/nvim.git ~/.config/nvim
   ```
   *(Replace `your-username/your-nvim-config` with your actual repository path)*

3. **Open Neovim**:
   ```bash
   nvim
   ```

4. **Wait for installation**: lazy.nvim will automatically download and install all plugins. Mason will also install LSP servers and formatters as configured. This might take some time on the first launch.

5. **Run health check**: After installation, run `:checkhealth` to ensure all dependencies are met and your setup is healthy.

# ⌨️ Keybindings

This configuration uses `<Space>` as the leader key (`<leader>`).

## General
| Key | Action |
|-----|--------|
| `<leader>nh` | Clear search highlights |
| `jk` (in Insert mode) | Exit Insert mode (remapped from `<ESC>`) |

## Window Management
| Key | Action |
|-----|--------|
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Navigate between windows |
| `sh` | Horizontal split |
| `sv` | Vertical split |

## 📁 File & Buffer Management

| Key                          | Action                                      |
|-----------------------------|---------------------------------------------|
| `-`                         | Open `oil.nvim` (Floating File Explorer)    |
| `<A-,>`, `<A-.>`            | Go to previous/next buffer                  |
| `<A-S-,>`, `<A-S-.>`        | Move buffer previous/next                   |
| `<A-1>` to `<A-9>`, `<A-0>` | Jump to specific buffer                     |
| `<A-p>`                     | Pin/unpin current buffer                    |
| `<leader>bc`                | Close current buffer                        |
| `<leader>bd`                | Delete current buffer (Snacks)             |
| `<leader>ba`                | Delete all buffers (Snacks)                |
| `<leader>bo`                | Delete other buffers (Snacks)              |
| `<leader>bO`                | Close all but current/pinned (Barbar)      |
| `<leader>rf`                | Rename current file (Snacks)               |

## 🗂️ File Explorer (`oil.nvim`)

| Key            | Action                                             |
|----------------|----------------------------------------------------|
| `-`            | Open Oil (Floating File Explorer)                 |
| `Enter`        | Open file or enter directory                       |
| `g?`           | Show help                                          |
| `<C-h>`        | Go up one directory                                |
| `<C-l>`        | Enter directory or open file                       |
| `<C-p>`        | Preview file                                       |
| `<C-c>`        | Close Oil                                          |
| `<C-r>`        | Refresh directory                                  |
| `q`            | Close Oil                                          |

## 🗂️ Snacks Explorer

| Key            | Action                                             |
|----------------|----------------------------------------------------|
| `<leader>e`    | Open Snacks Explorer                               |
| `<leader>E`    | Toggle Snacks Explorer                             |

## LSP (Language Server Protocol)
| Key | Action |
|-----|--------|
| `<leader>ca` | Code action |
| `<S-k>` | Hover documentation |
| `<leader>cr` | Rename symbol |
| `<leader>cf` | Format current file |
| `<leader>cc` | Organize imports |
| `gd` | Go to definition |
| `gr` | Go to references |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `<leader>sd` | Show document diagnostics |
| `<leader>sw` | Show workspace diagnostics |
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |

## 🧩 Text Objects
Uses [mini.ai](https://github.com/echasnovski/mini.ai) for advanced text objects.

| Key | Usage Example | What it Selects                                 |
|-----|--------------|-------------------------------------------------|
| `af`| `vaf`        | **A**round **F**unction (entire function block) |
| `if`| `vif`        | **I**nner **F**unction (just the function body) |
| `ac`| `vac`        | **A**round **C**lass (entire class block)       |
| `ic`| `vic`        | **I**nner **C**lass (just the class body)       |

**How to use:**
- In **visual mode**, press `v` then one of these keys (e.g., `vaf`) to select the corresponding code object.
- In **operator-pending mode** (e.g., after `d` for delete or `c` for change), type the key (e.g., `daf` to delete a function).

> These shortcuts make it easy to select, change, or delete entire functions, classes, or their contents with a few keystrokes.

## 🗄️ Database Operations (`vim-dadbod-ui`)

### 🔧 General DB UI Commands

| Keybinding    | Action                | Description                                 |
|---------------|------------------------|---------------------------------------------|
| `<leader>Do`  | Open DB UI             | Opens the database UI interface             |
| `<leader>Du`  | Toggle DB UI           | Toggles the database UI visibility          |
| `<leader>Dc`  | Close DB UI            | Closes the database UI window               |
| `<leader>Df`  | Find DB Buffer         | Find and switch to an active DB buffer      |
| `<leader>Da`  | Add DB Connection      | Add a new database connection               |
| `<leader>Dn`  | Rename Buffer          | Rename the current DB buffer                |
| `<leader>Dl`  | Last Query Info        | Show info about the last executed query     |

### 📝 SQL Buffer-Specific Commands
> _Available only when editing `.sql`, `.mysql`, or `.plsql` files._

| Keybinding    | Action                | Description                                   |
|---------------|------------------------|-----------------------------------------------|
| `<leader>Dr`  | Execute Query/Selection| Run the current query or visual selection     |
| `<leader>DS`  | Save Query             | Save the current SQL query                    |

## Fuzzy Finding (fzf-lua)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>f/` | Grep in current buffer |
| `<leader>fo` | Old files |
| `<leader>f<space>` | Buffers |
| `<leader>fgd` | LSP Go to Definition (FZF picker) |
| `<leader>fgr` | LSP Go to References (FZF picker) |

## Terminal Operations (Snacks)

| Key | Action |
|-----|--------|
| `<leader>t` | Open Terminal |
| `<leader>T` | Open Terminal (current directory) |
| `<C-/>` | Toggle Terminal |

## Git Operations (Snacks)

| Key | Action |
|-----|--------|
| `<leader>gb` | Git Blame Line |
| `<leader>gB` | Git Browse |
| `<leader>gf` | Lazygit Current File History |
| `<leader>gg` | Open Lazygit |
| `<leader>gl` | Lazygit Log |

## Markdown (render-markdown.nvim)
| Key         | Action                    |
|-------------|---------------------------|
| `<leader>mt`| Toggle Markdown Rendering |
| `<leader>me`| Enable Markdown Rendering |
| `<leader>md`| Disable Markdown Rendering|
| `<leader>ml`| Show Markdown Log         |
| `<leader>mD`| Debug Current Line        |
| `<leader>mc`| Show Markdown Config      |
| `<leader>mE`| Expand Markdown View      |
| `<leader>mC`| Contract Markdown View    |

## Snacks Utilities & Toggles

### Toggle Options
| Key | Action |
|-----|--------|
| `<leader>us` | Toggle Spelling |
| `<leader>uw` | Toggle Word Wrap |
| `<leader>uL` | Toggle Relative Line Numbers |
| `<leader>ud` | Toggle Diagnostics |
| `<leader>ul` | Toggle Line Numbers |
| `<leader>uc` | Toggle Conceallevel |
| `<leader>uT` | Toggle Treesitter Highlights |
| `<leader>ub` | Toggle Dark/Light Background |
| `<leader>uh` | Toggle Inlay Hints |
| `<leader>uD` | Toggle Dim Mode |

### Zen & Focus
| Key | Action |
|-----|--------|
| `<leader>z` | Toggle Zen Mode |
| `<leader>Z` | Zoom Current Window |

### Scratch & Buffers
| Key | Action |
|-----|--------|
| `<leader>.` | Scratch Buffer |
| `<leader>S` | Select Scratch Buffer |
| `<leader>,` | Show Buffers (Snacks Picker) |
| `<leader>:` | Command History |
| `<leader>n` | Notification History |

### Word Navigation
| Key | Action |
|-----|--------|
| `<leader>wn` | Next Word Reference |
| `<leader>wp` | Previous Word Reference |

## Sessions (mini.sessions)
| Key | Action |
|-----|--------|
| `<leader>Ms` | Write Session |
| `<leader>Mr` | Read Last Session |
| `<leader>Md` | Delete Session |

# 🔍 GrugFar Search & Replace Shortcuts

## 🚀 Main Operations

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gf` | Search & Replace | Open main GrugFar interface |
| `<leader>gF` | AST Search & Replace | Open with AST-grep engine for structural patterns |
| `<leader>gt` | Toggle GrugFar | Show/hide GrugFar window |

## 🎯 Quick Search Actions

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gw` | Search Word Under Cursor | Prefill search with current word |
| `<leader>gb` | Search in Current Buffer | Limit search to current file only |
| `<leader>gv` | Search Visual Selection | Use selected text as search term |

## 🔧 Within GrugFar Interface

### Navigation & Control
| Key | Action | Description |
|-----|--------|-------------|
| `<Tab>` / `<S-Tab>` | Next/Previous Input | Navigate between search fields |
| `<CR>` | Go to Location | Jump to selected result |
| `<C-n>` / `<C-p>` | Next/Previous Result | Navigate through results |
| `q` | Close | Exit GrugFar |

### Main Actions
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>r` | Replace | Apply replacement |
| `<leader>q` | Send to Quickfix | Add results to quickfix list |
| `<leader>s` | Sync Locations | Sync buffer with results |
| `<leader>p` | Preview | Preview location without jumping |

### Advanced Features
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Swap Engine | Switch between ripgrep/astgrep engines |
| `<leader>h` | History | Open search history |

## 🔍 Search Engine Examples

### Ripgrep (Default)
- **Search**: `foo`, `[Aa]b?c`, `\w+`
- **Replace**: `bar`, `$1`, `${1:default}`
- **Files**: `*.lua`, `src/**/*.js`, `!**/node_modules`
- **Flags**: `--ignore-case --multiline`

### AST-Grep (Structural)
- **Search**: `console.log($A)`, `function $FUNC($$$ARGS) { $$$ }`
- **Replace**: `logger.info($A)`, `const $FUNC = ($$$ARGS) => { $$$ }`
- **Files**: `*.js *.ts`, `**/*.{vue,svelte}`

## 📁 Search Scope Shortcuts

| Scope | Icon | Description |
|-------|------|-------------|
| Current File | 󰈙 | Search only in the current buffer |
| Open Buffers | 󰘢 | Search across all open buffers |
| Git Root | 󰊢 | Search from git repository root |

## 💡 Pro Tips

1. **Quick Word Search**: Place cursor on any word and press `<leader>gw`
2. **Visual Selection**: Select text in visual mode, then `<leader>gv`
3. **File-Specific**: Use `<leader>gb` to search only current file
4. **Structural Changes**: Use `<leader>gF` for code refactoring with AST patterns
5. **History**: Access previous searches with `<leader>h` inside GrugFar

## 🎨 Visual Features

- **Folding**: Results are organized with files collapsed by default
- **Icons**: File type icons (requires Nerd Font)
- **Preview**: See changes before applying
- **Syntax Highlighting**: Code preview with proper highlighting

> **Tip**: Use `<leader>` followed by any key to see available mappings via which-key.nvim

---

## 📦 Current Plugin Structure

```
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins
│       ├── barbar.lua          # Buffer management
│       ├── blink-cmp.lua       # Completion engine
│       ├── conform.lua         # Code formatting
│       ├── dadbod.lua          # Database operations
│       ├── fzf-mini.lua        # Fuzzy finding
│       ├── go.lua              # Go language support
│       ├── grug-far.lua        # Search & replace
│       ├── lsp.lua             # Language servers
│       ├── lualine.lua         # Status line
│       ├── markdown.lua        # Markdown rendering
│       ├── mini.lua            # Mini plugins collection
│       ├── oil.lua             # File explorer
│       ├── schemastore.lua     # JSON schemas
│       ├── sleuth-vim.lua      # Auto-detect indentation
│       ├── snacks.lua          # Swiss-army knife utilities
│       ├── theme.lua           # Color scheme
│       ├── todo.lua            # Todo highlighting
│       ├── treesitter.lua      # Syntax highlighting
│       ├── type.lua            # Type checking
│       └── witt-neovim.lua     # Custom utilities
```

### 🔧 Core Features Provided by Snacks.nvim

- **Terminal Integration**: Built-in terminal with toggle functionality
- **Git Operations**: Lazygit integration, git blame, and browsing
- **File Explorer**: Alternative to oil.nvim for different use cases
- **Zen Mode**: Distraction-free editing
- **Scratch Buffers**: Quick note-taking
- **Toggle Utilities**: Easy toggles for editor options
- **Buffer Management**: Enhanced buffer operations
- **Debug Utilities**: Development helpers
- **Input Enhancement**: Better input prompts
- **Scope Highlighting**: Enhanced code scope visualization

---
