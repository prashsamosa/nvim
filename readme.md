
## 🧠 Key Concepts
This configuration uses:

- **Space** as the leader key
- **Lazy.nvim** for plugin management
- **Snacks.nvim** for many core features
- **FZF-lua** for fuzzy finding
- **Blink.cmp** for completions
- **Oil.nvim** and **Mini.files** for file management
- **GitHub Theme** for visual aesthetics

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

### 📁 File Navigation & Explorer

| Key | Description |
|-----|-------------|
| `<leader><space>` | Smart file finder |
| `<leader>e` | Snacks file explorer |
| `<leader>me` | Mini file explorer |
| `-` | Oil file manager |
| `<leader>ff` | Find files (Snacks) |
| `<leader>fg` | Find in git files (Snacks) |
| `<leader>zf` | Find files (FZF) |
| `<leader>zc` | Find in config files (FZF) |

### 🔍 Search

| Key | Description |
|-----|-------------|
| `<leader>sg` | Search in files (grep) |
| `<leader>ss` | Search in current buffer |
| `<leader>sw` | Search word under cursor |
| `<leader>/` | Toggle comment |
| `<leader>zg` | FZF live grep |
| `<leader>z/` | FZF search in buffer |

### 📊 LSP & Code Navigation

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
| `<S-k>` | Show hover info |
| `<leader>D` | Type definition |
| `<leader>th` | Toggle inlay hints |

### 📝 Editing

| Key | Description |
|-----|-------------|
| `<S-j>` | Move line down (Visual) |
| `<S-k>` | Move line up (Visual) |
| `<leader>/` | Toggle comment |
| `<leader>+` | Increment number |
| `<leader>=` | Decrement number |
| `<C-s>` | Save file |

### 🪟 Window Management

| Key | Description |
|-----|-------------|
| `sh` | Split horizontally |
| `sv` | Split vertically |
| `<leader>se` | Equalize windows |
| `<leader>sx` | Close split |
| `<C-Up/Down/Left/Right>` | Resize splits |

### 📋 Buffer Management

| Key | Description |
|-----|-------------|
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Delete other buffers |
| `<leader>ba` | Delete all buffers (Snacks) |
| `<leader>mb` | Mini delete buffer |
| `<leader>mB` | Mini force delete buffer |

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
| `<leader>gL` | Git line log |
| `<leader>gd` | Git diff hunks |
| `<leader>gf` | Git file log |
| `<leader>gS` | Git stash |
| `<leader>gg` | Open Lazygit |

### 💻 Terminal

| Key | Description |
|-----|-------------|
| `<C-/>` or `<C-_>` | Toggle Snacks terminal |
| `<C-\>` | Toggle ToggleTerm |

### 🔧 UI Toggles & Settings

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
| `<leader>un` | Dismiss notifications |

### 🧘 Focus Modes

| Key | Description |
|-----|-------------|
| `<leader>z` | Toggle Zen mode |
| `<leader>Z` | Toggle Zoom mode |

### 🔄 Session Management 

| Key | Description |
|-----|-------------|
| `<leader>ws` | Save workspace |
| `<leader>wl` | Load workspace |

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

### 📋 Special Features

| Key | Description |
|-----|-------------|
| `<leader>.` | Toggle scratch buffer |
| `<leader>S` | Select scratch buffer |
| `<leader>N` | View Neovim news |
| `<leader>n` | Notification history |
| `<leader>cR` | Rename file |
| `]]` | Next word reference |
| `[[` | Previous word reference |
| `]t` | Next TODO comment |
| `[t` | Previous TODO comment |

## 🔨 Customization

### Adding New Plugins

Add new plugins by creating a new file in `lua/plugins/` with the plugin configuration.

### Changing Colorscheme

The default colorscheme is GitHub Dark. To change it, modify `lua/plugins/github-theme.lua`.

### Adjusting LSP Settings

Language servers are configured in `lua/plugins/lsp.lua`. Add new servers to the `servers` table.

### Personal Snippets

Add custom snippets by extending the friendly-snippets collection that comes with Blink.cmp.

## 💡 Tips & Tricks

- Use `<leader>z` for distraction-free writing
- Try `<leader>sg` for searching project-wide
- Use `<leader>gg` to open Lazygit for Git operations
- Navigate between errors with `[d` and `]d`
- Use Oil.nvim (`-`) for quick file management
- Try `<leader>zk` to list all available keymaps

## 🔌 Plugin List

Key plugins in this configuration:

- **Core Experience**: Snacks.nvim, lazy.nvim, fzf-lua
- **Editing**: Comment.nvim, treesitter, mini.nvim
- **Completion**: blink.cmp, friendly-snippets, blink-emoji
- **UI**: github-nvim-theme, mini.statusline, mini.notify
- **File Management**: oil.nvim, mini.files
- **Git**: neogit, diffview.nvim
- **Terminal**: toggleterm.nvim
- **LSP**: nvim-lspconfig, mason.nvim, conform.nvim

## 📚 Further Reading

- [Neovim Documentation](https://neovim.io/doc/)
- [Lua Tutorials](https://www.lua.org/pil/)
- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)