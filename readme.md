# 🚀 My Neovim Configuration

> A modern, feature-rich Neovim setup optimized for productivity and performance

[![Neovim](https://img.shields.io/badge/Neovim-0.10+-green.svg)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-blue.svg)](https://lua.org/)

## ✨ Key Features

- 🔍 **Intelligent Completion**: Swift and accurate code completion powered by Blink.cmp
- 🌲 **Advanced Syntax**: Rich syntax highlighting, precise text objects, and intuitive incremental selection through Treesitter
- 📄 **Enhanced Markdown**: Superior Markdown viewing with `render-markdown.nvim`, featuring concealed syntax elements, informative icons, clean borders, and more
- 📂 **Flexible File Management**: Multiple file exploration options including a floating Oil.nvim, a sidebar Neo-tree, the focused Mini.files, and the versatile Snacks Explorer
- 🔎 **Efficient Fuzzy Finding**: Powerful and rapid searching capabilities with FZF-lua and the integrated Snacks pickers
- 🤖 **Robust LSP Integration**: Comprehensive Language Server Protocol support facilitated by Mason for effortless server management, enhanced with real-time status updates from Fidget
- 📝 **Familiar VS Code Keybindings**: A comfortable and efficient workflow leveraging familiar VS Code-style keyboard shortcuts
- 🎨 **Beautiful User Interface**: An aesthetically pleasing GitHub Dark theme complemented by Snacks UI elements and an informative dashboard
- 🧰 **Seamless Git Integration**: Streamlined Git operations with Neogit, enhanced diff viewing with Diffview, and convenient Git pickers from Snacks
- ⚡ **Optimized Performance**: Improved startup and responsiveness achieved through lazy loading of most plugins via lazy.nvim
- 📑 **Enhanced Buffer Management**: Feature-rich and intuitive buffer handling with `barbar.nvim`

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
| `<leader>me`      | `n`  | Toggle Mini File Explorer      |
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
| `gc`        | `n,v` | Toggle Comment              |
| `gcc`       | `n`   | Comment Line                |
| `<S-j>`     | `v`   | Move Lines Down             |
| `<S-k>`     | `v`   | Move Lines Up               |
| `<leader>+` | `n`   | Increment Number            |
| `<leader>=` | `n`   | Decrement Number            |

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
| `<leader>bc`    | `n`  | Close Current Buffer                 |
| `<leader>bo`    | `n`  | Close All But Current/Pinned Buffers |

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
| `<leader>gs` | `n`  | Alternate Horizontal Split | File      |
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
- **Plugin-specific**: Modify the respective plugin file in `lua/plugins/`

### Adjusting Settings
- **Editor options**: Modify `lua/config/options.lua`
- **Theme settings**: Edit `lua/plugins/github-theme.lua`

### LSP Configuration
Add or remove Language Servers in the `servers` table in `lua/plugins/lsp.lua`:
```lua
local servers = {
  "lua_ls",
  "gopls",
  "pyright",
  -- Add your preferred servers here
}
```

### Formatters & Linters
Configure in `lua/plugins/conform.lua` and ensure they're listed in the `ensure_installed` table in `lua/plugins/lsp.lua`.

## 🐛 Troubleshooting

### Common Issues

**Plugin installation fails**
```bash
# Clear lazy.nvim cache and reinstall
rm -rf ~/.local/share/nvim/lazy
nvim --headless "+Lazy! sync" +qa
```

**LSP servers not working**
```vim
" Check Mason installation status
:Mason
" Update Treesitter parsers
:TSUpdate
```

**Slow startup time**
```vim
" Profile startup time
:Lazy profile
```

**Missing icons**
- Ensure you have a Nerd Font installed and configured in your terminal
- Popular choices: `JetBrainsMono Nerd Font`, `FiraCode Nerd Font`

### Getting Help
- Check `:checkhealth` for configuration issues
- Review plugin documentation for specific features
- Open an issue in this repository for configuration-related problems

## 📄 License

This configuration is released under the MIT License. See [LICENSE](LICENSE) for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 🙏 Acknowledgments

This configuration is built upon the excellent work of the Neovim community and the authors of the included plugins. Special thanks to:

- The Neovim core team
- Plugin authors and maintainers
- The Lua ecosystem contributors

---

<div align="center">

**[⬆ Back to Top](#-my-neovim-configuration)**

Made with ❤️ for the Neovim community

</div>
