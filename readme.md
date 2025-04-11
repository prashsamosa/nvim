# 🚀 My Neovim Configuration

A modern, feature-rich Neovim configuration with VS Code-compatible keybindings and a powerful plugin ecosystem featuring Snacks.nvim, FZF-lua, Blink.cmp, and more.

## ✨ Features

- 🔍 Intelligent code completion via Blink.cmp
- 🪲 Built-in LSP integration and diagnostics
- 📂 Multiple file explorers (Oil.nvim, Mini.files)
- 🔎 Advanced fuzzy finding with FZF-lua
- 📚 Git integration with Neogit
- 💅 Code formatting through Conform.nvim
- 🔖 Session management
- 🧰 Treesitter for advanced syntax highlighting and text objects
- 📝 VS Code-compatible keybindings

## 🔑 Keybinding Reference

### 🌟 General Keymaps

| Key | Mode | Description |
|-----|------|-------------|
| `Space` | All | Leader key |
| `jk` | Insert | Exit insert mode |
| `<C-c>` | Insert | Alternative escape |
| `<C-s>` | Normal, Insert | Quick save |
| `<leader>nh` | Normal | Clear search highlights |
| `<leader>+` | Normal | Increment number |
| `<leader>=` | Normal | Decrement number |

### 🪟 Window Navigation (VS Code Style)

| Key | Description |
|-----|-------------|
| `<C-h>` | Navigate left |
| `<C-j>` | Navigate down |
| `<C-k>` | Navigate up |
| `<C-l>` | Navigate right |
| `<leader>se` | Equalize window sizes |
| `<leader>sx` | Close current split |
| `sh` | Split horizontally |
| `sv` | Split vertically |
| `<C-Up/Down/Left/Right>` | Resize splits |

### 📑 Tab & Buffer Management

| Key | Description |
|-----|-------------|
| `<leader>[` | Previous buffer |
| `<leader>]` | Next buffer |
| `<S-h>` | Previous buffer (alternative) |
| `<S-l>` | Next buffer (alternative) |
| `<leader>bd` | Close buffer |
| `<leader>bo` | Close other buffers |
| `<leader>ba` | Delete all buffers (Snacks) |
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `<leader>tf` | Open current buffer in new tab |

### 📂 File Navigation & Operations

| Key | Description |
|-----|-------------|
| `<leader><space>` | Quick open files (Snacks/Telescope) |
| `<leader>e` | Toggle file explorer (Snacks) |
| `<leader>me` | Mini file explorer |
| `-` | Open Oil floating file manager |
| `<leader>ff` | Find files (Snacks) |
| `<leader>fg` | Find Git files (Snacks) |
| `<leader>fr` | Recent files (Snacks) |
| `<leader>zf` | Find files (FZF) |
| `<leader>zo` | Find old/recent files (FZF) |

### 🔍 Search Operations

| Key | Description |
|-----|-------------|
| `<leader>ss` | Search in buffer (Snacks) |
| `<leader>sg` | Search in files (Snacks) |
| `<leader>sw` | Search for word under cursor (Snacks) |
| `<leader>sB` | Search in open buffers (Snacks) |
| `<leader>zg` | Live grep search (FZF) |
| `<leader>zw` | Find current word (FZF) |
| `<leader>zW` | Find current WORD (FZF) |
| `<leader>z/` | Live grep current buffer (FZF) |

### 📊 LSP Navigation & Coding

