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
| `<C-h/j/k/l>` | Navigate | Switch between windows (works in terminal too) |
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
| `<C-h>` | Signature help | Signature help (insert mode) |
| `<leader>ca` | Code action | Show code actions |
| `<leader>cr` | Rename | Rename symbol |
| `<leader>lh` | Toggle hints | Toggle inlay hints (buffer-specific) |
| `<leader>ih` | Global hints | Toggle inlay hints (global) |
| `<leader>f` | Format | Format code |
| `<leader>df` | Diagnostic float | Show diagnostic popup |

### 🔌 Completion (Blink.cmp)

| Key | Action | Description |
|-----|--------|-------------|
| `<Tab>` | Next item | Select next completion item |
| `<S-Tab>` | Previous item | Select previous completion item |
| `<CR>` | Accept | Accept completion |
| `<C-j>` | Documentation | Show/hide documentation |
| `<C-e>` | Hide | Hide completion menu |
| `<C-space>` | Show | Force show completion |

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
| `J/K` | Move lines | Move selected lines up/down (visual mode) |
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
| `]q` / `[q` | Quickfix | Next/previous quickfix item |
| `]t` / `[t` | TODOs | Next/previous TODO comment |
| `<C-d/u>` | Scroll | Half-page scroll (centered) |
| `n/N` | Search | Next/prev search (centered) |

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
| `<C-t>` | Terminal | Toggle terminal |
| `<leader>gg` | Lazygit | Open Git interface |
| `<leader>z` | Zen mode | Distraction-free mode |
| `<leader>Z` | Zoom mode | Focus current window |
| `<ESC><ESC>` | Exit terminal | Exit terminal mode |

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
- **blink.cmp** - Lightning-fast completion engine
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
- **barbar.nvim** - Buffer tabs with advanced features
- **render-markdown.nvim** - Beautiful markdown rendering
- **snacks.statuscolumn** - Enhanced status column with git signs

### Language-Specific
- **go.nvim** - Enhanced Go development tools
- **vim-dadbod-ui** - Visual database management

### Quality of Life Features
- **mini.nvim** - Essential mini plugins collection:
  - **mini.ai** - Enhanced text objects
  - **mini.surround** - Surround text operations
  - **mini.pairs** - Auto-pair brackets
  - **mini.move** - Move text around
  - **mini.sessions** - Session management
  - **mini.splitjoin** - Smart split/join constructs
  - **mini.align** - Text alignment
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
  - **input** - Enhanced input dialogs
  - **quickfile** - Fast file opening
  - **scope** - Buffer scope management
  - **scratch** - Scratch buffers
  - **rename** - File renaming
  - **gitbrowse** - Git browser integration
  - **toggle** - Option toggling utilities
  - **profiler** - Performance profiling
  - **dim** - Window dimming

- **which-key.nvim** - Keymap hints and discovery
- **vim-sleuth** - Smart indentation detection

## ⚡ Pro Tips & Workflows

### Session Management Mastery
- Use `<leader>S.` for instant project-based sessions
- Auto-save ensures your work is always preserved
- Sessions remember splits, cursor positions, and open files
- Perfect for juggling multiple projects simultaneously

### Completion Excellence with Blink.cmp
- `<Tab>` and `<S-Tab>` for intuitive navigation
- `<C-j>` shows documentation without conflicts
- Auto-brackets for faster coding
- Smart source prioritization (LSP > Path > Snippets > Buffer)

### Text Operations Mastery
- `gS` intelligently splits/joins function calls and arrays
- `ga` aligns code on any character (=, :, etc.)
- `g=` evaluates math expressions inline
- `gx` swaps function arguments or code blocks
- `gm` duplicates with smart positioning

### Navigation Excellence
- Enhanced window navigation works in terminal mode too
- `]]` and `[[` for word occurrence jumping
- Status column integration shows git changes and folds
- Smart centering keeps important content visible

### Development Workflow
- Global `<leader>ih` for quick inlay hint toggling
- Buffer-specific `<leader>lh` for focused work
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

### Advanced Features You're Getting
- Modern Neovim 0.11+ feature utilization
- Smart buffer scope management
- Enhanced input dialogs throughout
- Performance profiling capabilities
- Window dimming for focus enhancement

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
   - `<leader>Ss` - Create your first session
   - `<Tab>` in insert mode - Experience blink.cmp
   - `gS` on a function call - See smart split/join
   - `<leader>ih` - Toggle inlay hints globally
   - `<C-j>` in completion - View documentation

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

## 🎉 What Makes This Config Special

### Modern Architecture
- **Neovim 0.11+ Features**: Smooth scrolling, enhanced completion, modern diff algorithms
- **Performance First**: Smart lazy loading, large file detection, optimized startup
- **Zero Conflicts**: Carefully orchestrated keybindings without collisions

### Developer Experience
- **Intelligent Completion**: Context-aware suggestions with documentation
- **Advanced Navigation**: Multi-dimensional movement and jumping
- **Session Persistence**: Never lose your workflow state
- **Visual Excellence**: GitHub theme with enhanced status information

### Quality Assurance
- **Conflict-Free Keybindings**: Thoroughly tested key combinations
- **Performance Optimized**: Handles large files and projects gracefully
- **Modern Plugin Ecosystem**: Latest and most maintained plugins
- **Extensible Architecture**: Easy to customize and extend

Your Neovim configuration represents the pinnacle of modern text editor setup - combining performance, aesthetics, and developer productivity in a cohesive, conflict-free package! 🚀✨
