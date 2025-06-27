# ⌨️ Keybindings

This configuration uses `<Space>` as the leader key (`<leader>`).

## General
| Key | Action |
|-----|--------|
| `<leader>nh` | Clear search highlights |
| `jk` (in Insert mode) | Exit Insert mode (remapped from `<ESC>`) |
| `<leader>+` | Increment number |

## Window Management
| Key | Action |
|-----|--------|
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Navigate between windows |
| `sh` | Horizontal split |
| `sv` | Vertical split |

## 📁 File & Buffer Management

### Buffer Navigation (Barber)
| Key                          | Action                                      |
|-----------------------------|---------------------------------------------|
| `<A-,>`, `<A-.>`            | Go to previous/next buffer                  |
| `<A-S-,>`, `<A-S-.>`        | Move buffer previous/next                   |
| `<A-1>` to `<A-9>`, `<A-0>` | Jump to specific buffer                     |
| `<A-p>`                     | Pin/unpin current buffer                    |

### Buffer Management (Mixed: Barbar + Snacks)
| Key                          | Action                                      |
|-----------------------------|---------------------------------------------|
| `<leader>bC`                | Close current buffer (Barbar)              |
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

## 🔍 LSP (Language Server Protocol)

### Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to definition (FZF if available) |
| `gr` | Go to references (FZF if available) |
| `gD` | Go to declaration |
| `gI` | Go to implementation (FZF if available) |
| `<leader>td` | Type definition (FZF if available) |

### Code Actions
| Key | Action |
|-----|--------|
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `K` | Hover documentation |
| `<C-k>` | Signature help (Insert mode) |

### Symbols & Documentation
| Key | Action |
|-----|--------|
| `<leader>ds` | Document symbols (FZF if available) |
| `<leader>ws` | Workspace symbols (FZF if available) |

### Diagnostics
| Key | Action |
|-----|--------|
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |
| `<leader>df` | Show diagnostic float |
| `<leader>dl` | Diagnostic loclist |
| `<leader>dq` | Diagnostic quickfix |

### Additional Features
| Key | Action |
|-----|--------|
| `<leader>ih` | Toggle inlay hints |
| `<leader>cl` | Run code lens |

## 🎨 Formatting (conform.nvim)
| Key | Action |
|-----|--------|
| `<leader>f` | Format buffer (async with LSP fallback) |

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
| `<leader>om` | Go mod tidy |

### Code Generation
| Key | Action |
|-----|--------|
| `<leader>gc` | Generate comment |
| `<leader>gs` | Fill struct |
| `<leader>gr` | Generate return |
| `<leader>gj` | JSON to struct |
| `<leader>gI` | Implement interface |
| `<leader>gG` | Run go generate |
| `<leader>gm` | Generate mocks |
| `<leader>gqi` | Add if err != nil |
| `<leader>gqf` | Fix plurals |

### Struct Tags
| Key | Action |
|-----|--------|
| `<leader>gta` | Add struct tags |
| `<leader>gtr` | Remove struct tags |
| `<leader>gtc` | Add JSON tags |
| `<leader>gty` | Add YAML tags |

### Build & Run
| Key | Action |
|-----|--------|
| `<leader>bb` | Build package |
| `<leader>br` | Run package |
| `<leader>gx` | Run current file |
| `<leader>bs` | Stop running process |

### Testing
| Key | Action |
|-----|--------|
| `<leader>tp` | Test package |
| `<leader>tf` | Test function |
| `<leader>tF` | Test file |
| `<leader>ta` | Test all |
| `<leader>tv` | Test package verbose |
| `<leader>gat` | Add test |

### Coverage
| Key | Action |
|-----|--------|
| `<leader>tc` | Show coverage |
| `<leader>tC` | Toggle coverage |
| `<leader>tcb` | Coverage browser |

### Code Quality
| Key | Action |
|-----|--------|
| `<leader>gl` | Lint code |
| `<leader>gv` | Vet code |
| `<leader>ge` | Error check |

### Documentation
| Key | Action |
|-----|--------|
| `<leader>gd` | Show documentation |
| `<leader>gdb` | Documentation browser |

### Refactoring
| Key | Action |
|-----|--------|
| `<leader>gn` | Rename symbol |
| `<leader>gf` | Free variables |
| `<leader>go` | Channel peers |

### Custom Commands
| Command | Action |
|---------|--------|
| `:GoWorkspace` | Run Go workspace maintenance (mod tidy + imports + generate) |
| `:GoQuickTest` | Run quick tests (-short flag) |
| `:GoBenchmark` | Run benchmarks |

### Debug (if DAP enabled)
| Key | Action |
|-----|--------|
| `<leader>gdt` | Debug test |
| `<leader>gdl` | Debug last test |

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

## 🔍 Fuzzy Finding (FZF-Lua)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fC` | Find in Config directory |
| `<leader>fg` | Live grep (search in files) |
| `<leader>f/` | Grep in current directory |
| `<leader>fo` | Recent files (oldfiles) |
| `<leader>fb` | Open buffers |
| `<leader>fc` | Commands |
| `<leader>fw` | Find word under cursor |
| `<leader>fW` | Find WORD under cursor |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>fd` | Document diagnostics |
| `<leader>fr` | Resume last search |
| `<leader>fgd` | LSP Definition (FZF) |
| `<leader>fgr` | LSP References (FZF) |
| `<leader>fgi` | LSP Implementation (FZF) |
| `<leader>fgt` | LSP Type Definition (FZF) |
| `<leader>fds` | Document Symbols (FZF) |
| `<leader>fws` | Workspace Symbols (FZF) |

## 🔍 GrugFar Search & Replace

### 🚀 Main Operations
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>sr` | Search & Replace | Open main GrugFar interface |
| `<leader>sR` | AST Search & Replace | Open with AST-grep engine for structural patterns |

