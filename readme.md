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
│       ├── mini-sessions.lua # Session management
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

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>` | `<Leader>` | Leader key |
| `jk` | `<ESC>` | Exit insert mode |
| `<C-s>` | Save | Save file (all modes) |
| `<C-a>` | Select all | Select entire buffer |
| `-` | File manager | Open Oil float |

### 🪟 Window Management

| Key | Action | Description |
|-----|--------|-------------|
| `<C-h/j/k/l>` | Navigate | Switch between windows |
| `<leader>\|` | Vertical split | Split window vertically |
| `<leader>\\` | Horizontal split | Split window horizontally |
| `<leader>Z` | Zoom mode | Toggle window zoom |

### 📄 Buffer Navigation

| Key | Action | Description |
|-----|--------|-------------|
| `<A-,>` / `<A-.>` | Switch buffers | Previous/Next buffer |
| `<A-S-,>` / `<A-S-.>` | Move buffers | Move buffer left/right |
| `<A-1-9>` | Go to buffer | Jump to buffer by number |
| `<A-0>` | Last buffer | Jump to last buffer |
| `<A-p>` | Pin buffer | Pin/unpin current buffer |
| `<leader>bO` | Close others | Close all but current/pinned |
| `<leader>bd` | Delete buffer | Smart buffer deletion |

### 💾 Session Management

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>Ss` | Save session | Save session with custom name |
| `<leader>Sr` | Read session | Load existing session |
| `<leader>Sd` | Delete session | Delete saved session |
| `<leader>Sl` | List sessions | Show all available sessions |
| `<leader>Sc` | Save current | Save current named session |
| `<leader>S.` | Save dir session | Save session with current directory name |

### 🔍 Fuzzy Finding (FZF)

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | Find files | Search files in project |
| `<leader>fC` | Config files | Search in Neovim config |
| `<leader>fg` | Live grep | Search text in project |
| `<leader>f/` | Grep current dir | Search in current directory |
| `<leader>fo` | Recent files | Open recent files |
| `<leader>fb` | Open buffers | List open buffers |
| `<leader>fc` | Commands | Search available commands |
| `<leader>fw` | Word under cursor | Find current word |
| `<leader>fW` | WORD under cursor | Find WORD under cursor |
| `<leader>fh` | Help tags | Search help documentation |
| `<leader>fk` | Keymaps | Search keybindings |
| `<leader>fd` | Diagnostics | Document diagnostics |
| `<leader>fr` | Resume | Resume last search |

### 🔧 LSP & Development

| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Jump to definition |
| `gr` | References | Show references |
| `gi` | Implementation | Go to implementation |
| `gt` | Type definition | Go to type definition |
| `K` | Hover docs | Show documentation |
| `gK` | Signature help | Show function signature |
| `<C-h>` | Signature help | Signature help (insert) |
| `<leader>ca` | Code action | Show code actions |
| `<leader>cr` | Rename | Rename symbol |
| `<leader>lh` | Toggle hints | Toggle inlay hints |
| `<leader>f` | Format | Format code |
| `<leader>df` | Diagnostic float | Show diagnostic popup |

### 🛠️ Language-Specific

#### Go Development
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ga` | Alt file | Go to alternate file |
| `<leader>gi` | Imports | Organize imports |
| `<leader>gb` | Build | Build project |
| `<leader>gr` | Run | Run current file |
| `<leader>gt` | Test | Run tests |

#### Database (SQL)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>Do` | DB Open | Open database UI |
| `<leader>Du` | DB Toggle | Toggle database UI |
| `<leader>Da` | DB Add | Add connection |
| `<leader>Dr` | Execute | Execute query/selection |

