# 🚀 Modern Neovim Configuration

A powerful Neovim setup featuring an elegant UI with Snacks.nvim and GitHub theme, comprehensive LSP support, fuzzy finding, VS Code-like experience, and robust plugin management with lazy.nvim.

## ✨ Key Features

-   🔍 **Intelligent Completion**: Fast code completion with Blink.cmp.
-   🌲 **Advanced Syntax**: Rich syntax highlighting and text objects via Treesitter.
-   📂 **File Management**: Multiple options including Oil.nvim, Mini.files, and Snacks Explorer.
-   🔎 **Fuzzy Finding**: Powerful searching with FZF-lua and Snacks pickers.
-   🤖 **LSP Integration**: Full Language Server Protocol support with Mason for easy server management.
-   📝 **VS Code Keybindings**: Familiar workflow with VS Code-style shortcuts.
-   🎨 **Beautiful UI**: GitHub Dark theme, Mini statusline, and Snacks UI elements.
-   🧰 **Git Integration**: Neogit, Diffview, and Snacks Git pickers.
-   ⚡ **Performance**: Optimized for speed with lazy loading via lazy.nvim.

## 🛠️ Environment Setup

1.  **Neovim**: Version 0.9+ (0.10+ recommended).
2.  **Dependencies**:
    *   `git`
    *   `ripgrep` (for FZF live grep, Snacks grep)
    *   `fd` (for FZF file finding)
    *   A Nerd Font (for icons)
    *   Node.js (for some LSPs like `prettierd`)
    *   Rust (optional, for faster Blink.cmp fuzzy matching)

## 🚀 Installation

