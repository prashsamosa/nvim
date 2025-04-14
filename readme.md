# 🚀 My Neovim Configuration

A powerful Neovim setup featuring an elegant UI with Snacks.nvim and GitHub theme, comprehensive LSP support, fuzzy finding, VS Code-like experience, enhanced Markdown rendering, and robust plugin management with lazy.nvim.

## ✨ Key Features

- 🔍 **Intelligent Completion**: Fast code completion with Blink.cmp.
- 🌲 **Advanced Syntax**: Rich syntax highlighting, text objects, and incremental selection via Treesitter.
- 📄 **Enhanced Markdown**: Improved Markdown viewing with `render-markdown.nvim`, featuring concealed syntax, icons, borders, and more.
- 📂 **File Management**: Multiple options including Oil.nvim (floating), Neo-tree (sidebar), Mini.files, and Snacks Explorer.
- 🔎 **Fuzzy Finding**: Powerful searching with FZF-lua and Snacks pickers.
- 🤖 **LSP Integration**: Full Language Server Protocol support with Mason for easy server management, enhanced by Fidget status updates.
- 📝 **VS Code Keybindings**: Familiar workflow with VS Code-style shortcuts.
- 🎨 **Beautiful UI**: GitHub Dark theme, Snacks UI elements, and dashboard.
- 🧰 **Git Integration**: Neogit, Diffview, and Snacks Git pickers.
- ⚡ **Performance**: Optimized with lazy loading via lazy.nvim (Note: Snacks loads eagerly for instant dashboard/features).
- 📑 **Enhanced Buffers**: Feature-rich buffer management with `barbar.nvim`.

## 🛠️ Environment Setup

1. **Neovim**: Version 0.9+ (0.10+ recommended for full `render-markdown` features).
2. **Dependencies**:
    * `git`
    * `ripgrep` (for FZF live grep, Snacks grep)
    * `fd` (for FZF file finding)
    * A Nerd Font (for icons in UI elements like statusline, devicons, todo-comments, diagnostics, markdown rendering)
    * Node.js (for some LSPs/formatters like `prettierd`)
    * `stylua` (for Lua formatting, installed via Mason)
    * Rust (optional, for faster Blink.cmp fuzzy matching)
    * `pylatexenc` (optional, Python package for LaTeX rendering in Markdown, install via `pip install pylatexenc`)

## 🚀 Installation

