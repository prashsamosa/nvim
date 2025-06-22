# 🚀 Modern Neovim Configuration



![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)


*A comprehensive, modern, and blazingly fast Neovim configuration*

[Installation](#-installation) • [Keybindings](#-keybindings) • [Plugins](#-plugins) • [Troubleshooting](#-troubleshooting)


## 📋 Prerequisites

### Essential Requirements

| Tool | Version | Purpose |
|------|---------|---------|
| **Neovim** | ≥ 0.10.0 | Core editor |
| **Git** | Latest | Version control & plugin management |
| **Nerd Font** | Latest | Icons & glyphs (recommended: JetBrains Mono) |

### CLI Tools

```bash
# Ubuntu/Debian
sudo apt install ripgrep fd-find
```

### Language-Specific Tools

<details>
<summary><strong>🐹 Go Development</strong></summary>

```bash
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```
</details>

<details>
<summary><strong>🐍 Python</strong></summary>

```bash
pip install debugpy pylatexenc
```
</details>

### Optional Enhancements

- **stylua**: Lua formatter
- **lazygit**: Terminal UI for Git
- **rust**: Enhanced fzf-lua performance

## 🚀 Installation

### Quick Start

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone <your-repo-url> ~/.config/nvim

# Launch Neovim
nvim
```

### First Launch

The configuration will automatically:
1. Bootstrap Lazy.nvim plugin manager
2. Install all configured plugins
3. Set up LSP servers via Mason
4. Compile Treesitter parsers

### Verification

Run `:checkhealth` in Neovim to verify all components are working correctly.

### Manual Setup (if needed)

```vim
:TSUpdate              " Update Treesitter parsers
:MasonInstallAll       " Install Mason-managed tools
:GoInstallBinaries     " Install Go binaries (if applicable)
```

## ⌨️ Keybindings

> **Leader Key**: `<Space>`

### 🔑 Essential Shortcuts

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `jk` | Insert | Exit Insert Mode | Quick escape |
| `<leader>nh` | Normal | Clear Search | Remove highlighting |
| `<C-a>` | Normal | Select All | Select entire buffer |
| `<leader>L` | Normal | Lazy Manager | Open plugin manager |

### 🧭 Navigation & Search

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>ff` | Normal | Find Files | Fuzzy file finder |
| `<leader>fg` | Normal | Live Grep | Search in files |
| `<leader>fb` | Normal | Find Buffers | Switch between buffers |
| `<leader>fo` | Normal | Recent Files | Open recent files |
| `<leader>fc` | Normal | Config Files | Search config directory |
| `<leader>fw` | Normal | Find Word | Search word under cursor |
| `<leader>fh` | Normal | Help Tags | Search help documentation |
| `<leader>fk` | Normal | Keymaps | Search keybindings |
| `<leader>fr` | Normal | Resume Search | Resume last search |

### 📂 File Management

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>e` | Normal | File Explorer | Toggle NvimTree |
| `-` | Normal | Oil Explorer | Buffer-based file manager |

### 🗂️ Buffer Management

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<A-,>` / `<A-.>` | Normal | Buffer Navigation | Previous/Next buffer |
| `<A-1>` to `<A-9>` | Normal | Buffer Jump | Jump to buffer 1-9 |
| `<leader>bc` | Normal | Close Buffer | Close current buffer |
| `<leader>bo` | Normal | Close Others | Close other buffers |
| `<leader>bd` | Normal | Delete Buffer | Smart buffer deletion |

### 🪟 Window Management

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-h/j/k/l>` | Normal | Navigate Windows | Move between windows |
| `sh` / `sv` | Normal | Split Window | Horizontal/Vertical split |
| `<leader>z` | Normal | Zen Mode | Distraction-free mode |
| `<leader>Z` | Normal | Zoom Window | Maximize current window |

### ⚙️ LSP & Code Actions

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `gd` | Normal | Go to Definition | Jump to definition |
| `gD` | Normal | Go to Declaration | Jump to declaration |
| `gr` | Normal | References | Find references |
| `gI` | Normal | Implementation | Go to implementation |
| `K` | Normal | Hover Info | Show documentation |
| `<leader>ca` | Normal/Visual | Code Actions | Available code actions |
| `<leader>cr` | Normal | Rename | Rename symbol |
| `<leader>ds` | Normal | Document Symbols | List document symbols |
| `<leader>ws` | Normal | Workspace Symbols | Search workspace symbols |
| `[d` / `]d` | Normal | Navigate Diagnostics | Previous/Next diagnostic |

### 🐛 Debugging

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>Dc` | Normal | Start/Continue | Start or continue debugging |
| `<leader>Db` | Normal | Toggle Breakpoint | Set/remove breakpoint |
| `<leader>DB` | Normal | Conditional Breakpoint | Set conditional breakpoint |
| `<leader>Dsi` | Normal | Step Into | Step into function |
| `<leader>DsO` | Normal | Step Over | Step over line |
| `<leader>Dso` | Normal | Step Out | Step out of function |
| `<leader>Dt` | Normal | Toggle UI | Show/hide debug UI |

### 📚 Git Operations

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>gn` | Normal | Neogit | Open Git interface |
| `<leader>gg` | Normal | Lazygit | Open Lazygit |

### 💻 Terminal

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-\>` | Normal | Toggle Terminal | Quick terminal access |
| `<leader>tt` | Normal | Floating Terminal | Floating terminal window |
| `<leader>th` | Normal | Horizontal Terminal | Horizontal split terminal |
| `<leader>tv` | Normal | Vertical Terminal | Vertical split terminal |

### 🐹 Go Development

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>ga` | Normal | Alternate File | Switch between test/implementation |
| `<leader>gx` | Normal | Run File | Execute current Go file |
| `<leader>bb` / `<leader>br` | Normal | Build/Run | Build or run package |
| `<leader>tp` / `<leader>tf` | Normal | Test Package/File | Run tests |
| `<leader>tc` | Normal | Test Coverage | Show test coverage |
| `<leader>oi` | Normal | Organize Imports | Format imports |
| `<leader>gs` | Normal | Fill Struct | Auto-fill struct fields |

## 🔌 Plugin Architecture

### Core Components

- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP/DAP/Linter installer
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configurations
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting

### UI & Theme

- **[github-nvim-theme](https://github.com/projekt0n/github-nvim-theme)** - GitHub-inspired theme
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Statusline
- **[barbar.nvim](https://github.com/romgrk/barbar.nvim)** - Buffer tabs
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keybinding hints

### Navigation & Search

- **[fzf-lua](https://github.com/ibhagwan/fzf-lua)** - Fuzzy finder
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer
- **[oil.nvim](https://github.com/stevearc/oil.nvim)** - Buffer-based file editing

### Development Tools

- **[blink.cmp](https://github.com/saghen/blink.cmp)** - Autocompletion
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)** - Debug Adapter Protocol
- **[conform.nvim](https://github.com/stevearc/conform.nvim)** - Code formatting
- **[go.nvim](https://github.com/ray-x/go.nvim)** - Go development tools

### Git Integration

- **[neogit](https://github.com/NeogitOrg/neogit)** - Git interface
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations

### Utilities

- **[mini.nvim](https://github.com/echasnovski/mini.nvim)** - Collection of small plugins
- **[snacks.nvim](https://github.com/folke/snacks.nvim)** - Useful utilities
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal management

## 🛠️ Customization

### Adding New Plugins

1. Create a new file in `lua/plugins/`
2. Define your plugin specification:

```lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
}
```

### Modifying Keybindings

Edit the relevant configuration file in `lua/plugins/` or add custom mappings to `lua/config/keymaps.lua`.

### Theme Customization

Modify `lua/plugins/colorscheme.lua` to change themes or customize colors.

## 🔧 Troubleshooting

### Common Issues

<details>
<summary><strong>Icons not displaying correctly</strong></summary>

- Install a Nerd Font and configure your terminal to use it
- Verify font installation: `fc-list | grep -i nerd`
</details>

<details>
<summary><strong>LSP not working for a language</strong></summary>

1. Check if the language server is installed: `:Mason`
2. Verify LSP is attached: `:LspInfo`
3. Check for errors: `:checkhealth lsp`
</details>

<details>
<summary><strong>Plugins not loading</strong></summary>

1. Check Lazy status: `:Lazy`
2. Sync plugins: `:Lazy sync`
3. Check for errors: `:Lazy log`
</details>

<details>
<summary><strong>Slow startup</strong></summary>

1. Profile startup time: `nvim --startuptime startup.log`
2. Check plugin loading: `:Lazy profile`
3. Consider lazy-loading more plugins
</details>

### Getting Help

- Run `:checkhealth` for comprehensive system diagnostics
- Use `:help <topic>` for built-in documentation
- Check plugin documentation for specific issues
---
