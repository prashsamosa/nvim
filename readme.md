# 🚀 Modern Neovim Configuration

A powerful, feature-rich Neovim setup with elegant UI, intelligent code completion, and a VS Code-like experience.

## ✨ Features

- 🎨 Beautiful UI with GitHub Dark theme and transparent elements
- 🧠 Advanced code completion with Blink.cmp
- 🌲 Rich syntax highlighting with Treesitter
- 📂 Multiple file explorers (Oil.nvim, Mini.files, Snacks Explorer)
- 🔎 Fuzzy finding with FZF-lua
- 🤖 Full LSP integration
- 📝 VS Code-compatible keybindings
- 📔 Session management
- 🧰 Git integration with Neogit

## 🔑 Keybinding Reference

### 🌟 Navigation & Basics

| Key | Mode | Description |
|-----|------|-------------|
| `Space` | All | Leader key |
| `jk` | Insert | Exit insert mode |
| `<C-h/j/k/l>` | Normal | Navigate splits |
| `<leader>[` | Normal | Previous buffer |
| `<leader>]` | Normal | Next buffer |
| `<S-h>` | Normal | Previous buffer (alternative) |
| `<S-l>` | Normal | Next buffer (alternative) |
| `<C-s>` | Normal, Insert | Save file |
| `<C-c>` | Insert | Alternative ESC |
| `<leader>nh` | Normal | Clear search highlights |

### 📂 File Navigation

#### Snacks.nvim
| Key | Description |
|-----|-------------|
| `<leader><space>` | Smart file finder |
| `<leader>ff` | Find files |
| `<leader>fg` | Find git files |
| `<leader>fr` | Recent files |
| `<leader>fc` | Find config files |
| `<leader>fp` | Browse projects |

#### FZF-lua
| Key | Description |
|-----|-------------|
| `<leader>zf` | Find files |
| `<leader>zg` | Live grep |
| `<leader>zc` | Find in config files |
| `<leader>zh` | Browse help tags |
| `<leader>zo` | Browse old files |
| `<leader>zk` | List keymaps |
| `<leader>zw` | Find current word |
| `<leader>zW` | Find current WORD |

#### File Explorers
| Key | Description |
|-----|-------------|
| `<leader>e` | Snacks file explorer |
| `<leader>me` | Mini file explorer |
| `-` | Oil file manager |

### 🔍 Search & Find

| Key | Description |
|-----|-------------|
| `<leader>/` | Grep (Snacks) |
| `<leader>sg` | Search in files |
| `<leader>ss` | Search in buffer |
| `<leader>sw` | Search for word under cursor |
| `<leader>sB` | Search in open buffers |
| `<leader>z/` | FZF search in current buffer |
| `<leader>zg` | FZF live grep |

### 📊 LSP Features

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

### 📝 Editing

| Key | Description |
|-----|-------------|
| `<leader>c/` | Toggle comment line |
| `gc` | Comment with mini.comment |
| `gcc` | Comment current line |
| `<S-j>` | Move line down (Visual) |
| `<S-k>` | Move line up (Visual) |
| `<leader>+` | Increment number |
| `<leader>=` | Decrement number |

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

### 📑 Tab Management

| Key | Description |
|-----|-------------|
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `<leader>tf` | Open buffer in new tab |

### 📚 Git Integration

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

### 🔍 Mini.nvim Commands

| Key | Description |
|-----|-------------|
| `<leader>me` | Mini file explorer |
| `<leader>mp` | Mini pick files |
| `<leader>mg` | Mini grep live |
| `<leader>mb` | Mini delete buffer |
| `<leader>mB` | Mini force delete buffer |

### 🌲 Treesitter Text Objects

| Key | Description |
|-----|-------------|
| `af` | Around function |
| `if` | Inner function |
| `ac` | Around class |
| `ic` | Inner class |
| `ao` | Around comment |
| `as` | Around scope |
| `<leader>a` | Swap next parameter |
| `<leader>A` | Swap previous parameter |
| `<C-space>` | Incremental selection |
| `<bs>` | Shrink selection |

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

## 🔌 Plugin List

This configuration includes these major plugins:

1. **Core & UI**
   - Snacks.nvim - Core UI and functionality
   - GitHub Theme - Visual theme
   - Mini.nvim - Various utilities
   - Which-key.nvim - Command discovery

2. **File Management**
   - Oil.nvim - Buffer-based file manager
   - Mini.files - Minimalist file explorer
   - FZF-lua - Fuzzy finder

3. **Coding**
   - Blink.cmp - Modern completion engine
   - Treesitter - Advanced syntax highlighting
   - Comment.nvim - Smart commenting
   - Mini.comment - Alternative commenting

4. **Git Integration**
   - Neogit - Git interface
   - Diffview.nvim - Visual diff viewer

5. **LSP & Formatting**
   - LSP Configuration - Code intelligence
   - Conform.nvim - Code formatting
   - Mason.nvim - LSP/DAP/Linter manager

6. **Terminal & Focus**
   - Toggleterm.nvim - Terminal management
   - Zen Mode - Distraction-free coding

## 🎨 Colorscheme

The configuration uses GitHub Dark theme with custom notification styling and transparent backgrounds for a modern look.

## 🛠️ Additional Features

- Multi-file explorer options (Oil.nvim, Mini.files, Snacks Explorer)
- Advanced LSP integration with inline diagnostics
- Todo comments with special highlighting
- Multiple terminal options
- Session management with Mini.sessions
- Custom notifications with Mini.notify

## 💡 Customization

You can extend this configuration by:

1. Adding plugins to `lua/plugins/`
2. Modifying keybindings in `lua/config/keymaps.lua`
3. Changing editor options in `lua/config/options.lua`
4. Adjusting theme settings in `lua/plugins/github-theme.lua`