### 🔄 Search & Replace

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>sr` | Search & replace | Open Grug-Far |
| `<leader>sw` | Search word | Search word under cursor |
| `<leader>sb` | Search buffer | Search in current buffer |
| `<leader>sv` | Search selection | Search visual selection |

### 📝 Text Manipulation & Operations

| Key | Action | Description |
|-----|--------|-------------|
| `J/K` | Move lines | Move selected lines up/down |
| `</>`| Indent | Indent/outdent selection |
| `<A-h/j/k/l>` | Move text | Move text in all directions |
| `gsa/gsd/gsr` | Surround | Add/delete/replace surroundings |
| `<leader>y` | System copy | Copy to system clipboard |
| `p` | Paste (visual) | Paste without overwriting register |

#### Advanced Text Operations
| Key | Action | Description |
|-----|--------|-------------|
| `gS` | Split/join | Smart split/join code constructs |
| `ga` | Align | Align text (visual mode) |
| `g=` | Evaluate | Evaluate expression and replace |
| `gx` | Exchange | Exchange text regions |
| `gm` | Multiply | Multiply (duplicate) text |
| `gr` | Replace | Replace with register content |
| `gs` | Sort | Sort selected text |

### 🧭 Enhanced Navigation

| Key | Action | Description |
|-----|--------|-------------|
| `]]` / `[[` | Word references | Next/previous word reference |
| `]f` / `[f` | Files | Next/previous file in list |
| `]q` / `[q` | Quickfix | Next/previous quickfix item |
| `]t` / `[t` | TODOs | Next/previous TODO comment |
| `]i` / `[i` | Indent | Next/previous same indent |
| `]j` / `[j` | Jumps | Next/previous jump |
| `]l` / `[l` | Location | Next/previous location |
| `]o` / `[o` | Oldfiles | Next/previous old file |
| `]u` / `[u` | Undo | Next/previous undo state |
| `]w` / `[w` | Windows | Next/previous window |
| `]y` / `[y` | Yank | Next/previous yank |

### 📋 TODO Management

| Key | Action | Description |
|-----|--------|-------------|
| `]t` / `[t` | Navigate TODOs | Next/previous TODO comment |
| `<leader>ft` | Search TODOs | Find all TODO comments |

### ⚙️ Toggle Utilities

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ud` | Toggle diagnostics | Enable/disable diagnostics |
| `<leader>ul` | Toggle line numbers | Show/hide line numbers |
| `<leader>uw` | Toggle wrap | Enable/disable word wrap |
| `<leader>us` | Toggle spelling | Enable/disable spell check |
| `<leader>uh` | Toggle inlay hints | Show/hide inlay hints |
| `<leader>uT` | Toggle treesitter | Enable/disable treesitter |
| `<leader>ub` | Toggle background | Switch dark/light theme |

### 🎯 Quick Actions & Utilities

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>nh` | No highlight | Clear search highlights |
| `<leader>+/-` | Increment/decrement | Modify numbers |
| `<C-d/u>` | Scroll | Half-page scroll (centered) |
| `n/N` | Search | Next/prev search (centered) |
| `<C-t>` | Terminal | Toggle terminal |
| `<leader>gg` | Lazygit | Open Git interface |
| `<leader>z` | Zen mode | Distraction-free mode |
| `<leader>Z` | Zoom mode | Focus current window |

### 🛠️ Development & File Operations

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Explorer | File explorer |
| `<leader>.` | Scratch buffer | Open scratch buffer |
| `<leader>S` | Select scratch | Select scratch buffer |
| `<leader>cR` | Rename file | Rename current file |
| `<leader>gB` | Git browse | Open file in browser |
| `<leader>un` | Notifications | Show notification history |
| `<leader>dP` | Profiler | Performance profiler |
| `<leader>dp` | Profiler scratch | Profiler scratch buffer |

## 🎯 Language Server Setup

### Automatically Installed Tools

**Language Servers:**
- `lua-language-server` - Lua LSP
- `typescript-language-server` - TypeScript/JavaScript LSP
- `gopls` - Go LSP
- `pyright` - Python LSP
- `rust-analyzer` - Rust LSP
- `tailwindcss-language-server` - Tailwind CSS LSP
- `json-lsp` - JSON LSP
- `yaml-language-server` - YAML LSP
- `bash-language-server` - Bash LSP
- `emmet-language-server` - Emmet LSP

**Formatters & Linters:**
- `stylua` - Lua formatting
- `prettierd` - Fast JS/TS/JSON/YAML formatting
- `shfmt` - Shell script formatting
- `goimports`, `gofumpt` - Go formatting
- `black`, `isort` - Python formatting
- `eslint_d` - JavaScript linting
- `shellcheck` - Shell script linting

## 📦 Plugin Breakdown

### Core Functionality
- **lazy.nvim** - Modern plugin manager
- **nvim-lspconfig** - LSP configuration
- **blink.cmp** - Lightning-fast completion
- **nvim-treesitter** - Advanced syntax highlighting

### File Management
- **oil.nvim** - Buffer-based file manager
- **fzf-lua** - Blazing fast fuzzy finder
- **snacks.nvim** - Multi-utility plugin with enhanced features

### Session Management
- **mini.sessions** - Lightweight session management
  - Auto-save sessions on exit
  - Interactive session selection
  - Directory-based quick sessions

### Development Experience
- **conform.nvim** - Code formatting
- **grug-far.nvim** - Search and replace
- **todo-comments.nvim** - TODO highlighting
- **Comment.nvim** - Smart commenting

### UI/Visual Enhancement
- **github-nvim-theme** - Clean GitHub theme
- **lualine.nvim** - Customizable statusline
- **barbar.nvim** - Buffer tabs
- **render-markdown.nvim** - Beautiful markdown
- **snacks.statuscolumn** - Enhanced status column with git signs

### Language-Specific
- **go.nvim** - Enhanced Go development
- **vim-dadbod-ui** - Database management

### Quality of Life Features
- **mini.nvim** - Essential mini plugins collection:
  - **mini.ai** - Enhanced text objects
  - **mini.surround** - Surround text operations
  - **mini.pairs** - Auto-pair brackets
  - **mini.move** - Move text around
  - **mini.sessions** - Session management
  - **mini.splitjoin** - Smart split/join constructs
  - **mini.align** - Text alignment
  - **mini.bracketed** - Enhanced bracket navigation
  - **mini.operators** - Powerful text operations

- **snacks.nvim** - Comprehensive utilities:
  - **bigfile** - Large file handling
  - **dashboard** - Welcome screen
  - **terminal** - Terminal integration
  - **scroll** - Smooth scrolling
  - **notifier** - Notification system
  - **bufdelete** - Smart buffer deletion
  - **zen** - Distraction-free mode
  - **words** - Word highlighting and navigation
  - **statuscolumn** - Enhanced status column
  - **picker** - Alternative file picker
  - **input** - Enhanced input dialogs
  - **quickfile** - Fast file opening
  - **scope** - Buffer scope management
  - **scratch** - Scratch buffers
  - **rename** - File renaming
  - **gitbrowse** - Git browser integration
  - **toggle** - Option toggling utilities
  - **profiler** - Performance profiling
  - **dim** - Window dimming

- **which-key.nvim** - Keymap hints
- **vim-sleuth** - Smart indentation detection

## ⚡ Pro Tips

### Session Management Workflow
- Use `<leader>S.` for quick project sessions
- Auto-save keeps your work safe on exit
- Sessions remember open files, splits, and cursor positions
- Perfect for switching between multiple projects

### Text Operations Mastery
- `gS` to split long function calls or join short ones
- `ga` in visual mode to align code on specific characters
- `g=` to evaluate math expressions or code inline
- `gx` to swap function arguments or text blocks
- `gm` to duplicate lines or blocks quickly

### Navigation Excellence
- Use `]]` and `[[` to jump between word occurrences
- Bracket navigation (`]f`, `[f`, etc.) for quick movement
- Status column shows git changes and fold information
- Enhanced indentation guides with scope highlighting

### Development Workflow
- `<leader>cR` to rename files with LSP integration
- `<leader>gB` to open files in browser for sharing
- `<leader>dP` for performance profiling when needed
- Scratch buffers (`<leader>.`) for quick notes and experiments

### Toggle System
- All toggles under `<leader>u*` for consistency
- Quick theme switching with `<leader>ub`
- Diagnostic toggling for clean screenshots
- Spell check toggling for writing modes

### Performance Optimizations
- Large files automatically disable heavy features
- Treesitter highlighting disabled for files >100KB
- Lazy loading optimized for fast startup
- Status column integration reduces plugin overhead
- Quickfile feature for instant file opening

### Advanced Features
- Git integration in status column
- Smart window dimming for focus
- Profiler for performance analysis
- Enhanced input dialogs throughout
- Scope-based buffer management

### Workflow Integration
- Use `jk` instead of `<ESC>` - it's faster
- Leader key (`<Space>`) is optimally positioned
- Visual mode paste preserves register content
- Auto-save on `<C-s>` from any mode
- Terminal integration with `<C-t>`

### Database Development
- Use `:DBUI` for visual database management
- Execute queries with `<leader>Dr`
- Supports multiple database types
- Query history and result management

### Go Development
- Auto-imports and formatting on save
- Inlay hints for better type visibility
- Integrated testing and building
- Alternate file navigation

### Git Workflow
- Use `<leader>gg` for full Git interface
- `<leader>gB` to share code via browser
- Buffer-level git signs and blame
- Smart diff algorithms in status column

---

## 🚀 Getting Started

1. Ensure all plugin files are in place:
   - Enhanced `lua/plugins/snacks.lua`
   - Optimized `lua/plugins/mini.lua`
   - New `lua/plugins/mini-sessions.lua`

2. Restart Neovim or run `:Lazy sync`

3. Run `:checkhealth snacks` to verify setup

4. Try the new features:
   - `<leader>Ss` to create your first session
   - `gS` to split/join code constructs
   - `<leader>ud` to toggle diagnostics
   - `<leader>.` for a scratch buffer

5. Explore text operations:
   - Select text and try `ga` for alignment
   - Use `g=` on math expressions
   - Try `gx` to exchange text regions

Your configuration is now a comprehensive, modern Neovim setup with powerful text operations, enhanced navigation, and seamless workflow integration!
