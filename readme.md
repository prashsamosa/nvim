
## 📋 Requirements

- **Neovim**: 0.11+ (recommended)
- **Git**: For plugin management and git features
- **Node.js**: For LSP servers and formatters
- **Python**: For Python LSP and formatters
- **Go**: For Go development tools
- **Rust**: For Rust analyzer and tools

## 🔧 Leader Keys

- **Leader**: `<Space>`
- **Local Leader**: `\`

## 📁 Directory Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua           # Plugin manager setup
│   │   ├── options.lua        # Neovim options and autocmds
│   │   └── keymaps.lua        # Global keybindings
│   └── plugins/
│       ├── barbar.lua         # Buffer tabs
│       ├── blink-cmp.lua      # Completion engine
│       ├── comment.lua        # Smart commenting
│       ├── conform.lua        # Code formatting
│       ├── dadbod.lua         # Database interface
│       ├── fzf.lua           # Fuzzy finder
│       ├── go.lua            # Go development
│       ├── grug-far.lua      # Search & replace
│       ├── lsp.lua           # Language servers
│       ├── lualine.lua       # Status line
│       ├── markdown.lua      # Markdown rendering
│       ├── mini.lua          # Mini.nvim modules
│       ├── oil.lua           # File manager
│       ├── sleuth-vim.lua    # Auto-detect indentation
│       ├── snacks.lua        # Multi-purpose utilities
│       ├── theme.lua         # GitHub theme
│       ├── todo.lua          # TODO comments
│       ├── treesitter.lua    # Syntax highlighting
│       ├── type.lua          # Typing practice
│       ├── which-key.lua     # Key binding hints
│       └── witt-neovim.lua   # Additional utilities
└── README.md                  # This file
```

## ⌨️ Keybindings Reference

### Essential Operations

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `jk` | Insert | Exit insert mode | Quick escape |
| `<C-s>` | Normal/Insert/Visual | Save file | Universal save |
| `<leader>nh` | Normal | Clear search | Remove search highlights |

### File Operations

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader><space>` | Normal | Find files | Smart file finder |
| `<leader>ff` | Normal | FZF files | FZF file search |
| `<leader>fo` | Normal | Recent files | Recently opened files |
| `<leader>fC` | Normal | Config files | Search config directory |
| `-` | Normal | Oil file manager | Floating file browser |
| `<leader>e` | Normal | Snacks explorer | File explorer |
| `<leader>rf` | Normal | Rename file | Rename current file |

### Search & Navigation

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>fg` | Normal | Live grep | Search in files |
| `<leader>fw` | Normal | Find word | Search word under cursor |
| `<leader>f/` | Normal | Grep current dir | Search in current directory |
| `<leader>sr` | Normal | Search & replace | Project-wide replace |
| `<leader>sw` | Normal | Replace word | Replace word under cursor |
| `<leader>sb` | Normal | Search in buffer | Buffer-specific search |
| `<leader>sv` | Visual | Replace selection | Replace selected text |

### Buffer Management

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>,` | Normal | Buffer picker | Quick buffer switch |
| `<leader>bc` | Normal | Close buffer | Delete current buffer |
| `<leader>bo` | Normal | Close others | Delete other buffers |
| `<A-,>` | Normal | Previous buffer | Barbar navigation |
| `<A-.>` | Normal | Next buffer | Barbar navigation |
| `<A-1>` to `<A-9>` | Normal | Go to buffer N | Direct buffer access |
| `<A-p>` | Normal | Pin buffer | Pin/unpin buffer |
| `<leader>bO` | Normal | Close unpinned | Close all but pinned |

### Window Management

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-h/j/k/l>` | Normal | Window navigation | Move between windows |
| `<leader>\|` | Normal | Vertical split | Split window vertically |
| `<leader>\\` | Normal | Horizontal split | Split window horizontally |

### LSP Features

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `gd` | Normal | Go to definition | Jump to definition |
| `gr` | Normal | References | Find references |
| `gi` | Normal | Implementation | Go to implementation |
| `gt` | Normal | Type definition | Go to type definition |
| `K` | Normal | Hover info | Show documentation |
| `gK` | Normal | Signature help | Function signature |
| `<leader>ca` | Normal/Visual | Code action | Available code actions |
| `<leader>cr` | Normal | Rename | Rename symbol |
| `<leader>lh` | Normal | Toggle inlay hints | Show/hide type hints |

### Diagnostics

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>df` | Normal | Show diagnostic | Diagnostic float |
| `<leader>dq` | Normal | Quickfix list | All diagnostics |
| `[d` | Normal | Previous diagnostic | Navigate diagnostics |
| `]d` | Normal | Next diagnostic | Navigate diagnostics |
| `<leader>fd` | Normal | FZF diagnostics | Search diagnostics |

### Code Formatting

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>f` | Normal/Visual | Format code | Format buffer/selection |
| `<leader>tf` | Normal | Toggle format | Toggle auto-format |
| `<leader>tF` | Normal | Toggle buffer format | Toggle for current buffer |

