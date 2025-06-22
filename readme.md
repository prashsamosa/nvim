Markdown

# 🚀 Neovim Configuration

Welcome to this comprehensive Neovim configuration! This setup is designed to provide a powerful, efficient, and aesthetically pleasing development environment. It leverages a modern plugin ecosystem to enhance various aspects of coding, from intelligent completion and formatting to robust debugging and Git integration.

## 📦 Prerequisites

Before diving in, ensure you have the following tools installed on your system:

### 🔧 Core Requirements

* **Neovim** (v0.10.0 or later): The editor itself.

* **Git**: For version control and plugin management.

* **Node.js** (v18+): Essential for many Language Servers (LSPs) and debugging adapters.

* **Nerd Font**: A patched font (e.g., JetBrains Mono Nerd Font) is highly recommended for proper display of icons and glyphs.

### 🔍 Essential CLI Tools

These tools enhance fuzzy finding, code searching, and other functionalities:

```bash
# For Debian/Ubuntu
sudo apt install ripgrep fd-find

# For macOS (using Homebrew)
brew install ripgrep fd
🐹 Go Development Toolchain
If you plan to develop in Go, install these binaries:

Bash

go install golang.org/x/tools/gopls@latest
go install [github.com/go-delve/delve/cmd/dlv@latest](https://github.com/go-delve/delve/cmd/dlv@latest)
go install [github.com/golangci/golangci-lint/cmd/golangci-lint@latest](https://github.com/golangci/golangci-lint/cmd/golangci-lint@latest)
🧠 JavaScript / TypeScript Development
For JavaScript and TypeScript LSP functionality:

Bash

npm install -g js-debug-adapter
🐍 Python Development
For Python LSP and debugging:

Bash

pip install debugpy pylatexenc
✨ Optional Enhancements
stylua: Lua formatter (often auto-installed by Mason).

lazygit: A fantastic terminal UI for Git.

rust: Optional, but highly recommended for faster fzf-lua performance.

🛠 First Launch & Post-Installation
This configuration uses Lazy.nvim for plugin management, Mason.nvim for LSP servers and formatters, and nvim-treesitter for syntax parsing. Most installations will happen automatically on the first launch.

Clone the repository:
Bash

git clone <your-config-repo-url> ~/.config/nvim
Launch Neovim:
Bash

nvim
Lazy.nvim will automatically bootstrap itself and install all specified plugins.
Mason will then install all configured Language Servers and development tools.
Treesitter will compile necessary parsers for syntax highlighting and text objects.
Verify Setup: After the initial setup, run :checkhealth within Neovim to ensure all components are working correctly.
🔄 Manual Post-Installation Commands (If needed)
Sometimes, manual updates or installations might be required:

Vim Script

:TSUpdate              " Update Treesitter parsers
:MasonInstallAll       " Install all Mason-managed tools
:GoInstallBinaries     " Install/update Go binaries (if go.nvim is active)
🔌 Plugin Architecture & Key Features
This configuration is built around a modular plugin structure, each contributing to a streamlined development workflow.

Core Plugin Stack
Lazy.nvim: The backbone of plugin management, ensuring efficient and lazy loading of components.

github-nvim-theme: Provides a consistent dark theme across Neovim's UI, including various plugin integrations.

nvim-lualine/lualine.nvim: Configures a clean and informative statusline, displaying vital information like Git branch, LSP diagnostics, and file details.

folke/which-key.nvim: Helps you explore and remember keybindings by showing a popup of available commands after pressing the <leader> key.

echasnovski/mini.nvim: A collection of small, efficient, and well-integrated plugins providing functionalities like session management, indentation scopes, smart commenting, enhanced text objects, and more.

Language Server Protocol (LSP) & Completion
neovim/nvim-lspconfig: Manages the integration with various Language Servers, providing features like intelligent code completion, go-to-definition, references, and diagnostics.

williamboman/mason.nvim & mason-lspconfig.nvim: Simplifies the installation and management of LSP servers, formatters, and linters.

saghen/blink.cmp: The primary completion engine, integrating with LSP, snippets, buffer words, and specialized sources like emoji and SQL. It intelligently adapts LSP capabilities for a richer experience.

ray-x/go.nvim: A dedicated plugin for Go development, tightly integrated with gopls for LSP features, testing, building, and code generation utilities.

b0o/schemastore.nvim: Provides JSON and YAML schema validation and completion through LSP.

File & Buffer Management
nvim-tree/nvim-tree.lua: A sidebar file explorer providing a traditional tree view, Git status indicators, and file icons.

stevearc/oil.nvim: Offers a buffer-based file explorer for quick navigation and file operations within the current window.

romgrk/barbar.nvim: An enhanced bufferline that displays open buffers as tabs, with file icons and Git status, allowing quick navigation between them.

Version Control
NeogitOrg/neogit: A comprehensive Git client for Neovim, enabling staging, committing, branching, and other Git operations from within the editor, integrated with diffview.nvim and nvim-telescope/telescope.nvim.

lewis6991/gitsigns.nvim: Provides visual Git status indicators (added, modified, deleted lines) directly in the Neovim gutter.

Debugging
mfussenegger/nvim-dap: The Debug Adapter Protocol client, enabling powerful debugging capabilities for various languages.

rcarriga/nvim-dap-ui: Provides a beautiful and functional UI for nvim-dap, displaying variables, call stacks, and breakpoints.

leoluz/nvim-dap-go: The Go-specific debug adapter for nvim-dap.

theHamsta/nvim-dap-virtual-text: Shows variable values inline as virtual text during debugging sessions.

Utilities & Enhancements
ibhagwan/fzf-lua: A fast and efficient fuzzy finder used extensively for file searching, live grep, LSP symbol lookups, and more.

stevearc/conform.nvim: Configures automatic code formatting on save for various programming languages.

echasnovski/mini.comment: Provides smart line and block commenting.

echasnovski/mini.ai & mini.surround: Enhanced text objects and tools for manipulating surrounding characters (e.g., changing quotes).

folke/snacks.nvim: A collection of small, useful utilities, including a powerful notification system, Zen mode, quick scratch buffers, and buffer management functions.

folke/todo-comments.nvim: Highlights TODO, FIXME, and other actionable comments in your code, helping you track tasks.

akinsho/toggleterm.nvim: Allows for seamless creation and management of floating, horizontal, or vertical terminals.

kristijanhusak/vim-dadbod-ui: Provides a UI for interacting with databases, alongside vim-dadbod for database connections and vim-dadbod-completion for SQL completion.

tpope/vim-sleuth: Automatically detects indentation settings.

nvzone/typr: A plugin for practicing typing.

typed-rocks/witt-neovim: Likely provides specialized text manipulation or smart features.

⌨️ Keybindings Overview
Leader key: <Space>

This section provides a detailed overview of the most commonly used keybindings. Pay close attention to the resolved conflicts mentioned below.

⚠️ Resolved Conflicts
Here are the keybinding conflicts identified and how they have been resolved in this configuration:

Debug: Start/Continue vs. Close DB UI:

Original Conflict: Both nvim-dap and vim-dadbod-ui attempted to use <leader>Dc.
Resolution: The debug functionality (DAP) is prioritized for <leader>Dc. The vim-dadbod-ui "Close DB UI" action has been remapped to <leader>DCc to ensure no conflict.
File/Grep Pickers (fzf-lua vs. snacks.nvim):

Original Conflict: Both fzf-lua and snacks.nvim attempted to use <leader>ff (Find Files) and <leader>fg (Live Grep).
Resolution: This configuration prioritizes and extensively uses fzf-lua for fuzzy finding due to its deep integration with LSP and other features. The conflicting snacks.nvim mappings for <leader>ff and <leader>fg are superseded. Use the fzf-lua bindings as listed below for reliable fuzzy finding. If you specifically need snacks.nvim's pickers, you will need to assign them unique keybindings yourself.
🌟 General & Essential Shortcuts
| Key | Mode | Description | Source File |
| :-- | :--- | :---------- | :---------- |
| jk | i | Exit Insert Mode | keymaps.lua |
| <leader>nh | n | Clear Search Highlights | keymaps.lua |
| <leader><space> | n | Fuzzy Find Files (via fzf-lua if Snacks not loaded) | keymaps.lua |
| <leader>+ | n | Increment Number | keymaps.lua |
| <C-a> | n | Select All | keymaps.lua |
| <leader>y | n | Yank to System Clipboard | (Assumed via clipboard=unnamedplus) |
| <leader>p | n | Paste from System Clipboard | (Assumed via clipboard=unnamedplus) |
| <leader>L | n | Open Lazy Plugin Manager | lazy.lua |
| <leader>, | n | Switch Buffers | barbar.lua / lualine.lua (context dependent) |
| <leader>: | n | Command History | (Standard Neovim) |

🧭 Navigation & Fuzzy Finding (fzf-lua)
| Key | Mode | Action | Source File |
| :-- | :--- | :----- | :---------- |
| <leader>ff | n | Find Files | fzf-mini.lua |
| <leader>fc | n | Find in Config Directory | fzf-mini.lua |
| <leader>fg | n | Live Grep (search content) | fzf-mini.lua |
| <leader>f/ | n | Grep Current Buffer | fzf-mini.lua |
| <leader>fo | n | Open Old (recent) Files | fzf-mini.lua |
| <leader>f<space> | n | Buffers (list open buffers) | fzf-mini.lua |
| <leader>fb | n | Builtins/Commands (search commands) | fzf-mini.lua |
| <leader>fw | n | Find Word Under Cursor | fzf-mini.lua |
| <leader>fW | n | Find WORD Under Cursor | fzf-mini.lua |
| <leader>fh | n | Helptags (search help docs) | fzf-mini.lua |
| <leader>fk | n | Keymaps (search keybindings) | fzf-mini.lua |
| <leader>fd | n | Diagnostics (document) | fzf-mini.lua |
| <leader>fr | n | Resume Last Search | fzf-mini.lua |
| <leader>mp | n | Mini Pick Files | mini.lua |
| <leader>mg | n | Mini Grep Live | mini.lua |
| <leader>wn | n,t | Next Word Reference | snacks.lua |
| <leader>wp | n,t | Previous Word Reference | snacks.lua |

📂 File Explorers
nvim-tree.lua: Your primary tree-style file explorer.

oil.lua: Provides a buffer-style file explorer.

Recommendation: If you prefer nvim-tree.lua as your main file explorer, you might consider setting default_file_explorer = false in your oil.lua config to avoid potential conflicts with netrw hijacking or unexpected behavior, keeping oil for its unique floating file manager (- key).
| Key | Mode | Action | Source File |
| :-- | :--- | :----- | :---------- |
| <leader>e | n | Toggle File Explorer (NvimTree) | nvim-tree.lua |
| - | n | Open File Manager (floating Oil) | oil.lua |

🗂 Buffer Management (barbar.nvim)
| Key | Mode | Action | Source File |
| :-- | :--- | :----- | :---------- |
| <A-,> | n | Previous Buffer | barbar.lua |
| <A-.> | n | Next Buffer | barbar.lua |
| <A-S-,> | n | Move Buffer Left | barbar.lua |
| <A-S-.> | n | Move Buffer Right | barbar.lua |
| <A-1>–<A-9> | n | Jump to Buffer 1–9 | barbar.lua |
| <A-0> | n | Jump to Last Buffer | barbar.lua |
| <leader>bc | n | Close Current Buffer (Barbar) | barbar.lua |
| <leader>bo | n | Close All But Current/Pinned (Barbar) | barbar.lua |
| <leader>bd | n | Delete Buffer (Snacks) | snacks.lua |
| <leader>ba | n | Delete All Buffers (Snacks) | snacks.lua |
| <leader>bo | n | Delete Other Buffers (Snacks) | snacks.lua |

⚙️ LSP & Code Actions
| Key | Mode | Action | Source File |
| :-- | :--- | :----- | :---------- |
| gd | n | Go to Definition | lsp.lua (via fzf-lua) |
| gD | n | Go to Declaration | lsp.lua |
| gr | n | Go to References | lsp.lua (via fzf-lua) |
| gI | n | Go to Implementation | lsp.lua (via fzf-lua) |
| <leader>td | n | Type Definition | lsp.lua (via fzf-lua) |
| <leader>ca | n, x | Code Action | keymaps.lua / lsp.lua |
| <leader>cr | n | Rename Symbol | keymaps.lua / lsp.lua |
| K | n | Hover Documentation | lsp.lua |
| <S-k> | n | Hover Info | keymaps.lua |
| <C-k> | i | Signature Help | lsp.lua |
| <leader>ds | n | Document Symbols | lsp.lua (via fzf-lua) |
| <leader>ws | n | Workspace Symbols | lsp.lua (via fzf-lua) |
| <leader>ih | n | Toggle Inlay Hints | lsp.lua |
| <leader>cl | n | Run Code Lens | lsp.lua |
| [d | n | Previous Diagnostic | lsp.lua |
| ]d | n | Next Diagnostic | lsp.lua |
| <leader>dl | n | Diagnostics List (Loclist) | lsp.lua |
| <leader>dq | n | Diagnostics Quickfix | lsp.lua |

🪟 Window Management
| Key | Mode | Action | Source File |
| :-- | :--- | :----- | :---------- |
| <C-h> | n | Move to Left Window | keymaps.lua |
| <C-j> | n | Move to Lower Window | keymaps.lua |
| <C-k> | n | Move to Upper Window | keymaps.lua |
| <C-l> | n | Move to Right Window | keymaps.lua |
| sh | n | Horizontal Split | keymaps.lua |
| sv | n | Vertical Split | keymaps.lua |
| <leader>z | n | Toggle Zen Mode | snacks.lua |
| <leader>Z | n | Zoom Current Window | snacks.lua |

📚 Git Operations
| Key | Mode | Description | Source File |
| :-- | :--- | :---------- | :---------- |
| <leader>gn | n | Open Neogit (Git UI) | neogit.lua |
| <leader>gs | n | Git Status | (Implicitly via Neogit) |
| <leader>gb | n | Git Branches | (Implicitly via Neogit) |
| <leader>gl | n | Git Log | (Implicitly via Neogit) |
| <leader>gL | n | Git Log Line | (Implicitly via Neogit) |
| <leader>gd | n | Git Diff | (Implicitly via Neogit) |
| <leader>gf | n | Git Log File | (Implicitly via Neogit) |
| <leader>gS | n | Git Stash | (Implicitly via Neogit) |
| <leader>gB | n,v | Git Browse | (Implicitly via Neogit) |
| <leader>gg | n | Open Lazygit | (Implicitly via Neogit) |

🧪 Debugging (DAP)
| Key | Mode | Action | Source File |
| :-- | :--- | :----- | :---------- |
| <leader>Dc | n | Debug: Start/Continue | dap.lua |
| <leader>Dsi | n | Debug: Step Into | dap.lua |
| <leader>DsO | n | Debug: Step Over | dap.lua |
| <leader>Dso | n | Debug: Step Out | dap.lua |
| <leader>Db | n | Debug: Toggle Breakpoint | dap.lua |
| <leader>DB | n | Debug: Set Conditional Breakpoint | dap.lua |
| <leader>Dt | n | Debug: Toggle UI | dap.lua |
| <leader>Dl | n | Debug: Run Last Configuration | dap.lua |

💻 Terminal (toggleterm.nvim)
| Key | Mode | Action | Source File |
| :-- | :--- | :----- | :---------- |
| <C-\> | n | Toggle Terminal | toggle-terminal.lua |
| <leader>tt | n | Toggle Terminal (Floating) | toggle-terminal.lua |
| <leader>th | n | Toggle Terminal (Horizontal)|toggle-terminal.lua| |&lt;leader>tv|n| Toggle Terminal (Vertical) |toggle-terminal.lua| |&lt;leader>tl|n| Send Line to Terminal |toggle-terminal.lua| |&lt;leader>ts|n| Select Terminal |toggle-terminal.lua` |

