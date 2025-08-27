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
│       └── which-key.lua  # Key hints
│       └── witt-neovim
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

### 📝 Text Manipulation

| Key | Action | Description |
|-----|--------|-------------|
| `J/K` | Move lines | Move selected lines up/down |
| `</>`| Indent | Indent/outdent selection |
| `<A-h/j/k/l>` | Move text | Move text in all directions |
| `gsa/gsd/gsr` | Surround | Add/delete/replace surroundings |
| `<leader>y` | System copy | Copy to system clipboard |
| `p` | Paste (visual) | Paste without overwriting register |

### 📋 TODO Management

| Key | Action | Description |
|-----|--------|-------------|
| `]t` / `[t` | Navigate TODOs | Next/previous TODO comment |
| `<leader>ft` | Search TODOs | Find all TODO comments |

### 🎯 Quick Actions

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>nh` | No highlight | Clear search highlights |
| `<leader>+/-` | Increment/decrement | Modify numbers |
| `<C-d/u>` | Scroll | Half-page scroll (centered) |
| `n/N` | Search | Next/prev search (centered) |
| `<C-t>` | Terminal | Toggle terminal |
| `<leader>gg` | Lazygit | Open Git interface |
| `<leader>z` | Zen mode | Distraction-free mode |

### 🎪 Snacks Utilities

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Explorer | File explorer |
| `<leader>sf` | Snacks files | File picker |
| `<leader>sb` | Snacks buffers | Buffer picker |
| `<leader>sg` | Snacks grep | Text search |
| `<leader>un` | Notifications | Show notification history |

## 🎯 Language Server Setup

### Automatically Installed Tools

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
- **snacks.nvim** - Multi-utility plugin

### Development Experience
- **conform.nvim** - Code formatting
- **grug-far.nvim** - Search and replace
- **todo-comments.nvim** - TODO highlighting
- **Comment.nvim** - Smart commenting

### UI/Visual
- **github-nvim-theme** - Clean GitHub theme
- **lualine.nvim** - Customizable statusline
- **barbar.nvim** - Buffer tabs
- **render-markdown.nvim** - Beautiful markdown

### Language-Specific
- **go.nvim** - Enhanced Go development
- **vim-dadbod-ui** - Database management

### Quality of Life
- **mini.nvim** - Essential mini plugins
- **which-key.nvim** - Keymap hints
- **vim-sleuth** - Smart indentation detection

## ⚡ Pro Tips

### Performance
- Large files (>100KB) automatically disable heavy features
- Treesitter highlighting disabled for files >100KB
- Lazy loading optimized for fast startup

### Workflow Optimizations
- Use `jk` instead of `<ESC>` - it's faster
- Leader key (`<Space>`) is optimally positioned
- Visual mode paste preserves register content
- Auto-save on `<C-s>` from any mode

### Database Development
- Use `:DBUI` for visual database management
- Execute queries with `<leader>Dr`
- Supports multiple database types

### Go Development
- Auto-imports and formatting on save
- Inlay hints for better type visibility
- Integrated testing and building

### Git Workflow
- Use `<leader>gg` for full Git interface
- Buffer-level git signs and blame
- Smart diff algorithms
---
