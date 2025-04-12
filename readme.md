# 🚀 Modern Neovim Configuration

A powerful, AI-enhanced Neovim configuration with elegant UI, comprehensive LSP support, VS Code-like experience, and GPT-4o integration via Avante.

## ✨ Key Features

- 🧠 AI assistance with GPT-4o via Avante.nvim
- 🔍 Intelligent code completion with Blink.cmp
- 🌲 Rich syntax highlighting with Treesitter
- 📂 Multiple file explorers (Oil.nvim, Mini.files, Snacks Explorer)
- 🔎 Powerful fuzzy finding with FZF-lua and Snacks
- 🤖 Full LSP integration with diagnostics support
- 📝 VS Code-style keybindings
- 🎨 Beautiful UI with GitHub Dark theme
- 🧰 Rich Git integration

## 🔑 Keybinding Reference

### 🌟 General Navigation

| Key | Description |
|-----|-------------|
| `Space` | Leader key |
| `jk` | Exit insert mode |
| `<C-h/j/k/l>` | Navigate between splits |
| `<leader>[` | Previous buffer |
| `<leader>]` | Next buffer |
| `<S-h>` | Previous buffer (alternative) |
| `<S-l>` | Next buffer (alternative) |
| `<C-s>` | Save file |
| `<C-c>` | Alternative ESC |

### 📂 File Navigation

#### Snacks File Navigation
| Key | Description |
|-----|-------------|
| `<leader><space>` | Smart file finder |
| `<leader>ff` | Find files |
| `<leader>fg` | Find git files |
| `<leader>fr` | Recent files |
| `<leader>fc` | Find config files |
| `<leader>fp` | Browse projects |
| `<leader>,` | Browse buffers |
| `<leader>:` | Command history |
| `<leader>e` | File explorer |

#### FZF-lua Commands (z prefix)
| Key | Description |
|-----|-------------|
| `<leader>zf` | Find files |
| `<leader>zg` | Live grep |
| `<leader>zc` | Find in config |
| `<leader>zh` | Helptags |
| `<leader>zk` | Keymaps |
| `<leader>zb` | FZF builtins |
| `<leader>zw` | Find current word |
| `<leader>zW` | Find current WORD |
| `<leader>zd` | Diagnostics |
| `<leader>zr` | Resume last search |
| `<leader>zo` | Old files |
| `<leader>z<space>` | Buffers |
| `<leader>z/` | Live grep current buffer |

#### File Explorers
| Key | Description |
|-----|-------------|
| `<leader>e` | Snacks file explorer |
| `<leader>me` | Mini file explorer |
| `-` | Oil file manager |

### 🔍 Search Operations

| Key | Description |
|-----|-------------|
| `<leader>/` | Grep (Snacks) |
| `<leader>sg` | Search in files |
| `<leader>ss` | Search in buffer |
| `<leader>sw` | Search word under cursor |
| `<leader>sB` | Search in open buffers |
| `<leader>sb` | Buffer lines |