1. **Backup existing config** (optional):
    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    mv ~/.local/state/nvim ~/.local/state/nvim.bak
    mv ~/.cache/nvim ~/.cache/nvim.bak
    ```
2. **Clone the repository**:
    ```bash
    git clone <your-repo-url> ~/.config/nvim
    ```
3. **Start Neovim**:
    ```bash
    nvim
    ```
    Lazy.nvim will automatically install all plugins on the first run. Ensure Treesitter parsers are installed/updated (`:TSUpdate`).

## ⌨️ Keybinding Reference

**Leader Key**: `Space`

### 🌟 General & Navigation

| Key          | Mode | Description                     | Source        |
| :----------- | :--- | :------------------------------ | :------------ |
| `jk`         | `i`  | Exit insert mode                | `keymaps.lua` |
| `<leader>nh` | `n`  | Clear search highlights         | `keymaps.lua` |
| `<C-h>`      | `n`  | Navigate window left            | `keymaps.lua` |
| `<C-j>`      | `n`  | Navigate window down            | `keymaps.lua` |
| `<C-k>`      | `n`  | Navigate window up              | `keymaps.lua` |
| `<C-l>`      | `n`  | Navigate window right           | `keymaps.lua` |
| `<C-c>`      | `i`  | Alternative ESC                 | `keymaps.lua` |
| `<C-s>`      | `n,i`| Quick Save                      | `keymaps.lua` |
| `]]`         | `n,t`| Next Reference (Snacks Words)   | `snacks.lua`  |
| `[[`         | `n,t`| Previous Reference (Snacks Words)| `snacks.lua`  |
| `]t`         | `n`  | Next TODO comment               | `todo.lua`    |
| `[t`         | `n`  | Previous TODO comment           | `todo.lua`    |

### 📂 File & Project Management

| Key               | Mode | Description                       | Source         |
| :---------------- | :--- | :-------------------------------- | :------------- |
| `<leader><space>` | `n`  | Smart Find Files (Snacks)         | `snacks.lua`   |
| `<leader>e`       | `n`  | File Explorer (Snacks)            | `snacks.lua`   |
| `<leader>ff`      | `n`  | Find Files (FZF)                  | `fzf-mini.lua` |
| `<leader>fg`      | `n`  | Find Git Files (Snacks)           | `snacks.lua`   |
| `<leader>fr`      | `n`  | Recent Files (Snacks)             | `snacks.lua`   |
| `<leader>fc`      | `n`  | Find Config File (FZF)            | `fzf-mini.lua` |
| `<leader>fp`      | `n`  | Browse Projects (Snacks)          | `snacks.lua`   |
| `<leader>fo`      | `n`  | Old Files (FZF)                   | `fzf-mini.lua` |
| `<leader>me`      | `n`  | Mini file explorer                | `mini.lua`     |
| `<leader>mp`      | `n`  | Mini pick files                   | `mini.lua`     |
| `-`               | `n`  | Open Oil File Manager (float)     | `oil.lua`      |
| `<leader>cR`      | `n`  | Rename File (Snacks)              | `snacks.lua`   |
| _(Neo-tree)_      | `n`  | _(Use `:Neotree` or default keys)_| `neo-tree.lua` |

### 🔍 Search & Grep

| Key          | Mode | Description                        | Source         |
| :----------- | :--- | :--------------------------------- | :------------- |
| `<leader>sg` | `n`  | Search in files (Snacks Grep)    | `snacks.lua`   |
| `<leader>sb` | `n`  | Search in buffer (Snacks Lines)  | `snacks.lua`   |
| `<leader>sw` | `n,x`| Search word under cursor (Snacks) | `snacks.lua`   |
| `<leader>sB` | `n`  | Grep Open Buffers (Snacks)       | `snacks.lua`   |
| `<leader>fg` | `n`  | Live Grep (FZF)                    | `fzf-mini.lua` |
| `<leader>fw` | `n`  | Find current Word (FZF)          | `fzf-mini.lua` |
| `<leader>fW` | `n`  | Find current WORD (FZF)          | `fzf-mini.lua` |
| `<leader>fr` | `n`  | Resume Last Search (FZF)         | `fzf-mini.lua` |
| `<leader>f/` | `n`  | Live grep current buffer (FZF)   | `fzf-mini.lua` |
| `<leader>mg` | `n`  | Mini grep live                   | `mini.lua`     |

### 📊 LSP (Language Server Protocol)

| Key          | Mode | Description                  | Source      |
| :----------- | :--- | :--------------------------- | :---------- |
| `gd`         | `n`  | Goto Definition (LSP)        | `lsp.lua`   |
| `gD`         | `n`  | Goto Declaration             | `lsp.lua`   |
| `gr`         | `n`  | Goto References (LSP)        | `lsp.lua`   |
| `gI`         | `n`  | Goto Implementation (LSP)    | `lsp.lua`   |
| `<leader>D`  | `n`  | Type Definition (LSP)        | `lsp.lua`   |
| `<leader>ca` | `n,x`| Code Action                  | `lsp.lua`   |
| `<leader>cr` | `n`  | Rename Symbol                | `lsp.lua`   |
| `<leader>ds` | `n`  | Document Symbols (LSP)       | `lsp.lua`   |
| `<leader>ws` | `n`  | Workspace Symbols (LSP)      | `lsp.lua`   |
| `<S-k>`      | `n`  | Show Hover Info              | `lsp.lua`   |
| `<leader>th` | `n`  | Toggle Inlay Hints           | `lsp.lua`   |
| `<leader>fd` | `n`  | Diagnostics (FZF)            | `fzf-mini.lua` |


### 📝 Editing & Text Manipulation

| Key          | Mode | Description                       | Source        |
| :----------- | :--- | :-------------------------------- | :------------ |
| `gc`         | `n,v`| Comment (mini.comment)            | `mini.lua`    |
| `gcc`        | `n`  | Comment line (mini.comment)       | `mini.lua`    |
| `<S-j>`      | `v`  | Move lines down                   | `keymaps.lua` |
| `<S-k>`      | `v`  | Move lines up                     | `keymaps.lua` |
| `<leader>+`  | `n`  | Increment number                  | `keymaps.lua` |
| `<leader>=`  | `n`  | Decrement number                  | `keymaps.lua` |

### 🌲 Treesitter

| Key         | Mode | Description                     | Source              |
| :---------- | :--- | :------------------------------ | :------------------ |
| `<Enter>`   | `n`  | Incremental selection init/inc  | `treesitter.lua` |
| `<Backspace>`| `n`  | Incremental selection dec       | `treesitter.lua` |
| `<leader>a` | `n`  | Swap with next parameter       | `keymaps.lua`       |
| `<leader>A` | `n`  | Swap with previous parameter   | `keymaps.lua`       |
| `af`        | `o,x`| Select outer function           | `treesitter.lua` |
| `if`        | `o,x`| Select inner function           | `treesitter.lua` |
| `ac`        | `o,x`| Select outer class              | `treesitter.lua` |
| `ic`        | `o,x`| Select inner class              | `treesitter.lua` |
| `ao`        | `o,x`| Select outer comment            | `treesitter.lua` |
| `as`        | `o,x`| Select scope                    | `treesitter.lua` |

### 📑 Buffer Management (`barbar.nvim`)

| Key       | Mode | Description                        | Source        |
| :-------- | :--- | :--------------------------------- | :------------ |
| `<A-,>`   | `n`  | Go to previous buffer              | `barbar.lua` |
| `<A-.>`   | `n`  | Go to next buffer                  | `barbar.lua` |
| `<A-<>`   | `n`  | Move current buffer to previous    | `barbar.lua` |
| `<A->>`   | `n`  | Move current buffer to next        | `barbar.lua` |
| `<A-1>`   | `n`  | Go to buffer 1                     | `barbar.lua` |
| `<A-2>`   | `n`  | Go to buffer 2                     | `barbar.lua` |
| `<A-3>`   | `n`  | Go to buffer 3                     | `barbar.lua` |
| `<A-4>`   | `n`  | Go to buffer 4                     | `barbar.lua` |
| `<A-5>`   | `n`  | Go to buffer 5                     | `barbar.lua` |
| `<A-6>`   | `n`  | Go to buffer 6                     | `barbar.lua` |
| `<A-7>`   | `n`  | Go to buffer 7                     | `barbar.lua` |
| `<A-8>`   | `n`  | Go to buffer 8                     | `barbar.lua` |
| `<A-9>`   | `n`  | Go to buffer 9                     | `barbar.lua` |
| `<A-0>`   | `n`  | Go to last buffer                  | `barbar.lua` |
| `<A-p>`   | `n`  | Pin/unpin current buffer           | `barbar.lua` |
| `<A-c>`   | `n`  | Close current buffer               | `barbar.lua` |
| `<A-b>`   | `n`  | Close all buffers but current      | `barbar.lua` |

### 🪟 Window Management

| Key          | Mode | Description             | Source        |
| :----------- | :--- | :---------------------- | :------------ |
| `sh`         | `n`  | Split horizontally      | `keymaps.lua` |
| `sv`         | `n`  | Split vertically        | `keymaps.lua` |
| `<leader>se` | `n`  | Equalize window sizes   | `keymaps.lua` |
| `<leader>sx` | `n`  | Close current split     | `keymaps.lua` |
| `<C-Up>`     | `n`  | Resize split up         | `keymaps.lua` |
| `<C-Down>`   | `n`  | Resize split down       | `keymaps.lua` |
| `<C-Left>`   | `n`  | Resize split left       | `keymaps.lua` |
| `<C-Right>`  | `n`  | Resize split right      | `keymaps.lua` |

### 📚 Git Operations

| Key          | Mode | Description             | Source        |
| :----------- | :--- | :---------------------- | :------------ |
| `<leader>gs` | `n`  | Git Status (Snacks)     | `snacks.lua`  |
| `<leader>gb` | `n`  | Git Branches (Snacks)   | `snacks.lua`  |
| `<leader>gl` | `n`  | Git Log (Snacks)        | `snacks.lua`  |
| `<leader>gL` | `n`  | Git Log Line (Snacks)   | `snacks.lua`  |
| `<leader>gd` | `n`  | Git Diff Hunks (Snacks) | `snacks.lua`  |
| `<leader>gf` | `n`  | Git Log File (Snacks)   | `snacks.lua`  |
| `<leader>gS` | `n`  | Git Stash (Snacks)      | `snacks.lua`  |
| `<leader>gB` | `n,v`| Git Browse (Snacks)     | `snacks.lua`  |
| `<leader>gg` | `n`  | Open Lazygit (Snacks)   | `snacks.lua`  |
| `<leader>gn` | `n`  | Open Neogit             | `neogit.lua`  |
| _(Neogit)_   | `n`  | _(Use `:Neogit`)_       | `neogit.lua`  |

### 💻 Terminal

| Key          | Mode | Description                        | Source              |
| :----------- | :--- | :--------------------------------- | :------------------ |
| `<C-\>`      | `n`  | Toggle Terminal (ToggleTerm)       | `toggle-terminal.lua` |
| `<leader>tt` | `n`  | Toggle Terminal (float)            | `toggle-terminal.lua` |
| `<leader>th` | `n`  | Toggle Terminal (horizontal)       | `toggle-terminal.lua` |
| `<leader>tv` | `n`  | Toggle Terminal (vertical)         | `toggle-terminal.lua` |
| `<leader>tl` | `n`  | Send Line to Terminal              | `toggle-terminal.lua` |
| `<leader>ts` | `n`  | Select Terminal                    | `toggle-terminal.lua` |


### 🔧 UI Toggles & Settings (Snacks & Markdown)

| Key          | Mode | Description                 | Source        |
| :----------- | :--- | :-------------------------- | :------------ |
| `<leader>us` | `n`  | Toggle Spelling             | `snacks.lua`  |
| `<leader>uw` | `n`  | Toggle Wrap                 | `snacks.lua`  |
| `<leader>uL` | `n`  | Toggle Relative Number      | `snacks.lua`  |
| `<leader>ud` | `n`  | Toggle Diagnostics          | `snacks.lua`  |
| `<leader>ul` | `n`  | Toggle Line Number          | `snacks.lua`  |
| `<leader>uc` | `n`  | Toggle Conceal Level        | `snacks.lua`  |
| `<leader>uT` | `n`  | Toggle Treesitter           | `snacks.lua`  |
| `<leader>ub` | `n`  | Toggle Dark Background      | `snacks.lua`  |
| `<leader>uh` | `n`  | Toggle Inlay Hints          | `snacks.lua`  |
| `<leader>uD` | `n`  | Toggle Dim Mode             | `snacks.lua`  |
| `<leader>un` | `n`  | Dismiss Notifications       | `snacks.lua`  |
| `<leader>Mm` | `n`  | Toggle Markdown Render      | `markdown.lua`|
| `<leader>Me` | `n`  | Expand Markdown View        | `markdown.lua`|
| `<leader>Mc` | `n`  | Contract Markdown View      | `markdown.lua`|
| `<leader>ML` | `n`  | Open Markdown Log           | `markdown.lua`|
| `<leader>Md` | `n`  | Debug Markdown Line         | `markdown.lua`|
| `<leader>Ms` | `n`  | Show Markdown Config        | `markdown.lua`|

### 🧘 Focus Modes (Snacks)

| Key        | Mode | Description        | Source      |
| :--------- | :--- | :----------------- | :---------- |
| `<leader>z`| `n`  | Toggle Zen Mode    | `snacks.lua`|
| `<leader>Z`| `n`  | Toggle Zoom        | `snacks.lua`|

### 📝 Session Management (Mini.sessions)

| Key          | Mode | Description           | Source      |
| :----------- | :--- | :-------------------- | :---------- |
| `<leader>ms` | `n`  | Write Session         | `mini.lua`  |
| `<leader>mr` | `n`  | Read Last Session     | `mini.lua`  |
| `<leader>md` | `n`  | Delete Last Session   | `mini.lua`  |

### 📋 Miscellaneous

| Key          | Mode | Description                  | Source         |
| :----------- | :--- | :--------------------------- | :------------- |
| `<leader>.`  | `n`  | Toggle Scratch Buffer (Snacks)| `snacks.lua`   |
| `<leader>S`  | `n`  | Select Scratch Buffer (Snacks)| `snacks.lua`   |
| `<leader>:`  | `n`  | Command History (Snacks)     | `snacks.lua`   |
| `<leader>n`  | `n`  | Notification History (Snacks)| `snacks.lua`   |
| `<leader>fh` | `n`  | Helptags (FZF)               | `fzf-mini.lua` |
| `<leader>fk` | `n`  | Keymaps (FZF)                | `fzf-mini.lua` |
| `<leader>fb` | `n`  | Builtins/Commands (FZF)      | `fzf-mini.lua` |

## 🔌 Main Plugins

- **Core/UI**: Snacks.nvim, lazy.nvim, which-key.nvim, github-nvim-theme
- **Completion**: Blink.cmp, friendly-snippets
- **LSP**: nvim-lspconfig, mason.nvim, mason-lspconfig.nvim, fidget.nvim, mason-tool-installer.nvim
- **Formatting**: conform.nvim
- **Syntax**: nvim-treesitter
- **Markdown**: render-markdown.nvim
- **File Management**: oil.nvim, neo-tree.nvim, mini.files
- **Fuzzy Finding**: fzf-lua, mini.pick
- **Git**: NeogitOrg/neogit, diffview.nvim
- **Buffer Management**: barbar.nvim
- **Editing Utilities**: mini.nvim (comment, ai, surround, operators, pairs, bracketed, bufremove, sessions, notify), todo-comments.nvim
- **Terminal**: toggleterm.nvim
- **Database**: vim-dadbod-ui, vim-dadbod, vim-dadbod-completion
- **Elixir**: elixir-tools/elixir-tools.nvim
- **Other**: vim-sleuth

## 💡 Customization

- **Plugins**: Add new plugins by creating `.lua` files in `lua/plugins/`.
- **Keymaps**: Modify core keybindings in `lua/config/keymaps.lua` or plugin-specific keys in their respective files under `lua/plugins/`.
- **Options**: Adjust editor settings in `lua/config/options.lua`.
- **Theme**: Customize theme settings in `lua/plugins/github-theme.lua`.
- **LSP Servers**: Add/remove servers in the `servers` table within `lua/plugins/lsp.lua`. Mason will handle installation via `mason-lspconfig` and `mason-tool-installer`.
- **Formatters**: Configure formatters in `lua/plugins/conform.lua`. Ensure they are listed in `ensure_installed` within `lua/plugins/lsp.lua` for Mason to install them.
- **Markdown Rendering**: Customize appearance and behavior in `lua/plugins/markdown.lua`.
- **Snacks Startup**: To potentially reduce startup delay, consider setting `enabled = false` for unused modules within the `opts` table in `lua/plugins/snacks.lua`.

## 📚 Further Reading

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [Snacks.nvim Documentation](https://github.com/folke/snacks.nvim)
- [Blink.cmp Documentation](https://github.com/saghen/blink.cmp)
- [render-markdown.nvim Documentation](https://github.com/MeanderingProgrammer/render-markdown.nvim)