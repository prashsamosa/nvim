# 🚀 My Neovim Configuration
<!--
## ✨ Key Features

- 🔍 **Intelligent Completion**: Swift and accurate code completion powered by Blink.cmp.
- 🌲 **Advanced Syntax**: Rich syntax highlighting, precise text objects, and intuitive incremental selection through Treesitter.
- 📄 **Enhanced Markdown**: Superior Markdown viewing with `render-markdown.nvim`, featuring concealed syntax elements, informative icons, clean borders, and more.
- 📂 **Flexible File Management**: Multiple file exploration options including a floating Oil.nvim, a sidebar Neo-tree, the focused Mini.files, and the versatile Snacks Explorer.
- 🔎 **Efficient Fuzzy Finding**: Powerful and rapid searching capabilities with FZF-lua and the integrated Snacks pickers.
- 🤖 **Robust LSP Integration**: Comprehensive Language Server Protocol support facilitated by Mason for effortless server management, enhanced with real-time status updates from Fidget.
- 📝 **Familiar VS Code Keybindings**: A comfortable and efficient workflow leveraging familiar VS Code-style keyboard shortcuts.
- 🎨 **Beautiful User Interface**: An aesthetically pleasing GitHub Dark theme complemented by Snacks UI elements and an informative dashboard.
- 🧰 **Seamless Git Integration**: Streamlined Git operations with Neogit, enhanced diff viewing with Diffview, and convenient Git pickers from Snacks.
- ⚡ **Optimized Performance**: Improved startup and responsiveness achieved through lazy loading of most plugins via lazy.nvim (Note: Snacks loads eagerly to provide an instant dashboard and core features).
- 📑 **Enhanced Buffer Management**: Feature-rich and intuitive buffer handling with `barbar.nvim`. -->

## 🛠️ Environment Setup

1. **Neovim**: Version 0.9+ (0.10+ strongly recommended to unlock the full potential of `render-markdown.nvim`).
2. **Essential Dependencies**:
    * `git` (Version control system)
    * `ripgrep` (`rg`) (Fast, recursive line-oriented search tool for FZF live grep and Snacks grep)
    * `fd` (Simple, fast, and user-friendly alternative to `find` for FZF file finding)
    * A **Nerd Font** (For consistent icons across UI elements such as the statusline, devicons, todo-comments, diagnostics, and Markdown rendering)
    * **Node.js** (Runtime environment for certain Language Servers and formatters, e.g., `prettierd`)
    * `stylua` (Lua code formatter, typically installed via Mason)
    * **Rust** (Optional, for potentially faster fuzzy matching within Blink.cmp)
    * `pylatexenc` (Optional Python package for rendering LaTeX within Markdown, install via `pip install pylatexenc`)

## 🚀 Installation