🗄️ Database Operations (vim-dadbod-ui)
| Key | Mode | Action | Source File |
| :-- | :--- | :----- | :---------- |
| <leader>Do | n | Open DB UI | dadbod.lua |
| <leader>Du | n | Toggle DB UI | dadbod.lua |
| <leader>DCc | n | Close DB UI | dadbod.lua (Remapped) |
| <leader>Dr | n | Find DB Buffer | dadbod.lua |
| <leader>Da | n | Add DB Connection | dadbod.lua |

🐹 Go Development (go.nvim)
| Key | Mode | Description | Source File |
| :-- | :--- | :---------- | :---------- |
| <leader>ga | n | Alternate File | go.lua |
| <leader>gvs | n | Alternate Vertical Split | go.lua |
| <leader>ghs | n | Alternate Horizontal Split | go.lua |
| <leader>gx | n | Run Current File | go.lua |
| <leader>oi | n | Organize Imports | go.lua |
| <leader>ot | n | Go Mod Tidy | go.lua |
| <leader>bb | n | Build Package | go.lua |
| <leader>br | n | Run Package | go.lua |
| <leader>tp / tf / tF | n | Test Package / Func / File | go.lua |
| <leader>tc | n | Show Test Coverage | go.lua |
| <leader>tC | n | Toggle Test Coverage | go.lua |
| <leader>gta / gtr | n | Add / Remove Struct Tags | go.lua |
| <leader>gat / get | n | Add / Add Example Test | go.lua |
| <leader>gc | n | Generate Comment | go.lua |
| <leader>gs | n | Fill Struct | go.lua |
| <leader>gr | n | Generate Return | go.lua |
| <leader>gj | n | JSON to Struct | go.lua |
| <leader>gI | n | Implement Interface | go.lua |
| <leader>gG | n | Run Go Generate | go.lua |
| <leader>gm | n | Generate Mocks | go.lua |
| <leader>gL | n | Run Go Lint | go.lua |
| <leader>gV | n | Run Go Vet | go.lua |
| <leader>gD | n | Go Doc (in Neovim) | go.lua |
| <leader>gDb | n | Go Doc Browser | go.lua |
| <leader>gcb | n | Coverage Browser | go.lua |