| Key | Description |
|-----|-------------|
| `gd` | Go to definition (Snacks) |
| `gD` | Go to declaration (Snacks) |
| `gr` | Find references (Snacks) |
| `gI` | Go to implementation (Snacks) |
| `gy` | Go to type definition (Snacks) |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cs` | Document symbols |
| `<leader>ss` | LSP symbols (Snacks) |
| `<leader>sS` | Workspace symbols (Snacks) |
| `<leader>D` | Type definition (FZF) |
| `<leader>ds` | Document symbols (FZF) |
| `<leader>ws` | Workspace symbols (FZF) |
| `<S-k>` | Show hover |
| `<S-j>` | Move line down (Visual) |
| `<S-k>` | Move line up (Visual) |
| `<leader>/` | Toggle comment |
| `<leader>th` | Toggle inlay hints |

### 🖥️ Terminal Operations

| Key | Description |
|-----|-------------|
| `<c-/>` or `<c-_>` | Toggle terminal (Snacks) |
| `<c-\>` | Toggle terminal (ToggleTerm) |

### 🌳 Git Operations

| Key | Description |
|-----|-------------|
| `<leader>gs` | Git status (Snacks) |
| `<leader>gb` | Git branches (Snacks) |
| `<leader>gl` | Git log (Snacks) |
| `<leader>gL` | Git line log (Snacks) |
| `<leader>gd` | Git diff hunks (Snacks) |
| `<leader>gf` | Git file log (Snacks) |
| `<leader>gS` | Git stash (Snacks) |
| `<leader>gB` | Git browse (Snacks) |
| `<leader>gg` | Open Lazygit (Snacks) |

### 📁 Workspace Operations

| Key | Description |
|-----|-------------|
| `<leader>ws` | Save workspace |
| `<leader>wl` | Load workspace |

### 🧘 Focus & Appearance

| Key | Description |
|-----|-------------|
| `<leader>z` | Toggle zen mode (Snacks) |
| `<leader>Z` | Toggle zoom (Snacks) |

### 🌲 Treesitter Text Objects

| Key | Description |
|-----|-------------|
| `af` | Select outer function |
| `if` | Select inner function |
| `ac` | Select outer class |
| `ic` | Select inner class |
| `ao` | Select outer comment |
| `as` | Select scope |
| `<leader>a` | Swap with next parameter |
| `<leader>A` | Swap with previous parameter |
| `<C-space>` | Start incremental selection |
| `<bs>` | Shrink selection |

### 🔎 FZF-lua Commands (Fuzzy Finding)

| Key | Description |
|-----|-------------|
| `<leader>zf` | Find files (FZF) |
| `<leader>zg` | Live grep (FZF) |
| `<leader>zc` | Find in config (FZF) |
| `<leader>zh` | Find help tags (FZF) |
| `<leader>zk` | Find keymaps (FZF) |
| `<leader>zb` | Find FZF builtins (FZF) |
| `<leader>zw` | Find current word (FZF) |
| `<leader>zW` | Find current WORD (FZF) |
| `<leader>zd` | Find diagnostics (FZF) |
| `<leader>zr` | Resume last FZF search (FZF) |
| `<leader>zo` | Find old/recent files (FZF) |
| `<leader>z<space>` | Find buffers (FZF) |
| `<leader>z/` | Live grep current buffer (FZF) |

### 🔧 Mini.nvim Commands

| Key | Description |
|-----|-------------|
| `<leader>me` | Mini file explorer |
| `<leader>mp` | Mini pick files |
| `<leader>mg` | Mini grep live |
| `<leader>mb` | Mini delete buffer |
| `<leader>mB` | Mini force delete buffer |

### 🎛️ Toggles & Options (Snacks.nvim)

| Key | Description |
|-----|-------------|
| `<leader>us` | Toggle spell checking |
| `<leader>uw` | Toggle line wrapping |
| `<leader>uL` | Toggle relative numbers |
| `<leader>ud` | Toggle diagnostics |
| `<leader>ul` | Toggle line numbers |
| `<leader>uc` | Toggle conceal level |
| `<leader>uT` | Toggle treesitter highlighting |
| `<leader>ub` | Toggle light/dark background |
| `<leader>uh` | Toggle inlay hints |
| `<leader>ug` | Toggle indent guides |
| `<leader>uD` | Toggle dim mode |
| `<leader>un` | Dismiss notifications |

### 🧠 Completion (Blink.cmp)

Blink.cmp provides intelligent code completion with the following keybindings:

| Key | Description |
|-----|-------------|
| `<C-Space>` | Open menu or docs |
| `<C-n>/<C-p>` | Select next/previous item |
| `<C-y>` | Accept completion (default preset) |
| `<C-Z>` | Alternative accept completion |
| `<C-e>` | Hide menu |
| `<C-k>` | Toggle signature help |

### 📑 Special Features

| Key | Description |
|-----|-------------|
| `<leader>.` | Toggle scratch buffer (Snacks) |
| `<leader>S` | Select scratch buffer (Snacks) |
| `<leader>N` | View Neovim news (Snacks) |
| `<leader>n` | Notification history (Snacks) |
| `<leader>cR` | Rename file (Snacks) |
| `]]` | Next word reference (Snacks) |
| `[[` | Previous word reference (Snacks) |
| `]t` | Next TODO comment |
| `[t` | Previous TODO comment |

## 🔌 Plugin List

Your configuration includes these major plugins:

1. **Core Experience**
   - Snacks.nvim - Core functionality and UI enhancements
   - Which-key.nvim - Command discovery
   - Neovim LSP - Code intelligence

2. **File Navigation**
   - Oil.nvim - File manager in buffer
   - Mini.files - Minimalist file explorer
   - FZF-lua - Fuzzy finder

3. **Completion & Snippets**
   - Blink.cmp - Modern completion engine
   - Friendly-snippets - Collection of useful snippets

4. **Git Integration**
   - Neogit - Git interface
   - Diffview.nvim - Visual diff viewer

5. **Terminal & UI**
   - Toggleterm.nvim - Terminal management
   - Zen-mode.nvim - Distraction-free coding
   - Mini.statusline - Streamlined status line

6. **Code Enhancement**
   - Treesitter - Enhanced syntax highlighting
   - Comment.nvim - Smart commenting
   - Todo-comments.nvim - Highlight TODOs
   - Conform.nvim - Code formatting

7. **Session Management**
   - Neovim-session-manager - Project session handling

## 🛠️ Custom Configuration

### Editor Settings

Your Neovim is configured with:

- 4-space indentation (expandtab)
- Relative line numbering
- System clipboard integration
- Persistent undo history
- Visible whitespace characters
- Smart search (case-sensitive when using uppercase)
- Customized UI with signcolumn and cursorline

### LSP Setup

The configuration includes:

- Automatic LSP server installation via Mason
- Diagnostics with inline hints
- Document highlighting
- Signature help
- Format on save with Conform.nvim

### Completion

Blink.cmp is configured with:

- LSP, path, snippets, buffer, emoji, and SQL sources
- Documentation auto-show
- Signature help
- Rust-based fuzzy matching for performance