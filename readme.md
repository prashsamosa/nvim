## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua
├── lua/
│   ├── config/
│   │   ├── lazy.lua       # Plugin manager setup
│   │   ├── options.lua    # Vim options & autocommands
│   │   └── keymaps.lua    # Global keybindings
│   └── plugins/
│       ├── barbar.lua     # Buffer tabs
│       ├── blink-cmp.lua  # Completion engine
│       ├── comment.lua    # Smart commenting
│       ├── conform.lua    # Code formatting
│       ├── dadbod.lua     # Database interface
│       ├── fzf.lua        # Fuzzy finder
│       ├── go.lua         # Go development
│       ├── grug-far.lua   # Search & replace
│       ├── lsp.lua        # Language servers
│       ├── lualine.lua    # Status line
│       ├── markdown.lua   # Markdown rendering
│       ├── mini.lua       # Essential mini plugins
│       ├── oil.lua        # File manager
│       ├── sleuth-vim.lua # Smart indentation
│       ├── snacks.lua     # Swiss army knife utilities
│       ├── theme.lua      # GitHub theme
│       ├── todo.lua       # TODO comments
│       ├── treesitter.lua # Syntax highlighting
│       ├── type.lua       # Typing practice
│       ├── which-key.lua  # Key hints
│       └── witt-neovim.lua # Additional utility
```

## ⌨️ Essential Keybindings

### 🔥 Core Navigation

| Key       | Action       | Description           |
| --------- | ------------ | --------------------- |
| `<Space>` | `<Leader>`   | Leader key            |
| `jk`      | `<ESC>`      | Exit insert mode      |
| `<C-s>`   | Save         | Save file (all modes) |
| `<C-a>`   | Select all   | Select entire buffer  |
| `-`       | File manager | Open Oil float        |

### 🪟 Window Management

| Key           | Action           | Description                                    |
| ------------- | ---------------- | ---------------------------------------------- |
| `<C-h/j/k/l>` | Navigate         | Switch between windows (works in terminal too) |
| `<leader>\|`  | Vertical split   | Split window vertically                        |
| `<leader>\\`  | Horizontal split | Split window horizontally                      |
| `<leader>Z`   | Zoom mode        | Toggle window zoom                             |

### 📄 Buffer Navigation

| Key                   | Action         | Description                  |
| --------------------- | -------------- | ---------------------------- |
| `<A-,>` / `<A-.>`     | Switch buffers | Previous/Next buffer         |
| `<A-S-,>` / `<A-S-.>` | Move buffers   | Move buffer left/right       |
| `<A-1-9>`             | Go to buffer   | Jump to buffer by number     |
| `<A-0>`               | Last buffer    | Jump to last buffer          |
| `<A-p>`               | Pin buffer     | Pin/unpin current buffer     |
| `<leader>bO`          | Close others   | Close all but current/pinned |
| `<leader>bd`          | Delete buffer  | Smart buffer deletion        |

### 💾 Session Management

| Key          | Action           | Description                              |
| ------------ | ---------------- | ---------------------------------------- |
| `<leader>ss` | Save session     | Save session with custom name            |
| `<leader>sr` | Read session     | Load existing session                    |
| `<leader>sd` | Delete session   | Delete saved session                     |
| `<leader>sl` | List sessions    | Show all available sessions              |
| `<leader>sc` | Save current     | Save current named session               |
| `<leader>s.` | Save dir session | Save session with current directory name |

### 🔍 Fuzzy Finding (FZF)

| Key          | Action            | Description                 |
| ------------ | ----------------- | --------------------------- |
| `<leader>ff` | Find files        | Search files in project     |
| `<leader>fC` | Config files      | Search in Neovim config     |
| `<leader>fg` | Live grep         | Search text in project      |
| `<leader>f/` | Grep current dir  | Search in current directory |
| `<leader>fo` | Recent files      | Open recent files           |
| `<leader>fb` | Open buffers      | List open buffers           |
| `<leader>fc` | Commands          | Search available commands   |
| `<leader>fw` | Word under cursor | Find current word           |
| `<leader>fW` | WORD under cursor | Find WORD under cursor      |
| `<leader>fh` | Help tags         | Search help documentation   |
| `<leader>fk` | Keymaps           | Search keybindings          |
| `<leader>fd` | Diagnostics       | Document diagnostics        |
| `<leader>fr` | Resume            | Resume last search          |

### 🔧 LSP & Development

| Key          | Action           | Description                              |
| ------------ | ---------------- | ---------------------------------------- |
| `gd`         | Go to definition | Jump to definition                       |
| `gr`         | References       | Show references                          |
| `gi`         | Implementation   | Go to implementation                     |
| `gt`         | Type definition  | Go to type definition                    |
| `K`          | Hover docs       | Show documentation                       |
| `gK`         | Signature help   | Show function signature                  |
| `<C-h>`      | Signature help   | Signature help (insert mode)             |
| `<leader>ca` | Code action      | Show code actions                        |
| `<leader>cr` | Rename           | Rename symbol                            |
| `<leader>iH` | Global hints     | Toggle inlay hints (global)              |
| `<leader>ih` | Buffer hints     | Toggle inlay hints (current buffer only) |
| `<leader>lh` | LSP hints        | Toggle inlay hints (LSP buffer-specific) |
| `<leader>f`  | Format           | Format code                              |
| `<leader>df` | Diagnostic float | Show diagnostic popup                    |

### 🔌 Completion (Blink.cmp)

| Key         | Action        | Description                     |
| ----------- | ------------- | ------------------------------- |
| `<Tab>`     | Next item     | Select next completion item     |
| `<S-Tab>`   | Previous item | Select previous completion item |
| `<CR>`      | Accept        | Accept completion               |
| `<C-d>`     | Documentation | Show/hide documentation         |
| `<C-e>`     | Hide          | Hide completion menu            |
| `<C-space>` | Show          | Force show completion           |

### 🛠️ Language-Specific

#### Go Development

| Key          | Action   | Description          |
| ------------ | -------- | -------------------- |
| `<leader>ga` | Alt file | Go to alternate file |
| `<leader>gi` | Imports  | Organize imports     |
| `<leader>gb` | Build    | Build project        |
| `<leader>gr` | Run      | Run current file     |
| `<leader>gt` | Test     | Run tests            |
| `<leader>gT` | Test File   | Run tests in file    |
| `<leader>gf` | Fill Struct | Fill struct fields   |
| `<leader>ge` | If Err      | Add if err check     |

#### Database (SQL)

| Key          | Action    | Description             |
| ------------ | --------- | ----------------------- |
| `<leader>Do` | DB Open   | Open database UI        |
| `<leader>Du` | DB Toggle | Toggle database UI      |
| `<leader>Da` | DB Add    | Add connection          |
| `<leader>Dr` | Execute   | Execute query/selection |

### 🔄 Search & Replace

| Key          | Action           | Description              |
| ------------ | ---------------- | ------------------------ |
| `<leader>sr` | Search & replace | Open Grug-Far            |
| `<leader>sw` | Search word      | Search word under cursor |
| `<leader>sb` | Search buffer    | Search in current buffer |
| `<leader>sv` | Search selection | Search visual selection  |

### 📝 Text Manipulation & Operations

| Key           | Action         | Description                               |
| ------------- | -------------- | ----------------------------------------- |
| `J/K`         | Move lines     | Move selected lines up/down (visual mode) |
| `</>`         | Indent         | Indent/outdent selection                  |
| `<A-h/j/k/l>` | Move text      | Move text in all directions               |
| `gsa/gsd/gsr` | Surround       | Add/delete/replace surroundings           |
| `<leader>y`   | System copy    | Copy to system clipboard                  |
| `p`           | Paste (visual) | Paste without overwriting register        |

#### Advanced Text Operations

| Key  | Action     | Description                      |
| ---- | ---------- | -------------------------------- |
| `gS` | Split/join | Smart split/join code constructs |
| `ga` | Align      | Align text (visual mode)         |
| `g=` | Evaluate   | Evaluate expression and replace  |
| `gx` | Exchange   | Exchange text regions            |
| `gm` | Multiply   | Multiply (duplicate) text        |
| `gr` | Replace    | Replace with register content    |
| `gs` | Sort       | Sort selected text               |

### 🧭 Enhanced Navigation

| Key         | Action          | Description                                                   |
| ----------- | --------------- | ------------------------------------------------------------- |
| `]w` / `[w` | Word references | Next/previous word reference (use ]w/[w for word occurrences) |
| `]]` / `[[` | Function refs   | Next/previous function reference                              |
| `]q` / `[q` | Quickfix        | Next/previous quickfix item                                   |
| `]t` / `[t` | TODOs           | Next/previous TODO comment                                    |
| `<C-d/u>`   | Scroll          | Half-page scroll (centered)                                   |
| `n/N`       | Search          | Next/prev search (centered)                                   |

### 📋 TODO Management

| Key          | Action         | Description                |
| ------------ | -------------- | -------------------------- |
| `]t` / `[t`  | Navigate TODOs | Next/previous TODO comment |
| `<leader>ft` | Search TODOs   | Find all TODO comments     |

### ⚙️ Toggle Utilities

| Key          | Action              | Description                |
| ------------ | ------------------- | -------------------------- |
| `<leader>ud` | Toggle diagnostics  | Enable/disable diagnostics |
| `<leader>ul` | Toggle line numbers | Show/hide line numbers     |
| `<leader>uw` | Toggle wrap         | Enable/disable word wrap   |
| `<leader>us` | Toggle spelling     | Enable/disable spell check |
| `<leader>uh` | Toggle inlay hints  | Show/hide inlay hints      |
| `<leader>uT` | Toggle treesitter   | Enable/disable treesitter  |
| `<leader>ub` | Toggle background   | Switch dark/light theme    |

### 🎯 Quick Actions & Utilities

| Key           | Action              | Description             |
| ------------- | ------------------- | ----------------------- |
| `<leader>nh`  | No highlight        | Clear search highlights |
| `<leader>+/-` | Increment/decrement | Modify numbers          |
| `<C-t>`       | Terminal            | Toggle terminal         |
| `<leader>gg`  | Lazygit             | Open Git interface      |
| `<leader>z`   | Zen mode            | Distraction-free mode   |
| `<leader>Z`   | Zoom mode           | Focus current window    |
| `<ESC><ESC>`  | Exit terminal       | Exit terminal mode      |

### 🛠️ Development & File Operations

| Key          | Action           | Description               |
| ------------ | ---------------- | ------------------------- |
| `<leader>e`  | Explorer         | File explorer             |
| `<leader>.`  | Scratch buffer   | Open scratch buffer       |
| `<leader>S`  | Scratch select   | Select scratch buffer     |
| `<leader>cR` | Rename file      | Rename current file       |
| `<leader>gB` | Git browse       | Open file in browser      |
| `<leader>un` | Notifications    | Show notification history |
| `<leader>dP` | Profiler         | Performance profiler      |
| `<leader>dp` | Profiler scratch | Profiler scratch buffer   |


### Session Management Mastery

- Use `<leader>s.` for instant project-based sessions
- Auto-save ensures your work is always preserved
- Sessions remember splits, cursor positions, and open files
- Perfect for juggling multiple projects simultaneously

### Completion with Blink.cmp

- `<Tab>` and `<S-Tab>` for intuitive navigation
- `<C-d>` shows documentation without conflicts
- Auto-brackets for faster coding
- Smart source prioritization (LSP > Path > Snippets > Buffer)

### Text Operations

- `gS` intelligently splits/joins function calls and arrays
- `ga` aligns code on any character (=, :, etc.)
- `g=` evaluates math expressions inline
- `gx` swaps function arguments or code blocks
- `gm` duplicates with smart positioning

### Navigation

- Enhanced window navigation works in terminal mode too
- `]w` and `[w` for word occurrence jumping (use ]]/[[ for functions)
- Status column integration shows git changes and folds
- Smart centering keeps important content visible

### Development

- Global `<leader>iH` for quick inlay hint toggling
- Buffer-specific `<leader>ih` for focused work
- `<leader>cR` renames files with full LSP integration
- `<leader>gB` shares code via browser instantly
- Scratch buffers (`<leader>.`) for quick experiments

### Terminal Integration

- `<C-t>` toggles terminal from anywhere
- Full window navigation works in terminal mode
- `<ESC><ESC>` exits terminal mode cleanly
- Seamless workflow between code and terminal

### Performance Optimizations

- Large files (>100KB) automatically disable heavy features
- Smart lazy loading optimizes startup time
- Status column integration reduces plugin overhead
- Treesitter performance tuning for smooth experience

### Git Integration

- Status column shows git changes inline
- `<leader>gg` opens full Lazygit interface
- `<leader>gB` creates shareable links instantly
- Enhanced diff algorithms for better merge resolution

### Keyboard-Driven Efficiency

- `jk` escape is faster than reaching for ESC
- Leader key optimally positioned at spacebar
- Visual paste preserves register content
- Consistent toggle patterns under `<leader>u*`
- Smart search centering keeps context visible

### Database Development

- Visual query building with `:DBUI`
- Execute selections with `<leader>Dr`
- Multiple database type support
- Query history and result management
- Connection management built-in

### Go Development Excellence

- Auto-imports and formatting on save
- Inlay hints for type clarity
- Integrated testing and building
- Smart alternate file navigation
- Performance-optimized for large codebases

---

## 🚀 Getting Started

1. **Installation**: All plugins will auto-install on first launch
2. **Health Check**: Run `:checkhealth` to verify setup
3. **Try Key Features**:

   - `<leader>ss` - Create your first session
   - `<Tab>` in insert mode - Experience blink.cmp
   - `gS` on a function call - See smart split/join
   - `<leader>iH` - Toggle inlay hints globally
   - `<C-d>` in completion - View documentation

4. **Explore Advanced Features**:

   - Visual select text and try `ga` for alignment
   - Use `g=` on math expressions (e.g., `2 + 2`)
   - Try `gx` to exchange text regions
   - `<leader>.` for scratch buffer experiments

5. **Optimize Your Workflow**:
   - Set up your first database connection with `<leader>Da`
   - Configure Go project with automatic imports
   - Use `<leader>gg` to explore Lazygit integration
   - Try `<leader>z` for distraction-free coding
---