### 📊 LSP Navigation

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cs` | Document symbols |
| `<leader>ss` | LSP document symbols |
| `<leader>sS` | Workspace symbols |
| `<leader>D` | Type definition (FZF) |
| `<leader>ds` | Document symbols (FZF) |
| `<leader>ws` | Workspace symbols (FZF) |
| `<S-k>` | Show hover |
| `<leader>th` | Toggle inlay hints |

### 🧠 AI Operations (Avante)

| Key | Description |
|-----|-------------|
| `<leader>a` | Toggle Avante chat |
| `<leader>ac` | Avante completion |
| `<leader>ae` | Avante explain code |
| `<leader>at` | Avante generate tests |
| `/avante` | Start Avante command |

### 📝 Editing & Text Manipulation

| Key | Description |
|-----|-------------|
| `<leader>c/` | Toggle comment line |
| `gc` | Comment with mini.comment |
| `gcc` | Comment current line |
| `<S-j>` | Move line down (Visual) |
| `<S-k>` | Move line up (Visual) |
| `<leader>+` | Increment number |
| `<leader>=` | Decrement number |
| `<leader>nh` | Clear search highlights |

### 🌲 Treesitter Text Objects

| Key | Description |
|-----|-------------|
| `af` | Around function |
| `if` | Inner function |
| `ac` | Around class |
| `ic` | Inner class |
| `ao` | Around comment |
| `as` | Around scope |
| `<leader>a` | Swap with next parameter |
| `<leader>A` | Swap with previous parameter |
| `<C-space>` | Incremental selection |
| `<bs>` | Shrink selection |

### 📑 Buffer Management

| Key | Description |
|-----|-------------|
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Delete other buffers |
| `<leader>ba` | Delete all buffers |
| `<leader>mb` | Mini delete buffer |
| `<leader>mB` | Mini force delete buffer |

### 🪟 Window Management

| Key | Description |
|-----|-------------|
| `sh` | Split horizontally |
| `sv` | Split vertically |
| `<leader>se` | Equalize windows |
| `<leader>sx` | Close split |
| `<C-Up/Down/Left/Right>` | Resize splits |
| `<C-h/j/k/l>` | Navigate splits |

### 📑 Tab Management

| Key | Description |
|-----|-------------|
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `<leader>tf` | Open buffer in new tab |

### 📚 Git Operations

| Key | Description |
|-----|-------------|
| `<leader>gs` | Git status |
| `<leader>gb` | Git branches |
| `<leader>gl` | Git log |
| `<leader>gL` | Git log line |
| `<leader>gd` | Git diff hunks |
| `<leader>gf` | Git file log |
| `<leader>gS` | Git stash |
| `<leader>gB` | Git browse |
| `<leader>gg` | Open Lazygit |

### 💻 Terminal Access

| Key | Description |
|-----|-------------|
| `<C-/>` or `<C-_>` | Toggle Snacks terminal |
| `<C-\>` | Toggle ToggleTerm |

### 🔧 UI Options & Toggles

| Key | Description |
|-----|-------------|
| `<leader>us` | Toggle spell checking |
| `<leader>uw` | Toggle line wrapping |
| `<leader>uL` | Toggle relative numbers |
| `<leader>ud` | Toggle diagnostics |
| `<leader>ul` | Toggle line numbers |
| `<leader>uc` | Toggle conceal level |
| `<leader>uT` | Toggle treesitter |
| `<leader>ub` | Toggle dark/light mode |
| `<leader>uh` | Toggle inlay hints |
| `<leader>ug` | Toggle indent guides |
| `<leader>uD` | Toggle dim mode |
| `<leader>un` | Dismiss notifications |

### 🧘 Focus Modes

| Key | Description |
|-----|-------------|
| `<leader>z` | Toggle Zen mode |
| `<leader>Z` | Toggle Zoom mode |

### 📝 Session Management

| Key | Description |
|-----|-------------|
| `<leader>ws` | Save workspace |
| `<leader>wr` | Read last session |
| `<leader>wd` | Delete last session |

### 🔍 Mini.nvim Commands (m prefix)

| Key | Description |
|-----|-------------|
| `<leader>me` | Mini file explorer |
| `<leader>mp` | Mini pick files |
| `<leader>mg` | Mini grep live |
| `<leader>mb` | Mini delete buffer |
| `<leader>mB` | Mini force delete buffer |

### 📋 Special Features

| Key | Description |
|-----|-------------|
| `<leader>.` | Toggle scratch buffer |
| `<leader>S` | Select scratch buffer |
| `<leader>n` | Notification history |
| `<leader>cR` | Rename file |
| `]]` | Next reference |
| `[[` | Previous reference |
| `]t` | Next TODO comment |
| `[t` | Previous TODO comment |

## 🔌 Main Plugins

### 🧠 AI Integration
- **Avante.nvim** - GPT-4o integration for code assistance
- **Blink-cmp-avante** - AI completion in editor

### 🔧 Core & UI
- **Snacks.nvim** - Core functionality and UI enhancements
- **GitHub Theme** - Beautiful dark theme
- **Mini.nvim** - Suite of minimal, independent plugins

### 📂 File & Code Navigation
- **FZF-lua** - Fuzzy finder with rich capabilities
- **Oil.nvim** - File management in buffer
- **Mini.files** - Minimalist file explorer

### 📝 Editing & Completion
- **Blink.cmp** - Fast, Rust-based completion engine
- **Treesitter** - Advanced syntax highlighting
- **Mini.comment** - Smart code commenting
- **Mini.surround** - Text surrounding operations

### 📚 Git Integration
- **Neogit** - Git interface similar to Magit
- **Diffview.nvim** - Git diff viewer

### 💻 Terminal & Utilities
- **Toggleterm.nvim** - Terminal integration
- **Todo-comments.nvim** - Highlight TODO comments

### 📊 LSP & Diagnostics
- **nvim-lspconfig** - Core LSP configuration
- **Mason.nvim** - LSP server installer
- **Conform.nvim** - Code formatting

## 🛠️ Environment Setup

### 1. OpenAI API Key

For Avante with GPT-4o to work, set your OpenAI API key:

```bash
export OPENAI_API_KEY="your-api-key-here"