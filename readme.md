# My Neovim Configuration

This configuration aims for a fast, efficient, and highly customized Neovim experience. It leverages modern Neovim features and plugins to provide a powerful IDE-like environment.

## ⌨️ Keybindings Configuration

This document outlines the keybindings for this Neovim configuration, utilizing `<Space>` as the leader key (`<leader>`).

---

### General
| Key | Action |
|-----|--------|
| `<leader>nh` | Clear search highlights |
| `jk` (in Insert mode) | Exit Insert mode (remapped from `<ESC>`) |
| `<leader>+` | Increment number |
| `<leader>-` | Decrement number |
| `<leader>bl` | Switch to last buffer |
| `<C-s>` | Save file |
| `<Esc><Esc>` (in Terminal mode) | Exit Terminal mode |
| `<leader>ur` | Redraw / Clear hlsearch / Diff update |

---

### Window Management
| Key | Action |
|-----|--------|
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Navigate between windows |
| `sh` | Horizontal split |
| `sv` | Vertical split |

---

### Visual Mode
| Key | Action |
|-----|--------|
| `J` | Move selection down |
| `K` | Move selection up |
| `<A-j>` | Move selection down (maintains selection) |
| `<A-k>` | Move selection up (maintains selection) |
| `p` | Paste without replacing clipboard |

---

## 📁 File & Buffer Management

### Buffer Navigation (Native)
| Key | Action |
|-----|--------|
| `[b` | Previous buffer |
| `]b` | Next buffer |
| `[B` | First buffer |
| `]B` | Last buffer |

### Buffer Navigation (`barbar.nvim`)
| Key | Action |
|-----------------------------|---------------------------------------------|
| `<A-,>`, `<A-.>` | Go to previous/next buffer |
| `<A-S-,>`, `<A-S-.>` | Move buffer previous/next |
| `<A-1>` to `<A-9>`, `<A-0>` | Jump to specific buffer |
| `<A-p>` | Pin/unpin current buffer |

### Buffer Management (`snacks.nvim` / `barbar.nvim`)
| Key | Action |
|-----------------------------|---------------------------------------------|
| `<leader>bc` | Close/Delete current buffer |
| `<leader>ba` | Delete all buffers |
| `<leader>bo` | Delete other buffers |
| `<leader>bO` | Close all but current/pinned (Barbar) |

### File Operations (`snacks.nvim`)
| Key | Action |
|-----------------------------|---------------------------------------------|
| `<leader>rf` | Rename current file |

### File Explorers (`snacks.nvim`)
| Key | Action |
|-----------------------------|---------------------------------------------|
| `<leader>e` | Open Snacks Explorer |

---

## 🗂️ `oil.nvim` (Floating File Explorer)

| Key | Action |
|----------------|----------------------------------------------------|
| `-` | Open Oil (Floating File Explorer) |
| `Enter` | Open file or enter directory |
| `g?` | Show help |
| `<C-h>` | Go up one directory |
| `<C-l>` | Enter directory or open file |
| `<C-p>` | Preview file |
| `<C-c>` | Close Oil |
| `q` | Close Oil |
| `<C-r>` | Refresh directory |

---

## 🔍 LSP (Language Server Protocol)

**Note:** FZF-powered actions are prefixed with `<leader>f`.

### Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to Definition |
| `gr` | Go to References |
| `gi` | Go to Implementation |
| `gt` | Type Definition |
| `<leader>fgd` | Go to Definition (FZF) |
| `<leader>fgr` | Go to References (FZF) |
| `<leader>fgi` | Go to Implementation (FZF) |
| `<leader>fgt` | Type Definition (FZF) |

### Code Actions
| Key | Action |
|-----|--------|
| `<leader>ca` | Code Action |
| `<leader>cr` | Rename Symbol |
| `K` | Hover Documentation |
| `<C-s>` (Insert mode) | Signature Help |

### Symbols & Documentation
| Key | Action |
|-----|--------|
| `<leader>ds` | Document Symbols |
| `<leader>ws` | Workspace Symbols |
| `<leader>fds` | Document Symbols (FZF) |
| `<leader>fws` | Workspace Symbols (FZF) |