🔧 Mini Plugins
| Key | Mode | Description | Source File |
| :-- | :--- | :---------- | :---------- |
| gcc | n | Comment Line | mini.lua |
| gc | v | Comment Selection | mini.lua |
| sa | n | Surround Add | mini.lua |
| sd | n | Surround Delete | mini.lua |
| sr | n | Surround Replace | mini.lua |
| <leader>ms | n | Write Session | mini.lua |
| <leader>mr | n | Read Last Session | mini.lua |
| <leader>md | n | Delete Session | mini.lua |

🌳 Treesitter Navigation
| Key | Mode | Description | Source File |
| :-- | :--- | :---------- | :---------- |
| [m | n | Previous Function Start | treesitter.lua |
| ]m | n | Next Function Start | treesitter.lua |
| [M | n | Previous Function End | treesitter.lua |
| ]M | n | Next Function End | treesitter.lua |
| [c | n | Previous Class Start | treesitter.lua |
| ]c | n | Next Class Start | treesitter.lua |
| [C | n | Previous Class End | treesitter.lua |
| ]C | n | Next Class End | treesitter.lua |
| <Enter> | n | Treesitter Incremental Selection (init/node) | treesitter.lua |
| <S-Enter> | n | Treesitter Scope Incremental Selection | treesitter.lua |
| <BS> | n | Treesitter Node Decremental Selection | treesitter.lua |
| <leader>a | n | Swap Next Parameter | treesitter.lua |
| <leader>A | n | Swap Previous Parameter | treesitter.lua |