1. **Optional: Backup Existing Configuration**:
    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    mv ~/.local/state/nvim ~/.local/state/nvim.bak
    mv ~/.cache/nvim ~/.cache/nvim.bak
    ```
2. **Clone the Configuration Repository**:
    ```bash
    git clone <your-repo-url> ~/.config/nvim
    ```
3. **Launch Neovim**:
    ```bash
    nvim
    ```
    Upon the initial startup, lazy.nvim will automatically download and install all configured plugins. It's crucial to ensure that the necessary Treesitter parsers are installed and up-to-date by running the command `:TSUpdate`.

## ⌨️ Keybinding Reference

**Leader Key**: `<Space>`

### 🌟 General & Navigation

| Key             | Mode | Description                        | Source         |
| :-------------- | :--- | :--------------------------------- | :------------- |
| `jk`            | `i`  | Exit Insert Mode                   | `keymaps.lua`  |
| `<leader>nh`    | `n`  | Clear Search Highlights            | `keymaps.lua`  |
| `<C-h>`         | `n`  | Navigate Window Left               | `keymaps.lua`  |
| `<C-j>`         | `n`  | Navigate Window Down               | `keymaps.lua`  |
| `<C-k>`         | `n`  | Navigate Window Up                 | `keymaps.lua`  |
| `<C-l>`         | `n`  | Navigate Window Right              | `keymaps.lua`  |
| `<C-c>`         | `i`  | Alternative Escape                 | `keymaps.lua`  |
| `<C-s>`         | `n,i`| Quick Save                         | `keymaps.lua`  |
| `]]`            | `n,t`| Next Reference (Snacks Words)    | `snacks.lua`   |
| `[[`            | `n,t`| Previous Reference (Snacks Words)| `snacks.lua`   |
| `]t`            | `n`  | Next TODO Comment                  | `todo.lua`     |
| `[t`            | `n`  | Previous TODO Comment              | `todo.lua`     |

### 📂 File & Project Management

| Key             | Mode | Description                             | Source         |
| :-------------- | :--- | :-------------------------------------- | :------------- |
| `<leader><space>`| `n`  | Smart Find Files (Snacks)               | `snacks.lua`   |
| `<leader>e`     | `n`  | File Explorer (Snacks)                  | `snacks.lua`   |
| `<leader>ff`    | `n`  | Find Files (FZF)                        | `fzf-mini.lua` |
| `<leader>fg`    | `n`  | Find Git Files (Snacks)                 | `snacks.lua`   |
| `<leader>fr`    | `n`  | Recent Files (Snacks)                   | `snacks.lua`   |
| `<leader>fR`    | `n`  | Resume Last Search (FZF)                | `fzf-mini.lua` |
| `<leader>fc`    | `n`  | Find Configuration File (FZF)           | `fzf-mini.lua` |
| `<leader>fp`    | `n`  | Browse Projects (Snacks)                | `snacks.lua`   |
| `<leader>fo`    | `n`  | Old Files (FZF)                         | `fzf-mini.lua` |
| `<leader>me`    | `n`  | Toggle Mini File Explorer               | `mini.lua`     |
| `<leader>mp`    | `n`  | Mini Pick Files                       | `mini.lua`     |
| `-`             | `n`  | Open Oil File Manager (Floating)        | `oil.lua`      |
| `<leader>cR`    | `n`  | Rename File (Snacks)                    | `snacks.lua`   |
<!-- | _(Neo-tree)_    | `n`  | _(Use `:Neotree` or configured keys)_ | `neo-tree.lua` | -->

### 🔍 Search & Grep

| Key             | Mode | Description                         | Source         |
| :-------------- | :--- | :---------------------------------- | :------------- |
| `<leader>sg`    | `n`  | Search in Files (Snacks Grep)       | `snacks.lua`   |
| `<leader>sb`    | `n`  | Search in Buffer (Snacks Lines)     | `snacks.lua`   |
| `<leader>sw`    | `n,x`| Search Word Under Cursor (Snacks)   | `snacks.lua`   |
| `<leader>sB`    | `n`  | Grep Open Buffers (Snacks)          | `snacks.lua`   |
| `<leader>fl`    | `n`  | Live Grep (FZF)                       | `fzf-mini.lua` |
| `<leader>fw`    | `n`  | Find Current Word (FZF)             | `fzf-mini.lua` |
| `<leader>fW`    | `n`  | Find Current WORD (FZF)             | `fzf-mini.lua` |
| `<leader>fR`    | `n`  | Resume Last Search (FZF)            | `fzf-mini.lua` |
| `<leader>f/`    | `n`  | Live Grep Current Buffer (FZF)      | `fzf-mini.lua` |
| `<leader>mg`    | `n`  | Mini Grep Live                      | `mini.lua`     |

### 📊 LSP (Language Server Protocol)

| Key       | Mode | Description                    | Source    |
| :-------- | :--- | :----------------------------- | :-------- |
| `gd`      | `n`  | Go to Definition (LSP)         | `lsp.lua` |
| `gD`      | `n`  | Go to Declaration              | `lsp.lua` |
| `gr`      | `n`  | Go to References (LSP)         | `lsp.lua` |
| `gI`      | `n`  | Go to Implementation (LSP)     | `lsp.lua` |
| `<leader>D`| `n`  | Type Definition (LSP)          | `lsp.lua` |
| `<leader>ca`| `n,x`| Code Action                    | `lsp.lua` |
| `<leader>cr`| `n`  | Rename Symbol                  | `lsp.lua` |
| `<leader>ds`| `n`  | Document Symbols (LSP)         | `lsp.lua` |
| `<leader>ws`| `n`  | Workspace Symbols (LSP)        | `lsp.lua` |
| `<S-k>`   | `n`  | Show Hover Information         | `lsp.lua` |
| `<leader>ih`| `n`  | Toggle Inlay Hints             | `lsp.lua` |
| `<leader>fd`| `n`  | Diagnostics (FZF)              | `fzf-mini.lua` |

### 📝 Editing & Text Manipulation

| Key       | Mode | Description                   | Source      |
| :-------- | :--- | :---------------------------- | :---------- |
| `gc`      | `n,v`| Toggle Comment (mini.comment) | `mini.lua`  |
| `gcc`     | `n`  | Comment Line (mini.comment)   | `mini.lua`  |
| `<S-j>`   | `v`  | Move Lines Down               | `keymaps.lua`|
| `<S-k>`   | `v`  | Move Lines Up                 | `keymaps.lua`|
| `<leader>+`| `n`  | Increment Number              | `keymaps.lua`|
| `<leader>=`| `n`  | Decrement Number              | `keymaps.lua`|

### 🌲 Treesitter

| Key         | Mode  | Description                           | Source           |
| :---------- | :---- | :------------------------------------ | :--------------- |
| `<Enter>`   | `n`   | Incremental Selection Init/Increase   | `treesitter.lua` |
| `<Backspace>`| `n`   | Incremental Selection Decrease        | `treesitter.lua` |
| `<leader>a` | `n`   | Swap with Next Parameter             | `treesitter.lua` |
| `<leader>A` | `n`   | Swap with Previous Parameter         | `treesitter.lua` |
| `af`        | `o,x` | Select Outer Function                 | `treesitter.lua` |
| `if`        | `o,x` | Select Inner Function                 | `treesitter.lua` |
| `ac`        | `o,x` | Select Outer Class                    | `treesitter.lua` |
| `ic`        | `o,x` | Select Inner Class                    | `treesitter.lua` |
| `ao`        | `o,x` | Select Outer Comment                  | `treesitter.lua` |
| `as`        | `o,x` | Select Scope                          | `treesitter.lua` |

### ✨ Completion Engine (`blink.nvim`)

| Key       | Mode | Description                      | Source      |
| :-------- | :--- | :------------------------------- | :---------- |
| `<C-CR>`  | `i`  | Accept Suggestion or Fallback    | `blink.lua` |

### 📑 Buffer Management (`barbar.nvim`)

| Key             | Mode | Description                         | Source      |
| :-------------- | :--- | :---------------------------------- | :---------- |
| `<A-,>`       | `n`  | Go to Previous Buffer               | `barbar.lua`|
| `<A-.>`       | `n`  | Go to Next Buffer                   | `barbar.lua`|
| `<A-S-,>`     | `n`  | Move Current Buffer to Previous     | `barbar.lua`|
| `<A-S-.>`     | `n`  | Move Current Buffer to Next         | `barbar.lua`|
| `<A-1>`–`<A-9>`| `n`  | Go to Buffer 1–9                    | `barbar.lua`|
| `<A-0>`       | `n`  | Go to Last Buffer                   | `barbar.lua`|
| `<A-p>`       | `n`  | Pin/Unpin Current Buffer            | `barbar.lua`|
| `<leader>bc`  | `n`  | Close Current Buffer                | `barbar.lua`|
| `<leader>bo`  | `n`  | Close All But Current/Pinned Buffers| `barbar.lua`|

### 🪟 Window Management

| Key         | Mode | Description             | Source      |
| :---------- | :--- | :---------------------- | :---------- |
| `sh`        | `n`  | Split Horizontally      | `keymaps.lua`|
| `sv`        | `n`  | Split Vertically        | `keymaps.lua`|
| `<leader>se`| `n`  | Equalize Window Sizes   | `keymaps.lua`|
| `<leader>sx`| `n`  | Close Current Split     | `keymaps.lua`|
| `<C-Up>`    | `n`  | Resize Split Up         | `keymaps.lua`|
| `<C-Down>`  | `n`  | Resize Split Down       | `keymaps.lua`|
| `<C-Left>`  | `n`  | Resize Split Left       | `keymaps.lua`|
| `<C-Right>` | `n`  | Resize Split Right      | `keymaps.lua`|

### 📚 Git Operations

| Key       | Mode | Description             | Source      |
| :-------- | :--- | :---------------------- | :---------- |
| `<leader>gs`| `n`  | Git Status (Snacks)     | `snacks.lua`|
| `<leader>gb`| `n`  | Git Branches (Snacks)   | `snacks.lua`|
| `<leader>gl`| `n`  | Git Log (Snacks)        | `snacks.lua`|
| `<leader>gL`| `n`  | Git Log Line (Snacks)   | `snacks.lua`|
| `<leader>gd`| `n`  | Git Diff Hunks (Snacks) | `snacks.lua`|
| `<leader>gf`| `n`  | Git Log File (Snacks)   | `snacks.lua`|
| `<leader>gS`| `n`  | Git Stash (Snacks)      | `snacks.lua`|
| `<leader>gB`| `n,v`| Git Browse (Snacks)     | `snacks.lua`|
| `<leader>gg`| `n`  | Open Lazygit (Snacks)   | `snacks.lua`|
| `<leader>gn`| `n`  | Open Neogit             | `neogit.lua`|
| _(Neogit)_ | `n`  | _(Use `:Neogit`)_       | `neogit.lua`|

### 💻 Terminal

| Key             | Mode | Description                      | Source              |
| :-------------- | :--- | :------------------------------- | :------------------ |
| `<C-\>`         | `n`  | Toggle Terminal (ToggleTerm)     | `toggle-terminal.lua` |
| `<leader>tt`    | `n`  | Toggle Terminal (Floating)       | `toggle-terminal.lua` |
| `<leader>th`    | `n`  | Toggle Terminal (Horizontal Split)| `toggle-terminal.lua` |
| `<leader>tv`    | `n`  | Toggle Terminal (Vertical Split)  | `toggle-terminal.lua` |
| `<leader>tl`    | `n`  | Send Line to Terminal            | `toggle-terminal.lua` |
| `<leader>ts`    | `n`  | Select Terminal                  | `toggle-terminal.lua` |

### 🔧 UI Toggles & Settings (Snacks & Markdown)

| Key       | Mode | Description                   | Source      |
| :-------- | :--- | :---------------------------- | :---------- |
| `<leader>us`| `n`  | Toggle Spelling                 | `snacks.lua`   |
| `<leader>uw`| `n`  | Toggle Wrap                     | `snacks.lua`   |
| `<leader>uL`| `n`  | Toggle Relative Number          | `snacks.lua`   |
| `<leader>ud`| `n`  | Toggle Diagnostics              | `snacks.lua`   |
| `<leader>ul`| `n`  | Toggle Line Number              | `snacks.lua`   |
| `<leader>uc`| `n`  | Toggle Conceal Level            | `snacks.lua`   |
| `<leader>uT`| `n`  | Toggle Treesitter               | `snacks.lua`   |
| `<leader>ub`| `n`  | Toggle Dark Background          | `snacks.lua`   |
| `<leader>uh`| `n`  | Toggle Inlay Hints              | `snacks.lua`   |
| `<leader>uD`| `n`  | Toggle Dim Mode                 | `snacks.lua`   |
| `<leader>un`| `n`  | Dismiss Notifications           | `snacks.lua`   |
| `<leader>Mm`| `n`  | Toggle Markdown Render          | `markdown.lua` |
| `<leader>Me`| `n`  | Expand Markdown View            | `markdown.lua` |
| `<leader>Mc`| `n`  | Contract Markdown View          | `markdown.lua` |
| `<leader>ML`| `n`  | Open Markdown Log               | `markdown.lua` |
| `<leader>Md`| `n`  | Debug Markdown Line             | `markdown.lua` |
| `<leader>Ms`| `n`  | Show Markdown Configuration     | `markdown.lua` |

### 🧘 Focus Modes (Snacks)

| Key       | Mode | Description     | Source      |
| :-------- | :--- | :-------------- | :---------- |
| `<leader>z`| `n`  | Toggle Zen Mode | `snacks.lua`|
| `<leader>Z`| `n`  | Toggle Zoom   | `snacks.lua`|

### 📝 Session Management (`mini.sessions`)

| Key       | Mode | Description         | Source    |
| :-------- | :--- | :------------------ | :---------- |
| `<leader>ms`| `n`  | Write Session       | `mini.lua`  |
| `<leader>mr`| `n`  | Read Last Session   | `mini.lua`  |
| `<leader>md`| `n`  | Delete Last Session | `mini.lua`  |

### 📋 Miscellaneous

| Key       | Mode | Description                       | Source      |
| :-------- | :--- | :-------------------------------- | :---------- |
| `<leader>.`| `n`  | Toggle Scratch Buffer (Snacks)    | `snacks.lua`|
| `<leader>S`| `n`  | Select Scratch Buffer (Snacks)    | `snacks.lua`|
| `<leader>:`| `n`  | Command History (Snacks)          | `snacks.lua`|
| `<leader>n`| `n`  | Notification History (Snacks)     | `snacks.lua`|
| `<leader>fh`| `n`  | Helptags (FZF)                    | `fzf-mini.lua` |
| `<leader>fk`| `n`  | Keymaps (FZF)                     | `fzf-mini.lua` |
| `<leader>fb`| `n`  | Builtins/Commands (FZF)           | `fzf-mini.lua` |

### 🐹 Go Operations

| Key       | Mode | Description                   | Source    |
| :-------- | :--- | :---------------------------- | :-------- |
| `<leader>ga`| `n`  | Alternate File                | `go.lua`  |
| `<leader>gv`| `n`  | Alternate Vertical Split      | `go.lua`  |
| `<leader>gs`| `n`  | Alternate Horizontal Split    | `go.lua`  |
| `<leader>oi`| `n`  | Go Imports (Organize)         | `go.lua`  |
| `<leader>of`| `n`  | Go Format                     | `go.lua`  |
| `<leader>ot`| `n`  | Go Mod Tidy                   | `go.lua`  |
| `<leader>oc`| `n`  | Generate Comment Stub         | `go.lua`  |
| `<leader>os`| `n`  | Fill Struct                   | `go.lua`  |
| `<leader>or`| `n`  | Generate Return Values        | `go.lua`  |
| `<leader>oj`| `n`  | JSON to Struct                | `go.lua`  |
| `<leader>oa`| `n`  | Add Struct Tag                | `go.lua`  |
| `<leader>od`| `n`  | Remove Struct Tag             | `go.lua`  |
| `<leader>ol`| `n`  | Go Lint                       | `go.lua`  |
| `<leader>og`| `n`  | Go Generate                   | `go.lua`  |
| `<leader>bb`| `n`  | Build Package                 | `go.lua`  |
| `<leader>br`| `n`  | Run Package                   | `go.lua`  |
| `<leader>tp`| `n`  | Test Package                  | `go.lua`  |
| `<leader>tf`| `n`  | Test Function (Nearest)       | `go.lua`  |
| `<leader>tF`| `n`  | Test File                     | `go.lua`  |
| `<leader>tc`| `n`  | Test Coverage (Package)       | `go.lua`  |
| `<leader>tC`| `n`  | Toggle Coverage Display       | `go.lua`  |
| `<leader>gh`| `n`  | Hover Doc Popup               | `go.lua`  |
| `<leader>gi`| `n`  | Implement Interface           | `go.lua`  |
| `<leader>gm`| `n`  | Generate Mocks                | `go.lua`  |

### 🐹 Go Operations (Debugging)

| Key         | Mode | Description                         | Source    |
| :---------- | :--- | :---------------------------------- | :-------- |
| `<leader>dgd`| `n`  | Debug Continue (Auto Detect)        | `go.lua`  |
| `<leader>dgt`| `n`  | Debug Step Over                   | `go.lua`  |
| `<leader>dgi`| `n`  | Debug Step Into                   | `go.lua`  |
| `<leader>dgo`| `n`  | Debug Step Out                    | `go.lua`  |
| `<leader>dgb`| `n`  | Debug Toggle Breakpoint             | `go.lua`  |
| `<leader>dgx`| `n`  | Debug Stop                        | `go.lua`  |
| `<leader>drs`| `n`  | Debug REPL Open                   | `go.lua`  |
| `<leader>drr`| `n`  | Debug Run (Start)                 | `go.lua`  |
| `<leader>dra`| `n`  | Debug Attach                      | `go.lua`  |

### 🗄️ Database (Dadbod) Shortcuts

| Key       | Mode | Description         | Source      |
| :-------- | :--- | :------------------ | :---------- |
| `<leader>du`| `n`  | Toggle DB UI        | `dadbod.lua`|
| `<leader>dr`| `n`  | Find DB Buffer      | `dadbod.lua`|
| `<leader>da`| `n`  | Add DB Connection   | `dadbod.lua`|
| `<leader>dc`| `n`  | Close DB UI         | `dadbod.lua`|
| `<leader>do`| `n`  | Open DB UI          | `dadbod.lua`|

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
- **Other**: vim-sleuth

## 💡 Customization

- **Plugins**: Introduce new plugins by creating `.lua` files within the `lua/plugins/` directory.
- **Keymaps**: Modify core keybindings in `lua/config/keymaps.lua` or plugin-specific mappings in their respective files under `lua/plugins/`.
- **Options**: Adjust fundamental editor settings within `lua/config/options.lua`.
- **Theme**: Fine-tune theme preferences in `lua/plugins/github-theme.lua`.
- **LSP Servers**: Add or remove Language Servers within the `servers` table located in `lua/plugins/lsp.lua`. Mason will handle their installation via `mason-lspconfig` and `mason-tool-installer`.
- **Formatters**: Configure code formatters within `lua/plugins/conform.lua`. Ensure these formatters are also listed in `ensure_installed` within `lua/plugins/lsp.lua` for Mason to manage their installation.
- **Markdown Rendering**: Customize the appearance and behavior of Markdown rendering in `lua/plugins/markdown.lua`.
- **Snacks Startup**: To potentially optimize startup time, consider disabling unused modules by setting `enabled = false` within the `opts` table in `lua/plugins/snacks.lua`.

## 📚 Further Reading

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [Snacks.nvim Documentation](https://github.com/folke/snacks.nvim)
- [Blink.cmp Documentation](https://github.com/saghen/blink.cmp)
- [render-markdown.nvim Documentation](https://github.com/MeanderingProgrammer/render-markdown.nvim)