### Diagnostics
| Key | Action |
|-----|--------|
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |
| `[D` | Go to previous error |
| `]D` | Go to next error |
| `<leader>df` | Show diagnostic float |
| `<leader>dl` | Diagnostic loclist |
| `<leader>dq` | Diagnostic quickfix |

---

## 🎨 Formatting (`conform.lua`)
| Key | Action |
|-----|--------|
| `<leader>f` | Format buffer (Conform) |

---

## 🐹 Go Development (`go.nvim`)

### File Navigation
| Key | Action |
|-----|--------|
| `<leader>ga` | Alternate file |

### Code Organization
| Key | Action |
|-----|--------|
| `<leader>gi` | Organize imports |
| `<leader>gm` | Go mod tidy |

### Code Generation
| Key | Action |
|-----|--------|
| `<leader>gs` | Fill struct |
| `<leader>gj` | JSON → struct |
| `<leader>gI` | Implement interface |

### Struct Tags
| Key | Action |
|-----|--------|
| `<leader>gTa` | Add tags |
| `<leader>gTr` | Remove tags |

### Build & Run
| Key | Action |
|-----|--------|
| `<leader>gb` | Build package |
| `<leader>gx` | Run current file |

### Testing
| Key | Action |
|-----|--------|
| `<leader>gta` | Test all |
| `<leader>gtf` | Test function |
| `<leader>gtp` | Test package |
| `<leader>gat` | Add test |

### Coverage
| Key | Action |
|-----|--------|
| `<leader>gtc` | Show coverage |
| `<leader>gtC` | Toggle coverage |

### Code Quality
| Key | Action |
|-----|--------|
| `<leader>gv` | Go vet |

### Documentation
| Key | Action |
|-----|--------|
| `<leader>gD` | Show documentation |

### Custom Commands
| Command | Action |
|---------|--------|
| `:GoWorkspace` | Run Go workspace maintenance (mod tidy + imports + generate) |
| `:GoQuickTest` | Run quick tests (`-short` flag) |
| `:GoBenchmark` | Run benchmarks |

### Debug (if DAP enabled)
| Key | Action |
|-----|--------|
| `<leader>gdt` | Debug test |

---

## 🧩 Text Objects & TreeSitter Navigation (`nvim-treesitter-textobjects`)

### Snacks Scope Text Objects (`snacks.nvim`)
| Key | Usage Example | What it Selects |
|-----|--------------|-------------------------------------------------|
| `ii`| `vii` | **I**nner scope (content within current scope) |
| `ai`| `vai` | **A**round scope (entire scope including edges) |

### TreeSitter Text Objects
| Key | What it Selects |
|-----|-----------------|
| `af` | Around function |
| `if` | Inside function |
| `ac` | Around class |
| `ic` | Inside class |
| `aa` | Around parameter |
| `ia` | Inside parameter |
| `al` | Around loop |
| `il` | Inside loop |
| `at` | Around comment |
| `it` | Inside comment |
| `ad` | Around conditional |
| `id` | Inside conditional |
| `ab` | Around block |
| `ib` | Inside block |
| `a=` | Around assignment |
| `i=` | Inside assignment |
| `aq` | Around call |
| `iq` | Inside call |

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

### Parameter Swapping (`witt-neovim/witt.nvim`)
| Key | Action |
|-----|--------|
| `<leader>pa` | Swap with next parameter |
| `<leader>pA` | Swap with previous parameter |

### Code Peek (`witt-neovim/witt.nvim`)
| Key | Action |
|-----|--------|
| `<leader>pf` | Peek function definition |
| `<leader>pc` | Peek class definition |

---

## 🗄️ Database Operations (`dadbod.nvim` / `vim-dadbod-ui`)