🎛 Toggle Options (snacks.nvim)
| Key | Mode | Description | Source File |
| :-- | :--- | :---------- | :---------- |
| <leader>us | n | Toggle Spelling | snacks.lua |
| <leader>uw | n | Toggle Wrap | snacks.lua |
| <leader>uL | n | Toggle Relative Number | snacks.lua |
| <leader>ud | n | Toggle Diagnostics | snacks.lua |
| <leader>ul | n | Toggle Line Number | snacks.lua |
| <leader>uc | n | Toggle Conceal | snacks.lua |
| <leader>uT | n | Toggle Treesitter | snacks.lua |
| <leader>ub | n | Toggle Background (dark/light) | snacks.lua |
| <leader>uh | n | Toggle Inlay Hints | snacks.lua |
| <leader>uD | n | Toggle Dim | snacks.lua |

📑 Miscellaneous Utilities
| Key | Mode | Action | Source File |
| :-- | :--- | :----- | :---------- |
| <leader>. | n | Scratch Buffer | snacks.lua |
| <leader>S | n | Select Scratch | snacks.lua |
| <leader>un | n | Hide Notifications | snacks.lua |
| <leader>rf | n | Rename File | snacks.lua |
| <leader>Mm | n | Markdown: Toggle Render | markdown.lua |
| <leader>Me | n | Markdown: Expand View | markdown.lua |
| <leader>Mc | n | Markdown: Contract View | markdown.lua |
| <leader>ML | n | Markdown: Open Log | markdown.lua |
| <leader>Md | n | Markdown: Debug Line | markdown.lua |
| <leader>Ms | n | Markdown: Show Config | markdown.lua |

