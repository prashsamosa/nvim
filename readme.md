# 🚀 Neovim Configuration

![Neovim Version](https://img.shields.io/badge/Neovim-0.10+-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=green)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20Windows-blue.svg?style=flat-square)

## 📋 Prerequisites

### Essential Requirements

| Tool | Version | Purpose |
|:------------|:-----------|:----------------------------------|
| **Neovim** | `≥ 0.10.0` | Core editor |
| **Git** | `Latest` | Version control & plugin management |
| **Nerd Font** | `Latest` | Icons & glyphs (e.g., JetBrains Mono) |

### CLI Tools

```bash
# Ubuntu/Debian
sudo apt install ripgrep fd-find
```

### Language-Specific Tools

Ensure these are installed for optimal language support:

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
pip install debugpy black isort
```

</details>

<details>
<summary><strong>🦀 Rust</strong></summary>

```bash
rustup component add rust-analyzer
rustup component add rustfmt
```

</details>


## 📦 Installation

1. **Backup existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone the repository**:
   ```bash
   git clone https://github.com/prashsamosa/nvim.git ~/.config/nvim
   ```
   *(Replace `your-username/your-nvim-config` with your actual repository path)*

3. **Open Neovim**:
   ```bash
   nvim
   ```

4. **Wait for installation**: lazy.nvim will automatically download and install all plugins. Mason will also install LSP servers and formatters as configured. This might take some time on the first launch.

5. **Run health check**: After installation, run `:checkhealth` to ensure all dependencies are met and your setup is healthy.

## ⌨️ Keybindings

This configuration uses `<Space>` as the leader key (`<leader>`).

### General
| Key | Action |
|-----|--------|
| `<leader>nh` | Clear search highlights |
| `jk` (in Insert mode) | Exit Insert mode (remapped from `<ESC>`) |

### Window Management
| Key | Action |
|-----|--------|
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Navigate between windows |
| `sh` | Horizontal split |
| `sv` | Vertical split |
### File/Buffer Management
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle nvim-tree (File Explorer Sidebar) |
| `-` | Open oil.nvim (Floating File Explorer) |
| `<A-,>`, `<A-.>` | Go to previous/next buffer |
| `<A-S-,>`, `<A-S-.>` | Move buffer previous/next |
| `<A-1>` to `<A-9>`, `<A-0>` | Jump to specific buffer |
| `<A-p>` | Pin/unpin current buffer |
| `<leader>bc` | Close current buffer |
| `<leader>bd` | Delete current buffer |
| `<leader>ba` | Delete all buffers |
| `<leader>bo` | Delete other buffers (Snacks) |
| `<leader>bO` | Close all but current/pinned (Barbar) |
| `<leader>rf` | Rename current file |

### LSP (Language Server Protocol)
| Key | Action |
|-----|--------|
| `<leader>ca` | Code action |
| `<S-k>` | Hover documentation |
| `<leader>cr` | Rename symbol |
| `<leader>cf` | Format current file |
| `<leader>cc` | Organize imports |
| `gd` | Go to definition |
| `gr` | Go to references |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `<leader>sd` | Show document diagnostics |
| `<leader>sw` | Show workspace diagnostics |
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |

### Debugging (nvim-dap)
| Key | Action |
|-----|--------|
| `<leader>Dc` | Start/Continue debugging |
| `<leader>Dsi` | Step Into |
| `<leader>DsO` | Step Over |
| `<leader>Dso` | Step Out |
| `<leader>Db` | Toggle breakpoint |
| `<leader>DR` | Run last debug configuration |
| `<leader>Drs` | Restart debug session |
| `<leader>De` | Evaluate expression (visual mode) |
| `<leader>DL` | Show debug logs |
| `<leader>Dt` | Terminate debug session |

### Fuzzy Finding (fzf-lua)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>f/` | Grep in current buffer |
| `<leader>fo` | Old files |
| `<leader>f<space>` | Buffers |
| `<leader>fgd` | LSP Go to Definition (FZF picker) |
| `<leader>fgr` | LSP Go to References (FZF picker) |

### Git (Neogit)
| Key | Action |
|-----|--------|
| `<leader>gn` | Open Neogit status window |

### Database (vim-dadbod-ui)
| Key | Action |
|-----|--------|
| `<leader>Do` | Open DB UI |
| `<leader>Du` | Toggle DB UI |
| `<leader>DCc` | Close DB UI |

### Terminals (toggleterm.nvim)
| Key | Action |
|-----|--------|
| `<C-\>` | Toggle Floating Terminal |
| `<leader>tt` | Toggle Floating Terminal |
| `<leader>th` | Toggle Horizontal Terminal |
| `<leader>tv` | Toggle Vertical Terminal |
| `<leader>tl` | Send Current Line to Terminal |
| `<leader>ts` | Select Terminal |

### Markdown (render-markdown.nvim)
| Key | Action |
|-----|--------|
| `<leader>Mm` | Toggle Markdown Rendering |

### Snacks Utilities
| Key | Action |
|-----|--------|
| `<leader>us` | Toggle Spelling |
| `<leader>uw` | Toggle Word Wrap |
| `<leader>uL` | Toggle Relative Line Numbers |
| `<leader>ud` | Toggle Diagnostics |
| `<leader>ul` | Toggle Line Numbers |
| `<leader>ut` | Toggle Treesitter Highlights |
| `<leader>ub` | Toggle Dark/Light Background |
| `<leader>uh` | Toggle Inlay Hints |
| `<leader>uz` | Toggle Dim Mode |
| `<leader>z` | Toggle Zen Mode |
| `<leader>Z` | Zoom Current Window |
| `<leader>.` | Scratch Buffer |
| `<leader>S` | Select Scratch Buffer |

### Sessions (mini.sessions)
| Key | Action |
|-----|--------|
| `<leader>ms` | Write Session |
| `<leader>mr` | Read Last Session |
| `<leader>md` | Delete Session |

> **Tip**: Use `<leader>` followed by any key to see available mappings via which-key.nvim

## ⚙️ Plugin Overview

### Core & Utilities
- **folke/lazy.nvim**: Modern plugin manager
- **folke/which-key.nvim**: Displays keybinding hints
- **folke/snacks.nvim**: Collection of useful utilities and toggles
- **akinsho/toggleterm.nvim**: Integrated terminal
- **echasnovski/mini.nvim**: Collection of lightweight plugins
- **tpope/vim-sleuth**: Automatic indentation detection

### User Interface & Aesthetics
- **nvim-lualine/lualine.nvim**: Customizable statusline
- **romgrk/barbar.nvim**: Neovim tabs/bufferline
- **nvim-tree/nvim-web-devicons**: File icons

### File Exploration & Fuzzy Finding
- **nvim-tree/nvim-tree.lua**: Classic sidebar file explorer
- **stevearc/oil.nvim**: Floating file explorer (default)
- **ibhagwan/fzf-lua**: Powerful fuzzy finder

### Language Support
- **neovim/nvim-lspconfig**: LSP server configuration
- **williamboman/mason.nvim**: LSP server, DAP adapter, and formatter manager
- **saghen/blink.cmp**: Fast completion engine
- **stevearc/conform.nvim**: Auto-formatting on save
- **b0o/schemastore.nvim**: JSON/YAML schema validation

### Debugging
- **mfussenegger/nvim-dap**: Debug Adapter Protocol client
- **rcarriga/nvim-dap-ui**: Debugging UI
- **theHamsta/nvim-dap-virtual-text**: Inline variable values during debugging

### Version Control
- **NeogitOrg/neogit**: Git client
- **sindrets/diffview.nvim**: Powerful diff viewer
- **lewis6991/gitsigns.nvim**: Git status in sign column

### Code Analysis & Navigation
- **nvim-treesitter/nvim-treesitter**: Modern syntax highlighting
- **folke/todo-comments.nvim**: Highlights TODO/FIXME comments
- **MeanderingProgrammer/render-markdown.nvim**: Markdown rendering

### Database
- **kristijanhusak/vim-dadbod-ui**: Database UI
- **tpope/vim-dadbod**: Core database plugin

## 🔧 Troubleshooting

### Common Issues

<details>
<summary><strong>Icons not displaying correctly</strong></summary>

1. **Install a Nerd Font**: Download and install a Nerd Font (e.g., JetBrains Mono Nerd Font)
2. **Configure your terminal**: Set your terminal to use the installed Nerd Font
3. **Verify installation**: Run `fc-list | grep -i nerd` to check if fonts are detected

</details>

<details>
<summary><strong>LSP not working / Formatting not working</strong></summary>

1. **Check Language Server**: Run `:Mason` and verify the language server is installed
2. **Verify LSP Attachment**: In a relevant file, run `:LspInfo`
3. **Check for Errors**: Run `:checkhealth lsp`
4. **Check Formatter**: Ensure formatters are installed via `:Mason`
5. **Test conform.nvim**: Try `:ConformInfo` and manual formatting with `:Conform`

</details>

<details>
<summary><strong>Plugins not loading</strong></summary>

1. **Check Status**: Run `:Lazy` to view plugin status
2. **Sync Plugins**: Run `:Lazy sync`
3. **Check Logs**: Run `:Lazy log` for errors
4. **Rebuild Treesitter**: Run `:TSUpdate` if syntax highlighting is off

</details>

<details>
<summary><strong>Slow startup time</strong></summary>

1. **Profile Startup**: Run `nvim --startuptime startup.log`
2. **Check Plugin Profile**: Run `:Lazy profile` inside Neovim
3. **Consider lazy-loading**: Add `lazy = true` with appropriate triggers to plugin configurations

</details>

## 🆘 Getting Help

- Run `:checkhealth` for comprehensive diagnostics
- Use `:help <topic>` for built-in documentation
- Refer to individual plugin documentation on GitHub
- Check the [Neovim documentation](https://neovim.io/doc/)
