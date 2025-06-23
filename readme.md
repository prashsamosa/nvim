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

### Buffer Navigation (Barbar)
| Key                          | Action                                      |
|-----------------------------|---------------------------------------------|
| `<A-,>`, `<A-.>`            | Go to previous/next buffer                  |
| `<A-S-,>`, `<A-S-.>`        | Move buffer previous/next                   |
| `<A-1>` to `<A-9>`, `<A-0>` | Jump to specific buffer                     |
| `<A-p>`                     | Pin/unpin current buffer                    |

### Buffer Management (Mixed: Barbar + Snacks)
| Key                          | Action                                      |
|-----------------------------|---------------------------------------------|
| `<leader>bc`                | Close current buffer (Barbar)              |
| `<leader>bO`                | Close all but current/pinned (Barbar)      |
| `<leader>bd`                | Delete current buffer (Snacks)             |
| `<leader>ba`                | Delete all buffers (Snacks)                |
| `<leader>bo`                | Delete other buffers (Snacks)              |

### File Operations (Snacks)
| Key                          | Action                                      |
|-----------------------------|---------------------------------------------|
| `<leader>rf`                | Rename current file (Snacks)               |

### File Explorers
| Key                          | Action                                      |
|-----------------------------|---------------------------------------------|
| `-`                         | Open `oil.nvim` (Floating File Explorer)    |
| `<leader>e`                 | Open Snacks Explorer                        |
| `<leader>E`                 | Toggle Snacks Explorer                      |

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

## 🐹 Go Development (go.nvim)

### File Navigation
| Key | Action |
|-----|--------|
| `<leader>ga` | Alternate file (test ↔ source) |
| `<leader>gvs` | Alternate vertical split |
| `<leader>ghs` | Alternate horizontal split |

### Code Organization
| Key | Action |
|-----|--------|
| `<leader>oi` | Organize imports |
| `<leader>ot` | Go mod tidy |
| `<leader>cc` | Organize imports (LSP) |

### Code Generation
| Key | Action |
|-----|--------|
| `<leader>gc` | Generate comment |
| `<leader>gs` | Fill struct |
| `<leader>gr` | Generate return |
| `<leader>gj` | JSON to struct |
| `<leader>gI` | Implement interface |

### Struct Tags
| Key | Action |
|-----|--------|
| `<leader>gta` | Add struct tags |
| `<leader>gtr` | Remove struct tags |

### Build & Run
| Key | Action |
|-----|--------|
| `<leader>bb` | Build package |
| `<leader>br` | Run package |
| `<leader>gx` | Run current file |

### Testing
| Key | Action |
|-----|--------|
| `<leader>tp` | Test package |
| `<leader>tf` | Test function |
| `<leader>tF` | Test file |
| `<leader>gat` | Add test |
| `<leader>get` | Add example test |

### Coverage
| Key | Action |
|-----|--------|
| `<leader>tc` | Show coverage |
| `<leader>tC` | Toggle coverage |
| `<leader>gcb` | Coverage browser |

### Code Quality
| Key | Action |
|-----|--------|
| `<leader>gL` | Lint code |
| `<leader>gV` | Vet code |

### Documentation
| Key | Action |
|-----|--------|
| `<leader>gD` | Show documentation |
| `<leader>gDb` | Documentation browser |

### Code Generation
| Key | Action |
|-----|--------|
| `<leader>gG` | Run go generate |
| `<leader>gm` | Generate mocks |

## 🧩 Text Objects & TreeSitter Navigation

### Snacks Scope Text Objects
| Key | Usage Example | What it Selects                                 |
|-----|--------------|-------------------------------------------------|
| `ii`| `vii`        | **I**nner scope (content within current scope) |
| `ai`| `vai`        | **A**round scope (entire scope including edges) |

### TreeSitter Navigation
| Key | Action |
|-----|--------|
| `<Enter>` | Start/expand selection (incremental) |
| `<S-Enter>` | Expand to scope |
| `<BS>` | Shrink selection |
| `[i`, `]i` | Jump to scope edges (Snacks) |

### TreeSitter Movement
| Key | Action |
|-----|--------|
| `]m`, `[m` | Next/previous function start |
| `]M`, `[M` | Next/previous function end |
| `]c`, `[c` | Next/previous class start |
| `]C`, `[C` | Next/previous class end |

### Parameter Swapping
| Key | Action |
|-----|--------|
| `<leader>a` | Swap with next parameter |
| `<leader>A` | Swap with previous parameter |

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

## Fuzzy Finding (FZF-Lua)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fc` | Find in Config directory |
| `<leader>fg` | Live grep (search in files) |
| `<leader>f/` | Grep in current directory |
| `<leader>fo` | Recent files (oldfiles) |
| `<leader>f<space>` | Open buffers |
| `<leader>fb` | Commands |
| `<leader>fw` | Find word under cursor |
| `<leader>fW` | Find WORD under cursor |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>fd` | Document diagnostics |
| `<leader>fr` | Resume last search |
| `<leader>fgd` | LSP Go to Definition |
| `<leader>fgr` | LSP Go to References |
| `<leader>fgi` | LSP Go to Implementation |
| `<leader>fgt` | LSP Type Definition |
| `<leader>fds` | Document symbols |
| `<leader>fws` | Workspace symbols |

## Terminal Operations (Snacks)

| Key | Action |
|-----|--------|
| `<leader>t` | Open Terminal |
| `<leader>T` | New Terminal |
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