### Git Integration

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>gg` | Normal | Lazygit | Open Lazygit |
| `<leader>gb` | Normal | Git blame | Show blame for line |
| `<leader>gB` | Normal | Git browse | Browse on GitHub/GitLab |

### Terminal

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-t>` | Normal/Terminal | Toggle terminal | Snacks terminal |
| `<ESC><ESC>` | Terminal | Exit terminal | Back to normal mode |

### Go Development

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>ga` | Normal | Alternate file | Switch to test/impl |
| `<leader>gi` | Normal | Organize imports | Fix imports |
| `<leader>gs` | Normal | Fill struct | Auto-fill struct |
| `<leader>gb` | Normal | Build | Build package |
| `<leader>gx` | Normal | Run file | Execute current file |
| `<leader>gta` | Normal | Test all | Run all tests |
| `<leader>gtf` | Normal | Test function | Test current function |
| `<leader>gtc` | Normal | Coverage | Show test coverage |

### Database (Dadbod)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>Do` | Normal | Open DB UI | Database interface |
| `<leader>Du` | Normal | Toggle DB UI | Show/hide DB UI |
| `<leader>Da` | Normal | Add connection | New DB connection |
| `<leader>Df` | Normal | Find buffer | Find DB buffer |
| `<leader>Dr` | Normal/Visual | Execute query | Run SQL query |

### Markdown

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>mt` | Normal | Toggle render | Markdown preview |
| `<leader>me` | Normal | Enable render | Turn on preview |
| `<leader>md` | Normal | Disable render | Turn off preview |

### TODO Comments

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `]t` | Normal | Next TODO | Jump to next TODO |
| `[t` | Normal | Previous TODO | Jump to previous TODO |
| `<leader>st` | Normal | Search TODOs | Find all TODOs |

### Mini.nvim Features

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `gsa` | Normal/Visual | Add surround | Surround with chars |
| `gsd` | Normal | Delete surround | Remove surrounding |
| `gsr` | Normal | Replace surround | Change surrounding |
| `gS` | Normal | Split/Join | Toggle code structure |
| `<A-h/j/k/l>` | Normal/Visual | Move text | Move lines/selection |

### Utilities

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>z` | Normal | Zen mode | Distraction-free editing |
| `<leader>.` | Normal | Scratch buffer | Temporary buffer |
| `<leader>x` | Normal | Source file | Execute Lua file |
| `<leader>un` | Normal | Notifications | Show notification history |
| `<leader>uN` | Normal | Clear notifications | Dismiss all notifications |

## 🔧 Configuration Details

### LSP Servers

Automatically installed and configured:
- **Lua**: lua-language-server
- **JavaScript/TypeScript**: typescript-language-server
- **Go**: gopls
- **Python**: pyright
- **Rust**: rust-analyzer
- **JSON**: json-lsp
- **YAML**: yaml-language-server
- **Bash**: bash-language-server
- **HTML/CSS**: emmet-language-server, tailwindcss-language-server

### Formatters

- **Lua**: stylua
- **JavaScript/TypeScript**: prettierd/prettier
- **Go**: goimports, gofumpt
- **Python**: black, isort
- **Rust**: rustfmt
- **Shell**: shfmt
- **General**: codespell, trim_whitespace

### Treesitter Parsers

Auto-installed for supported languages:
bash, c, cpp, css, go, html, javascript, json, lua, markdown, python, rust, tsx, typescript, vim, yaml, toml, dockerfile, gitignore

## 🎨 Themes & UI

- **Colorscheme**: GitHub Dark (with transparency)
- **Status Line**: Lualine with LSP info and git status
- **Buffer Tabs**: Barbar with git integration
- **Icons**: Nerd Font icons throughout
- **Borders**: Rounded borders for floating windows

## 🚀 Performance Optimizations

- **Lazy Loading**: Plugins load only when needed
- **Disabled Providers**: Unused language providers disabled
- **Fast Startup**: Optimized plugin loading order
- **Large File Handling**: Treesitter disabled for files >100KB
- **Smart Completion**: Context-aware completion triggers

## 📝 File Types & Features

### Markdown
- Live preview with render-markdown.nvim
- Enhanced syntax highlighting
- Table formatting
- Checkbox support

### Go
- Full LSP integration with gopls
- Test running and coverage
- Struct filling and interface implementation
- Import organization

### Database
- SQL syntax highlighting
- Query execution
- Connection management
- Result viewing

## 🔍 Search Capabilities

- **FZF Integration**: Fast file and content search
- **Live Grep**: Real-time text search across project
- **Word Search**: Quick search for word under cursor
- **Project Replace**: Powerful find and replace with Grug-far
