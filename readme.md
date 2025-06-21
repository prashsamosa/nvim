# 🚀 My Neovim Configuration

[![Neovim](https://img.shields.io/badge/Neovim-0.10+-green.svg)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-blue.svg)](https://lua.org/)

## 📋 Prerequisites

Before installing this configuration, ensure you have the following dependencies:

### Required
- **Neovim** 0.9+ (0.10+ strongly recommended)
- **Git** - Version control system
- **Node.js** - Runtime environment for Language Servers and formatters
- **Nerd Font** - For consistent icons across UI elements

### Recommended Tools
- **ripgrep** (`rg`) - Fast recursive search tool for live grep functionality
- **fd** - Simple, fast alternative to `find` for file searching
- **stylua** - Lua code formatter (auto-installed via Mason)

### Optional Dependencies
- **Rust** - For potentially faster fuzzy matching within Blink.cmp
- **pylatexenc** - Python package for LaTeX rendering in Markdown
  ```bash
  pip install pylatexenc
  ```

## 🚀 Quick Start

### 1. Backup Existing Configuration (Optional)
```bash
# Create backups of existing Neovim configuration
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 2. Clone Repository
```bash
git clone <your-repo-url> ~/.config/nvim
```

### 3. Launch Neovim
```bash
nvim
```

On first startup, lazy.nvim will automatically download and install all plugins. Run `:TSUpdate` to ensure Treesitter parsers are up-to-date.

## ⌨️ Key Bindings

**Leader Key:** `<Space>`

<details>
<summary><strong>🌟 General & Navigation</strong></summary>

| Key          | Mode  | Description                       |
|:-------------|:------|:----------------------------------|
| `jk`         | `i`   | Exit Insert Mode                  |
| `<leader>nh` | `n`   | Clear Search Highlights           |
| `<C-h>`      | `n`   | Navigate Window Left              |
| `<C-j>`      | `n`   | Navigate Window Down              |
| `<C-k>`      | `n`   | Navigate Window Up                |
| `<C-l>`      | `n`   | Navigate Window Right             |
| `<C-c>`      | `i`   | Alternative Escape                |
| `<C-s>`      | `n,i` | Quick Save                        |
| `]]`         | `n,t` | Next Reference (Snacks Words)     |
| `[[`         | `n,t` | Previous Reference (Snacks Words) |
| `]t`         | `n`   | Next TODO Comment                 |
| `[t`         | `n`   | Previous TODO Comment             |

</details>

<details>
<summary><strong>📂 File & Project Management</strong></summary>

| Key               | Mode | Description                    |
|:------------------|:-----|:-------------------------------|
| `<leader><space>` | `n`  | Smart Find Files (Snacks)      |
| `<leader>e`       | `n`  | File Explorer (Snacks)         |
| `<leader>ff`      | `n`  | Find Files (FZF)               |
| `<leader>fg`      | `n`  | Find Git Files (Snacks)        |
| `<leader>fr`      | `n`  | Recent Files (Snacks)          |
| `<leader>fR`      | `n`  | Resume Last Search (FZF)       |
| `<leader>fc`      | `n`  | Find Configuration File (FZF)  |
| `<leader>fp`      | `n`  | Browse Projects (Snacks)       |
| `<leader>fo`      | `n`  | Old Files (FZF)                |
| `<leader>me`      | `n`  | Mini Files (current file)      |
| `<leader>mE`      | `n`  | Mini Files (cwd)               |
| `<leader>mp`      | `n`  | Mini Pick Files                |
| `-`               | `n`  | Open Oil File Manager          |
| `<leader>cR`      | `n`  | Rename File (Snacks)           |

</details>

<details>
<summary><strong>🔍 Search & Grep</strong></summary>

| Key          | Mode  | Description                       |
|:-------------|:------|:----------------------------------|
| `<leader>sg` | `n`   | Search in Files (Snacks Grep)     |
| `<leader>sb` | `n`   | Search in Buffer (Snacks Lines)   |
| `<leader>sw` | `n,x` | Search Word Under Cursor (Snacks) |
| `<leader>sB` | `n`   | Grep Open Buffers (Snacks)        |
| `<leader>fl` | `n`   | Live Grep (FZF)                   |
| `<leader>fw` | `n`   | Find Current Word (FZF)           |
| `<leader>fW` | `n`   | Find Current WORD (FZF)           |
| `<leader>f/` | `n`   | Live Grep Current Buffer (FZF)    |
| `<leader>mg` | `n`   | Mini Grep Live                    |
| `<leader>mG` | `n`   | Mini Grep Current Word            |

</details>

<details>
<summary><strong>📊 LSP (Language Server Protocol)</strong></summary>

| Key          | Mode  | Description                |
|:-------------|:------|:---------------------------|
| `gd`         | `n`   | Go to Definition           |
| `gD`         | `n`   | Go to Declaration          |
| `gr`         | `n`   | Go to References           |
| `gI`         | `n`   | Go to Implementation       |
| `<leader>D`  | `n`   | Type Definition            |
| `<leader>ca` | `n,x` | Code Action                |
| `<leader>cr` | `n`   | Rename Symbol              |
| `<leader>ds` | `n`   | Document Symbols           |
| `<leader>ws` | `n`   | Workspace Symbols          |
| `<S-k>`      | `n`   | Show Hover Information     |
| `<leader>ih` | `n`   | Toggle Inlay Hints         |
| `<leader>fd` | `n`   | Diagnostics (FZF)          |

</details>

<details>
<summary><strong>📝 Editing & Text Manipulation</strong></summary>

| Key         | Mode  | Description                 |
|:------------|:------|:----------------------------|
| `gc`        | `n,v` | Toggle Comment (Mini)       |
| `gcc`       | `n`   | Comment Line (Mini)         |
| `<S-j>`     | `v`   | Move Lines Down             |
| `<S-k>`     | `v`   | Move Lines Up               |
| `<leader>+` | `n`   | Increment Number            |
| `<leader>=` | `n`   | Decrement Number            |

**Mini.nvim Text Objects & Editing:**
| Key     | Mode  | Description                          |
|:--------|:------|:-------------------------------------|
| `sa`    | `n,v` | Add Surrounding (Mini Surround)      |
| `sd`    | `n`   | Delete Surrounding (Mini Surround)   |
| `sf`    | `n`   | Find Surrounding (Mini Surround)     |
| `sh`    | `n`   | Highlight Surrounding (Mini Surround)|
| `sn`    | `n`   | Update Next Surrounding (Mini)       |
| `sl`    | `n`   | Update Last Surrounding (Mini)       |
| `sr`    | `n`   | Replace Surrounding (Mini Surround)  |
| `ii`    | `n,v` | Inner Indentation Scope (Mini)       |
| `ai`    | `n,v` | Around Indentation Scope (Mini)      |
| `[i`    | `n`   | Go to Top of Indent Scope (Mini)     |
| `]i`    | `n`   | Go to Bottom of Indent Scope (Mini)  |

</details>

<details>
<summary><strong>📑 Buffer Management</strong></summary>

| Key             | Mode | Description                          |
|:----------------|:-----|:-------------------------------------|
| `<A-,>`         | `n`  | Go to Previous Buffer                |
| `<A-.>`         | `n`  | Go to Next Buffer                    |
| `<A-S-,>`       | `n`  | Move Current Buffer to Previous      |
| `<A-S-.>`       | `n`  | Move Current Buffer to Next          |
| `<A-1>`–`<A-9>` | `n`  | Go to Buffer 1–9                     |
| `<A-0>`         | `n`  | Go to Last Buffer                    |
| `<A-p>`         | `n`  | Pin/Unpin Current Buffer             |
| `<leader>bd`    | `n`  | Delete Current Buffer                |
| `<leader>bD`    | `n`  | Force Delete Current Buffer          |
| `<leader>bo`    | `n`  | Close All But Current/Pinned Buffers |
| `<leader>mb`    | `n`  | Delete Buffer (Mini Bufremove)       |
| `<leader>mB`    | `n`  | Force Delete Buffer (Mini Bufremove) |

</details>

<details>
<summary><strong>🪟 Window Management</strong></summary>

| Key          | Mode | Description           |
|:-------------|:-----|:----------------------|
| `sh`         | `n`  | Split Horizontally    |
| `sv`         | `n`  | Split Vertically      |
| `<leader>se` | `n`  | Equalize Window Sizes |
| `<leader>sx` | `n`  | Close Current Split   |
| `<C-Up>`     | `n`  | Resize Split Up       |
| `<C-Down>`   | `n`  | Resize Split Down     |
| `<C-Left>`   | `n`  | Resize Split Left     |
| `<C-Right>`  | `n`  | Resize Split Right    |

</details>

<details>
<summary><strong>📚 Git Operations</strong></summary>

| Key          | Mode  | Description             |
|:-------------|:------|:------------------------|
| `<leader>gs` | `n`   | Git Status (Snacks)     |
| `<leader>gb` | `n`   | Git Branches (Snacks)   |
| `<leader>gl` | `n`   | Git Log (Snacks)        |
| `<leader>gL` | `n`   | Git Log Line (Snacks)   |
| `<leader>gd` | `n`   | Git Diff Hunks (Snacks) |
| `<leader>gf` | `n`   | Git Log File (Snacks)   |
| `<leader>gS` | `n`   | Git Stash (Snacks)      |
| `<leader>gB` | `n,v` | Git Browse (Snacks)     |
| `<leader>gg` | `n`   | Open Lazygit (Snacks)   |
| `<leader>gn` | `n`   | Open Neogit             |

</details>

<details>
<summary><strong>📦 Mini.nvim Operations</strong></summary>

**File Management:**
| Key          | Mode | Description                 |
|:-------------|:-----|:----------------------------|
| `<leader>me` | `n`  | Mini Files (File Explorer)  |

**Fuzzy Finding & Search:**
| Key          | Mode | Description                 |
|:-------------|:-----|:----------------------------|
| `<leader>mp` | `n`  | Mini Pick Files             |
| `<leader>mg` | `n`  | Mini Grep Live              |

**Buffer Operations:**
| Key          | Mode | Description                 |
|:-------------|:-----|:----------------------------|
| `<leader>mb` | `n`  | Delete Buffer (Mini)        |
| `<leader>mB` | `n`  | Force Delete Buffer (Mini)  |

**Session Management:**
| Key          | Mode | Description                 |
|:-------------|:-----|:----------------------------|
| `<leader>ms` | `n`  | Write Session               |
| `<leader>mr` | `n`  | Read Last Session          |
| `<leader>md` | `n`  | Delete Session              |

**Navigation & Brackets:**
| Key    | Mode | Description                          |
|:-------|:-----|:-------------------------------------|
| `[b`   | `n`  | Previous Buffer (Mini Bracketed)     |
| `]b`   | `n`  | Next Buffer (Mini Bracketed)         |
| `[c`   | `n`  | Previous Comment (Mini Bracketed)    |
| `]c`   | `n`  | Next Comment (Mini Bracketed)        |
| `[d`   | `n`  | Previous Diagnostic (Mini Bracketed) |
| `]d`   | `n`  | Next Diagnostic (Mini Bracketed)     |
| `[f`   | `n`  | Previous File (Mini Bracketed)       |
| `]f`   | `n`  | Next File (Mini Bracketed)           |
| `[i`   | `n`  | Previous Indent (Mini Bracketed)     |
| `]i`   | `n`  | Next Indent (Mini Bracketed)         |
| `[j`   | `n`  | Previous Jump (Mini Bracketed)       |
| `]j`   | `n`  | Next Jump (Mini Bracketed)           |
| `[l`   | `n`  | Previous Location (Mini Bracketed)   |
| `]l`   | `n`  | Next Location (Mini Bracketed)       |
| `[o`   | `n`  | Previous Oldfile (Mini Bracketed)    |
| `]o`   | `n`  | Next Oldfile (Mini Bracketed)        |
| `[q`   | `n`  | Previous Quickfix (Mini Bracketed)   |
| `]q`   | `n`  | Next Quickfix (Mini Bracketed)       |
| `[t`   | `n`  | Previous Treesitter (Mini Bracketed) |
| `]t`   | `n`  | Next Treesitter (Mini Bracketed)     |
| `[u`   | `n`  | Previous Undo (Mini Bracketed)       |
| `]u`   | `n`  | Next Undo (Mini Bracketed)           |
| `[w`   | `n`  | Previous Window (Mini Bracketed)     |
| `]w`   | `n`  | Next Window (Mini Bracketed)         |
| `[y`   | `n`  | Previous Yank (Mini Bracketed)       |
| `]y`   | `n`  | Next Yank (Mini Bracketed)           |

</details>

<details>
<summary><strong>💻 Terminal</strong></summary>

| Key          | Mode | Description                        |
|:-------------|:-----|:-----------------------------------|
| `<C-\>`      | `n`  | Toggle Terminal (ToggleTerm)       |
| `<leader>tt` | `n`  | Toggle Terminal (Floating)         |
| `<leader>th` | `n`  | Toggle Terminal (Horizontal Split) |
| `<leader>tv` | `n`  | Toggle Terminal (Vertical Split)   |
| `<leader>tl` | `n`  | Send Line to Terminal              |
| `<leader>ts` | `n`  | Select Terminal                    |

</details>

<details>
<summary><strong>🔧 UI Toggles & Settings</strong></summary>

| Key          | Mode | Description                 |
|:-------------|:-----|:----------------------------|
| `<leader>us` | `n`  | Toggle Spelling             |
| `<leader>uw` | `n`  | Toggle Wrap                 |
| `<leader>uL` | `n`  | Toggle Relative Number      |
| `<leader>ud` | `n`  | Toggle Diagnostics          |
| `<leader>ul` | `n`  | Toggle Line Number          |
| `<leader>uc` | `n`  | Toggle Conceal Level        |
| `<leader>uT` | `n`  | Toggle Treesitter           |
| `<leader>ub` | `n`  | Toggle Dark Background      |
| `<leader>uh` | `n`  | Toggle Inlay Hints          |
| `<leader>uD` | `n`  | Toggle Dim Mode             |
| `<leader>un` | `n`  | Dismiss Notifications       |

</details>

<details>
<summary><strong>🐹 Go Development</strong></summary>

| Key          | Mode | Description                | Category  |
|:-------------|:-----|:---------------------------|:----------|
| `<leader>ga` | `n`  | Alternate File             | File      |
| `<leader>gv` | `n`  | Alternate Vertical Split   | File      |
| `<leader>gx` | `n`  | Alternate Horizontal Split | File      |
| `<leader>oi` | `n`  | Go Imports (Organize)      | Format    |
| `<leader>of` | `n`  | Go Format                  | Format    |
| `<leader>ot` | `n`  | Go Mod Tidy                | Format    |
| `<leader>bb` | `n`  | Build Package              | Build     |
| `<leader>br` | `n`  | Run Package                | Build     |
| `<leader>tp` | `n`  | Test Package               | Test      |
| `<leader>tf` | `n`  | Test Function (Nearest)    | Test      |
| `<leader>tF` | `n`  | Test File                  | Test      |
| `<leader>tc` | `n`  | Test Coverage (Package)    | Test      |
| `<leader>tC` | `n`  | Toggle Coverage Display    | Test      |

</details>

<details>
<summary><strong>🗄️ Database Operations</strong></summary>

| Key          | Mode | Description       |
|:-------------|:-----|:------------------|
| `<leader>du` | `n`  | Toggle DB UI      |
| `<leader>dr` | `n`  | Find DB Buffer    |
| `<leader>da` | `n`  | Add DB Connection |
| `<leader>dc` | `n`  | Close DB UI       |
| `<leader>do` | `n`  | Open DB UI        |

</details>

## 🔌 Plugin Ecosystem

### Core Framework
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager with lazy loading
- **[Snacks.nvim](https://github.com/folke/snacks.nvim)** - Collection of useful utilities and UI components

### Completion & LSP
- **[blink.cmp](https://github.com/Saghen/blink.cmp)** - Fast and feature-rich completion engine
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - Quickstart configs for Neovim LSP
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - Portable package manager for LSP servers, formatters, and linters
- **[fidget.nvim](https://github.com/j-hui/fidget.nvim)** - Standalone UI for LSP progress

### File Management & Navigation
- **[oil.nvim](https://github.com/stevearc/oil.nvim)** - File explorer that lets you edit your filesystem like a normal buffer
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - Modern file explorer sidebar
- **[mini.files](https://github.com/echasnovski/mini.files)** - Navigate and manipulate file system
- **[fzf-lua](https://github.com/ibhagwan/fzf-lua)** - Improved fzf.vim written in Lua

### Syntax & Editing
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting and text objects
- **[render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)** - Enhanced Markdown rendering
- **[mini.nvim](https://github.com/echasnovski/mini.nvim)** - Collection of minimal, independent modules
  - **mini.comment** - Smart code commenting
  - **mini.ai** - Enhanced text objects
  - **mini.surround** - Surround text objects manipulation
  - **mini.operators** - Additional text operators
  - **mini.pairs** - Auto-completion of bracket pairs
  - **mini.bracketed** - Navigate through various text objects with brackets
  - **mini.bufremove** - Better buffer deletion
  - **mini.files** - File explorer
  - **mini.pick** - Fuzzy finder and picker
  - **mini.notify** - Notification system
  - **mini.sessions** - Session management
  - **mini.indentscope** - Indentation scope visualization

### Git Integration
- **[neogit](https://github.com/NeogitOrg/neogit)** - Magit-like Git interface
- **[diffview.nvim](https://github.com/sindrets/diffview.nvim)** - Single tabpage interface for Git diffs

### UI & Theme
- **[github-nvim-theme](https://github.com/projekt0n/github-nvim-theme)** - GitHub's Neovim theme
- **[barbar.nvim](https://github.com/romgrk/barbar.nvim)** - Tabline plugin with re-orderable, auto-sizing tabs

### Language-Specific
- **[go.nvim](https://github.com/ray-x/go.nvim)** - Modern Go development plugin
- **[vim-dadbod](https://github.com/tpope/vim-dadbod)** - Database interface

## 🎨 Customization Guide

This configuration is designed to be easily customizable. Here's how to modify different aspects:

### Adding New Plugins
Create a new file in `lua/plugins/` directory:
```lua
-- lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
}
```

### Modifying Keybindings
- **Core keybindings**: Edit `lua/config/keymaps.lua`
- **Plugin-specific keybindings**: Edit the respective plugin configuration file in `lua/plugins/`
- **Mini.nvim keybindings**: The mini.nvim modules use mostly default keybindings, which are documented in each module's help

### Mini.nvim Module Configuration
Each mini.nvim module can be customized by modifying its setup function in `lua/plugins/mini.lua`:

```lua
-- Example: Customizing mini.surround
require("mini.surround").setup({
  mappings = {
    add = "sa",            -- Add surrounding in Normal and Visual modes
    delete = "sd",         -- Delete surrounding
    find = "sf",           -- Find surrounding (to the right)
    find_left = "sF",      -- Find surrounding (to the left)
    highlight = "sh",      -- Highlight surrounding
    replace = "sr",        -- Replace surrounding
    update_n_lines = "sn", -- Update `n_lines`
  },
})
```