### 🔧 General DB UI Commands
| Keybinding | Action | Description |
|---------------|------------------------|---------------------------------------------|
| `<leader>Do` | Open DB UI | Opens the database UI interface |
| `<leader>Du` | Toggle DB UI | Toggles the database UI visibility |
| `<leader>Dc` | Close DB UI | Closes the database UI window |
| `<leader>Df` | Find DB Buffer | Find and switch to an active DB buffer |
| `<leader>Da` | Add DB Connection | Add a new database connection |
| `<leader>Dn` | Rename Buffer | Rename the current DB buffer |
| `<leader>Dl` | Last Query Info | Show info about the last executed query |

### 📝 SQL Buffer-Specific Commands
> _Available only when editing `.sql`, `.mysql`, or `.plsql` files._

| Keybinding | Action | Description |
|---------------|------------------------|-----------------------------------------------|
| `<leader>Dr` | Execute Query/Selection| Run the current query or visual selection |
| `<leader>DS` | Save Query | Save the current SQL query |

---

## 🔍 Fuzzy Finding (`FZF-Lua`)

### File Operations
| Key | Action |
|-----|--------|
| `<leader><space>` | Find files (Snacks Picker with FZF fallback) |
| `<leader>ff` | Find files |
| `<leader>fC` | Find in Config directory |
| `<leader>fo` | Recent files (oldfiles) |
| `<leader>fb` | Open buffers |

### Search Operations
| Key | Action |
|-----|--------|
| `<leader>fg` | Live grep (search in files) |
| `<leader>f/` | Grep in current directory |
| `<leader>fw` | Find word under cursor |
| `<leader>fW` | Find WORD under cursor |
| `<leader>fr` | Resume last search |