### 🎯 Quick Search Actions
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>sw` | Search Word Under Cursor | Prefill search with current word |
| `<leader>sb` | Search in Current Buffer | Limit search to current file only |
| `<leader>sv` | Search Visual Selection | Use selected text as search term (Visual mode) |
| `<leader>sf` | Search in Project Root | Search from project root directory |

### 🔧 Within GrugFar Interface

#### Navigation & Control
| Key | Action | Description |
|-----|--------|-------------|
| `<Tab>` / `<S-Tab>` | Next/Previous Input | Navigate between search fields |
| `<CR>` | Go to Location | Jump to selected result |
| `<C-n>` / `<C-p>` | Next/Previous Result | Navigate through results |
| `q` | Close | Exit GrugFar |

#### Main Actions
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>r` | Replace | Apply replacement |
| `<leader>q` | Send to Quickfix | Add results to quickfix list |
| `<leader>s` | Sync Locations | Sync buffer with results |
| `<leader>p` | Preview | Preview location without jumping |

#### Advanced Features
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Swap Engine | Switch between ripgrep/astgrep engines |
| `<leader>h` | History | Open search history |

### 🔍 Search Engine Examples

#### Ripgrep (Default)
- **Search**: `foo`, `[Aa]b?c`, `\w+`
- **Replace**: `bar`, `$1`, `${1:default}`
- **Files**: `*.lua`, `src/**/*.js`, `!**/node_modules`
- **Flags**: `--ignore-case --multiline`

#### AST-Grep (Structural)
- **Search**: `console.log($A)`, `function $FUNC($$$ARGS) { $$$ }`
- **Replace**: `logger.info($A)`, `const $FUNC = ($$$ARGS) => { $$$ }`
- **Files**: `*.js *.ts`, `**/*.{vue,svelte}`

## 🖥️ Terminal Operations (Snacks)

| Key | Action |
|-----|--------|
| `<leader>tt` | Open Terminal |
| `<leader>TT` | New Terminal |
| `<C-t>` | Toggle Terminal  |

## 🚀 Git Operations (Snacks)

| Key | Action |
|-----|--------|
| `<leader>gb` | Git Blame Line |
| `<leader>gB` | Git Browse |
| `<leader>gf` | Lazygit Current File History |
| `<leader>gg` | Open Lazygit |
| `<leader>gl` | Lazygit Log |

## 📝 Markdown (render-markdown.nvim)
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

## 🎛️ Snacks Utilities & Toggles

### Toggle Options
| Key | Action |
|-----|--------|
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
| `<leader><space>` | Find Files (Snacks Picker) |

### Word Navigation
| Key | Action |
|-----|--------|
| `<leader>wn` | Next Word Reference |
| `<leader>wp` | Previous Word Reference |

### Notifications
| Key | Action |
|-----|--------|
| `<leader>un` | Hide Notifications |
| `<leader>uN` | Show Notification History |

## 📚 Sessions (mini.sessions)
| Key | Action |
|-----|--------|
| `<leader>Ms` | Write Session |
| `<leader>Mr` | Read Last Session |
| `<leader>Md` | Delete Session |

## 💡 Pro Tips

### FZF-Lua
1. **Quick File Search**: Use `<leader>ff` for fuzzy file finding
2. **Live Grep**: `<leader>fg` for searching text across all files
3. **Recent Files**: `<leader>fo` to quickly access recently opened files
4. **Config Search**: `<leader>fC` to search within your Neovim config
5. **Word Search**: Place cursor on word and use `<leader>fw` for project-wide search

### GrugFar
1. **Quick Word Search**: Place cursor on any word and press `<leader>sw`
2. **Visual Selection**: Select text in visual mode, then `<leader>sv`
3. **File-Specific**: Use `<leader>sb` to search only current file
4. **Structural Changes**: Use `<leader>sR` for code refactoring with AST patterns
5. **History**: Access previous searches with `<leader>h` inside GrugFar

### LSP
1. **FZF Integration**: LSP navigation commands automatically use FZF-Lua when available
2. **Inlay Hints**: Toggle with `<leader>ih` for better code understanding
3. **Diagnostics**: Use `[d` and `]d` for quick navigation between issues

### Formatting
1. **Async Formatting**: `<leader>f` formats with async support and LSP fallback
2. **Format on Save**: Automatically formats Go files and others (configurable per filetype)
3. **Custom Formatters**: Uses prettierd, stylua, goimports, black, and more

### Terminal
1. **Multiple Keymaps**: `<C-t>` work for terminal toggle
2. **Terminal Mode**: Terminal keymaps work in both normal and terminal modes

### File Management
1. **Oil.nvim**: Press `-` for quick file operations in a buffer-like interface
2. **Snacks Explorer**: Use `<leader>e` for a more traditional file tree

### Buffer Management
1. **Barbar Navigation**: Use Alt+number keys to jump directly to specific buffers
2. **Mixed Buffer Operations**: Use barbar for tab-like operations, Snacks for buffer deletion
3. **Pin Important Buffers**: Use `<A-p>` to pin frequently used buffers

### Go Development
1. **Comprehensive Tooling**: Full integration with go.nvim for all Go development needs
2. **Debugging Support**: Built-in DAP integration for Go debugging (when enabled)
3. **Automatic Formatting**: Go files are automatically formatted and organized on save
4. **Test Integration**: Run tests at package, function, or file level
5. **Code Generation**: Generate comments, struct tags, interfaces, and more
6. **Custom Commands**: Use `:GoWorkspace` for complete project maintenance
7. **Quick Testing**: Use `:GoQuickTest` for fast test runs with `-short` flag

> **Tip**: Use `<leader>` followed by any key to see available mappings via which-key.nvim