💡 Troubleshooting & Common Adjustments
Here are some tips for maintaining and customizing your configuration:

Keybinding Conflicts: If you encounter unexpected behavior when pressing a key combination, refer to the "Resolved Conflicts" section above. If a new conflict arises, use :verbose map <keybinding> to see which plugin or file defines the problematic mapping. Then, either remove or remap one of the conflicting actions in its respective configuration file.

File Explorer Preference: You have both nvim-tree.lua (sidebar) and oil.lua (buffer-based) configured. If you find one interfering with the other or prefer one exclusively, consider:

For nvim-tree as primary: Ensure oil.lua's default_file_explorer = true is either removed or set to false if it causes issues.

For oil as primary: You might want to disable nvim-tree by commenting it out in your lazy.lua spec.

Icon Display Inconsistencies: While nvim-tree/nvim-web-devicons is widely used, echasnovski/mini.icons is also present. If you notice any missing or incorrect icons, try temporarily disabling mini.icons in mini.lua to see if it resolves the issue.

Indentation Issues: Tree-sitter provides intelligent indentation. If you experience incorrect indentation for a specific file type, check:

If the language parser is installed for Treesitter (:TSInstall <language>).

The indent = { enable = true } setting in treesitter.lua.

The global vim.opt settings in options.lua.

If vim-sleuth is causing issues, you might need to adjust its behavior or disable it for problematic file types.

👋 Contribution
Feel free to open issues or pull requests if you have suggestions for improvements, bug fixes, or new features.