### Help & Navigation
| Key | Action |
|-----|--------|
| `<leader>fc` | Commands |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>fd` | Document diagnostics |

---

## 🔍 GrugFar Search & Replace (`grug-far.nvim`)

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
| `<leader>ss` | Sync Locations | Sync buffer with results |
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

---

## 🖥️ Terminal Operations (`snacks.nvim`)
| Key | Action |
|-----|--------|
| `<leader>tt` | Open Terminal |
| `<leader>TT` | New Terminal |
| `<C-t>` | Toggle Terminal |

---

## 🚀 Git Operations (`snacks.nvim`)
| Key | Action |
|-----|--------|
| `<leader>Gb` | Git Blame Line |
| `<leader>GB` | Git Browse |
| `<leader>Gf` | Lazygit Current File History |
| `<leader>GG` | Open Lazygit |
| `<leader>Gl` | Lazygit Log |

---

## 📝 Markdown (`markdown.lua` / `render-markdown.nvim`)
| Key | Action |
|-------------|---------------------------|
| `<leader>mt`| Toggle Markdown Rendering |
| `<leader>me`| Enable Markdown Rendering |
| `<leader>md`| Disable Markdown Rendering|
| `<leader>ml`| Show Markdown Log |
| `<leader>mD`| Debug Current Line |
| `<leader>mc`| Show Markdown Config |
| `<leader>mE`| Expand Markdown View |
| `<leader>mC`| Contract Markdown View |

---

## 🎛️ Snacks Utilities & Toggles (`snacks.nvim`)

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

---

## 📚 Sessions (`mini.lua` / `mini.sessions`)
| Key | Action |
|-----|--------|
| `<leader>Ms` | Write Session |
| `<leader>Mr` | Read Last Session |
| `<leader>Md` | Delete Session |

---

## 🔤 Default Neovim Keymaps

These keymaps are provided by default in Neovim and work automatically:

### Diagnostics
| Key | Action |
|-----|--------|
| `[d`, `]d` | Previous/Next diagnostic |
| `[D`, `]D` | First/Last diagnostic (severity: error) |

### Lists Navigation
| Key | Action |
|-----|--------|
| `[q`, `]q`, `[Q`, `]Q`, `[<C-Q>`, `]<C-Q>` | Navigate quickfix list |
| `[l`, `]l`, `[L`, `]L`, `[<C-L>`, `]<C-L>` | Navigate location list |
| `[t`, `]t`, `[T`, `]T`, `[<C-T>`, `]<C-T>` | Navigate tag matchlist |
| `[a`, `]a`, `[A`, `]A` | Navigate argument list |
| `[b`, `]b`, `[B`, `]B` | Navigate buffer list |
| `[<Space>`, `]<Space>` | Add empty line above/below cursor |

---

## 💡 Pro Tips

Here are some power-user tips to enhance your workflow:

* **Fuzzy Finding with `FZF-Lua`**:
    * **Quick File Search**: Use `<leader><space>` or `<leader>ff` to quickly find files.
    * **Live Grep**: Use `<leader>fg` for searching text across all files.
    * **Recent Files**: Quickly access recently opened files with `<leader>fo`.
    * **Config Search**: Search within your Neovim configuration using `<leader>fC`.
    * **Word Search**: Place your cursor on a word and use `<leader>fw` for a project-wide search.

* **Smart Search & Replace with `GrugFar`**:
    * **Quick Word Search**: Place your cursor on any word and press `<leader>sw`.
    * **Visual Selection Search**: Select text in visual mode, then use `<leader>sv`.
    * **File-Specific Search**: Limit your search to the current file only with `<leader>sb`.
    * **Structural Changes**: Utilize `<leader>sR` for advanced code refactoring with AST patterns.
    * **History**: Access previous searches with `<leader>h` directly within the GrugFar interface.

* **Enhanced LSP Experience**:
    * **FZF Integration**: LSP navigation commands automatically integrate with `FZF-Lua` when available for faster results.
    * **Inlay Hints**: Toggle these helpful hints with `<leader>uh` (if configured in `snacks.nvim`) for better code understanding.
    * **Diagnostics**: Navigate quickly between issues using `[d` and `]d`.

* **Efficient Formatting**:
    * **Async Formatting**: `<leader>f` formats your buffer asynchronously via `conform.nvim`, with fallback to LSP formatting.
    * **Format on Save**: Go files and others are automatically formatted and organized on save (configurable per filetype through `mason-tool-installer`).
    * **Custom Formatters**: Supports `prettierd`, `stylua`, `goimports`, `black`, and more.

* **Seamless Terminal Integration**:
    * **Multiple Keymaps**: Use `<C-t>` to toggle the terminal, or `<leader>tt` for specific terminal operations.
    * **Terminal Mode**: Use `<Esc><Esc>` to exit terminal mode quickly.

* **Streamlined File Management**:
    * **`oil.nvim`**: Press `-` for quick file operations in a buffer-like interface.
    * **Snacks Explorer**: For a more traditional file tree, use `<leader>e`.

* **Advanced Buffer Management**:
    * **Barbar Navigation**: Use `Alt` + number keys to jump directly to specific buffers.
    * **Mixed Buffer Operations**: Use Barbar for tab-like operations, and Snacks for powerful buffer deletion.
    * **Pin Important Buffers**: Use `<A-p>` to pin frequently used buffers for easy access.

* **Comprehensive Go Development**:
    * **Full Tooling**: Enjoy full integration with `go.nvim` for all your Go development needs.
    * **Debugging Support**: Built-in DAP integration allows for efficient Go debugging (when `dap-go` is loaded and enabled).
    * **Automatic Formatting**: Go files are automatically formatted and organized on save by `gofumpt`.
    * **Test Integration**: Run tests at package, function, or file level with ease.
    * **Code Generation**: Generate struct tags, interfaces, and more to speed up development.
    * **Custom Commands**: Use `:GoWorkspace` for complete project maintenance.

* **TreeSitter Power Features**:
    * **Incremental Selection**: Use `<Enter>` to start selecting, then keep pressing to expand.
    * **Text Objects**: Use `vif` to select inside function, `vac` for around class, etc.
    * **Smart Movement**: Jump between functions with `]m`/`[m` and classes with `]c`/`[c`.
    * **Parameter Swapping**: Use `<leader>pa` and `<leader>pA` (from `witt.nvim`) to swap function parameters.

---

> **Tip**: Use `<leader>` followed by any key to see available mappings via `which-key.nvim`.

---