1.  **Backup existing config** (optional):
    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    mv ~/.local/state/nvim ~/.local/state/nvim.bak
    mv ~/.cache/nvim ~/.cache/nvim.bak
    ```
2.  **Clone the repository**:
    ```bash
    git clone <your-repo-url> ~/.config/nvim
    ```
3.  **Start Neovim**:
    ```bash
    nvim
    ```
    Lazy.nvim will automatically install all plugins on the first run.

## 🔑 Keybinding Reference

**Leader Key**: `Space`

### 🌟 General & Navigation

| Key         | Mode | Description                     | Source         |
| :---------- | :--- | :------------------------------ | :------------- |
| `jk`        | `i`  | Exit insert mode                | keymaps.lua    |
| `<leader>nh`| `n`  | Clear search highlights         | keymaps.lua    |
| `<C-h>`     | `n`  | Navigate window left            | keymaps.lua    |
| `<C-j>`     | `n`  | Navigate window down            | keymaps.lua    |
| `<C-k>`     | `n`  | Navigate window up              | keymaps.lua    |
| `<C-l>`     | `n`  | Navigate window right           | keymaps.lua    |
| `<leader>[` | `n`  | Previous buffer                 | keymaps.lua    |
| `<leader>]` | `n`  | Next buffer                     | keymaps.lua    |
| `<C-c>`     | `i`  | Alternative ESC                 | keymaps.lua    |
| `<C-s>`     | `n,i`| Quick Save                      | keymaps.lua    |
| `]]`        | `n,t`| Next Reference (Snacks Words)   | snacks.lua     |
| `[[`        | `n,t`| Previous Reference (Snacks Words)| snacks.lua     |
| `]t`        | `n`  | Next TODO comment               | todo.lua       |
| `[t`        | `n`  | Previous TODO comment           | todo.lua       |

### 📂 File & Project Management

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `<leader><space>`| `n`  | Smart Find Files (Snacks)       | snacks.lua     |
| `<leader>e`     | `n`  | File Explorer (Snacks)          | snacks.lua     |
| `<leader>ff`    | `n`  | Find Files (Snacks)             | snacks.lua     |
| `<leader>fg`    | `n`  | Find Git Files (Snacks)         | snacks.lua     |
| `<leader>fr`    | `n`  | Recent Files (Snacks)           | snacks.lua     |
| `<leader>fc`    | `n`  | Find Config File (Snacks)       | snacks.lua     |
| `<leader>fp`    | `n`  | Browse Projects (Snacks)        | snacks.lua     |
| `<leader>zf`    | `n`  | Find Files (FZF)                | fzf-mini.lua   |
| `<leader>zc`    | `n`  | Find in Config (FZF)            | fzf-mini.lua   |
| `<leader>zo`    | `n`  | Old Files (FZF)                 | fzf-mini.lua   |
| `<leader>me`    | `n`  | Mini file explorer              | mini.lua       |
| `<leader>mp`    | `n`  | Mini pick files                 | mini.lua       |
| `-`             | `n`  | Open Oil File Manager (float)   | oil.lua        |
| `<leader>cR`    | `n`  | Rename File (Snacks)            | snacks.lua     |

### 🔍 Search & Grep

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `<leader>/`     | `n`  | Grep (Snacks)                   | snacks.lua     |
| `<leader>sg`    | `n`  | Search in files (Snacks Grep)   | snacks.lua     |
| `<leader>ss`    | `n`  | Search in buffer (Snacks Lines) | snacks.lua     |
| `<leader>sw`    | `n,x`| Search word under cursor (Snacks)| snacks.lua     |
| `<leader>sB`    | `n`  | Grep Open Buffers (Snacks)      | snacks.lua     |
| `<leader>sb`    | `n`  | Buffer Lines (Snacks)           | snacks.lua     |
| `<leader>zg`    | `n`  | Live Grep (FZF)                 | fzf-mini.lua   |
| `<leader>zw`    | `n`  | Find current Word (FZF)         | fzf-mini.lua   |
| `<leader>zW`    | `n`  | Find current WORD (FZF)         | fzf-mini.lua   |
| `<leader>zr`    | `n`  | Resume Last Search (FZF)        | fzf-mini.lua   |
| `<leader>z/`    | `n`  | Live grep current buffer (FZF)  | fzf-mini.lua   |
| `<leader>mg`    | `n`  | Mini grep live                  | mini.lua       |

### 📊 LSP (Language Server Protocol)

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `gd`            | `n`  | Goto Definition (FZF)           | lsp.lua        |
| `gD`            | `n`  | Goto Declaration                | lsp.lua        |
| `gr`            | `n`  | Goto References (FZF)           | lsp.lua        |
| `gI`            | `n`  | Goto Implementation (FZF)       | lsp.lua        |
| `gy`            | `n`  | Type Definition (Snacks)        | snacks.lua     |
| `<leader>D`     | `n`  | Type Definition (FZF)           | lsp.lua        |
| `<leader>ca`    | `n,x`| Code Action                     | keymaps.lua/lsp|
| `<leader>cr`    | `n`  | Rename Symbol                   | keymaps.lua/lsp|
| `<leader>cs`    | `n`  | Document Symbols (FZF)          | keymaps.lua/lsp|
| `<leader>ds`    | `n`  | Document Symbols (FZF)          | lsp.lua        |
| `<leader>ws`    | `n`  | Workspace Symbols (FZF)         | lsp.lua        |
| `<leader>ss`    | `n`  | LSP Symbols (Snacks)            | snacks.lua     |
| `<leader>sS`    | `n`  | Workspace Symbols (Snacks)      | snacks.lua     |
| `<S-k>`         | `n`  | Show Hover Info                 | keymaps.lua/lsp|
| `<leader>th`    | `n`  | Toggle Inlay Hints              | lsp.lua        |
| `<leader>zd`    | `n`  | Diagnostics (FZF)               | fzf-mini.lua   |

### 📝 Editing & Text Manipulation

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `<leader>c/`    | `n,v`| Toggle comment (Comment.nvim)   | keymaps.lua    |
| `gc`            | `n,v`| Comment (mini.comment)          | mini.lua       |
| `gcc`           | `n`  | Comment line (mini.comment)     | mini.lua       |
| `<S-j>`         | `v`  | Move lines down                 | keymaps.lua    |
| `<S-k>`         | `v`  | Move lines up                   | keymaps.lua    |
| `<leader>+`     | `n`  | Increment number                | keymaps.lua    |
| `<leader>=`     | `n`  | Decrement number                | keymaps.lua    |

### 🌲 Treesitter

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `<C-space>`     | `n`  | Incremental selection init/inc  | treesitter.lua |
| `<bs>`          | `n`  | Incremental selection dec       | treesitter.lua |
| `<leader>a`     | `n`  | Swap with next parameter        | keymaps.lua    |
| `<leader>A`     | `n`  | Swap with previous parameter    | keymaps.lua    |
| `af`            | `o,x`| Select outer function           | treesitter.lua |
| `if`            | `o,x`| Select inner function           | treesitter.lua |
| `ac`            | `o,x`| Select outer class              | treesitter.lua |
| `ic`            | `o,x`| Select inner class              | treesitter.lua |
| `ao`            | `o,x`| Select outer comment            | treesitter.lua |
| `as`            | `o,x`| Select scope                    | treesitter.lua |

### 📑 Buffer & Tab Management

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `<leader>bd`    | `n`  | Delete Buffer (Snacks/Mini)     | snacks.lua/keymaps.lua |
| `<leader>ba`    | `n`  | Delete All Buffers (Snacks)     | snacks.lua     |
| `<leader>bo`    | `n`  | Delete Other Buffers (Snacks/Core)| snacks.lua/keymaps.lua |
| `<leader>mb`    | `n`  | Mini delete buffer              | mini.lua       |
| `<leader>mB`    | `n`  | Mini force delete buffer        | mini.lua       |
| `<leader>,`     | `n`  | Browse Buffers (Snacks)         | snacks.lua     |
| `<leader>fb`    | `n`  | Browse Buffers (Snacks)         | snacks.lua     |
| `<leader>z<space>`| `n`  | Browse Buffers (FZF)            | fzf-mini.lua   |
| `<leader>to`    | `n`  | Open new tab                    | keymaps.lua    |
| `<leader>tx`    | `n`  | Close current tab               | keymaps.lua    |
| `<leader>tn`    | `n`  | Next tab                        | keymaps.lua    |
| `<leader>tp`    | `n`  | Previous tab                    | keymaps.lua    |
| `<leader>tf`    | `n`  | Open buffer in new tab          | keymaps.lua    |

### 🪟 Window Management

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `sh`            | `n`  | Split horizontally              | keymaps.lua    |
| `sv`            | `n`  | Split vertically                | keymaps.lua    |
| `<leader>se`    | `n`  | Equalize window sizes           | keymaps.lua    |
| `<leader>sx`    | `n`  | Close current split             | keymaps.lua    |
| `<C-Up>`        | `n`  | Resize split up                 | keymaps.lua    |
| `<C-Down>`      | `n`  | Resize split down               | keymaps.lua    |
| `<C-Left>`      | `n`  | Resize split left               | keymaps.lua    |
| `<C-Right>`     | `n`  | Resize split right              | keymaps.lua    |

### 📚 Git Operations

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `<leader>gs`    | `n`  | Git Status (Snacks)             | snacks.lua     |
| `<leader>gb`    | `n`  | Git Branches (Snacks)           | snacks.lua     |
| `<leader>gl`    | `n`  | Git Log (Snacks)                | snacks.lua     |
| `<leader>gL`    | `n`  | Git Log Line (Snacks)           | snacks.lua     |
| `<leader>gd`    | `n`  | Git Diff Hunks (Snacks)         | snacks.lua     |
| `<leader>gf`    | `n`  | Git Log File (Snacks)           | snacks.lua     |
| `<leader>gS`    | `n`  | Git Stash (Snacks)              | snacks.lua     |
| `<leader>gB`    | `n,v`| Git Browse (Snacks)             | snacks.lua     |
| `<leader>gg`    | `n`  | Open Lazygit (Snacks)           | snacks.lua     |

### 💻 Terminal

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `<C-/>`         | `n,t`| Toggle Terminal (Snacks)        | snacks.lua     |
| `<C-_>`         | `n,t`| Toggle Terminal (Snacks)        | snacks.lua     |
| `<C-\>`         | `n`  | Toggle Terminal (ToggleTerm)    | toggle-terminal.lua |

### 🔧 UI Toggles & Settings (Snacks)

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `<leader>us`    | `n`  | Toggle Spelling                 | snacks.lua     |
| `<leader>uw`    | `n`  | Toggle Wrap                     | snacks.lua     |
| `<leader>uL`    | `n`  | Toggle Relative Number          | snacks.lua     |
| `<leader>ud`    | `n`  | Toggle Diagnostics              | snacks.lua     |
| `<leader>ul`    | `n`  | Toggle Line Number              | snacks.lua     |
| `<leader>uc`    | `n`  | Toggle Conceal Level            | snacks.lua     |
| `<leader>uT`    | `n`  | Toggle Treesitter               | snacks.lua     |
| `<leader>ub`    | `n`  | Toggle Dark Background          | snacks.lua     |
| `<leader>uh`    | `n`  | Toggle Inlay Hints              | snacks.lua     |
| `<leader>uD`    | `n`  | Toggle Dim Mode                 | snacks.lua     |
| `<leader>un`    | `n`  | Dismiss Notifications           | snacks.lua     |

### 🧘 Focus Modes (Snacks)

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `<leader>z`     | `n`  | Toggle Zen Mode                 | snacks.lua     |
| `<leader>Z`     | `n`  | Toggle Zoom                     | snacks.lua     |

### 📝 Session Management (Mini.sessions)

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `<leader>ws`    | `n`  | Write Session                   | mini.lua       |
| `<leader>wr`    | `n`  | Read Last Session               | mini.lua       |
| `<leader>wd`    | `n`  | Delete Last Session             | mini.lua       |

### 📋 Miscellaneous

| Key             | Mode | Description                     | Source         |
| :-------------- | :--- | :------------------------------ | :------------- |
| `<leader>.`     | `n`  | Toggle Scratch Buffer (Snacks)  | snacks.lua     |
| `<leader>S`     | `n`  | Select Scratch Buffer (Snacks)  | snacks.lua     |
| `<leader>:`     | `n`  | Command History (Snacks)        | snacks.lua     |
| `<leader>n`     | `n`  | Notification History (Snacks)   | snacks.lua     |
| `<leader>zh`    | `n`  | Helptags (FZF)                  | fzf-mini.lua   |
| `<leader>zk`    | `n`  | Keymaps (FZF)                   | fzf-mini.lua   |
| `<leader>zb`    | `n`  | Builtins (FZF)                  | fzf-mini.lua   |

## 🔌 Main Plugins

-   **Core/UI**: Snacks.nvim, lazy.nvim, which-key.nvim, github-nvim-theme
-   **Completion**: Blink.cmp, LuaSnip, friendly-snippets
-   **LSP**: nvim-lspconfig, mason.nvim, mason-lspconfig.nvim, fidget.nvim
-   **Formatting**: conform.nvim
-   **Syntax**: nvim-treesitter, nvim-ts-autotag
-   **File Management**: oil.nvim, mini.files
-   **Fuzzy Finding**: fzf-lua, mini.pick
-   **Git**: NeogitOrg/neogit, diffview.nvim
-   **Editing Utilities**: mini.nvim (comment, ai, surround, operators, pairs, bracketed, bufremove, sessions), Comment.nvim, todo-comments.nvim
-   **Terminal**: toggleterm.nvim
-   **Database**: vim-dadbod-ui, vim-dadbod, vim-dadbod-completion
-   **Other**: vim-sleuth

## 💡 Customization

-   **Plugins**: Add new plugins by creating `.lua` files in `lua/plugins/`.
-   **Keymaps**: Modify core keybindings in `lua/config/keymaps.lua` or plugin-specific keys in their respective files under `lua/plugins/`.
-   **Options**: Adjust editor settings in `lua/config/options.lua`.
-   **Theme**: Customize theme settings in `lua/plugins/github-theme.lua`.
-   **LSP Servers**: Add/remove servers in the `servers` table within `lua/plugins/lsp.lua`. Mason will handle installation.
-   **Formatters**: Configure formatters in `lua/plugins/conform.lua`. Install them via Mason in `lua/plugins/lsp.lua`.