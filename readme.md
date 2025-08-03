# My Neovim Configuration

## ⌨️ Keybindings

`<Space>` is used as the leader key (`<leader>`).

---

### General

| Key                | Action                                | Plugin/Feature |
| :----------------- | :------------------------------------ | :------------- |
| `<leader>nh`       | Clear search highlights               | Global         |
| `jk` (Insert mode) | Exit Insert mode                      | Global         |
| `<leader>+`        | Increment number                      | Global         |
| `<leader>-`        | Decrement number                      | Global         |
| `<C-s>`            | Save file                             | Global         |
| `<leader>ur`       | Redraw / Clear hlsearch / Diff update | Global         |
| `]q`               | Next quickfix item                    | Global         |
| `[q`               | Previous quickfix item                | Global         |
| `]l`               | Next location list item               | Global         |
| `[l`               | Previous location list item           | Global         |
| `<leader>dl`       | Diagnostic loclist                    | Global         |
| `<leader>dq`       | Diagnostic quickfix                   | Global         |

---

### Window Management

| Key                                | Action                   | Plugin/Feature |
| :--------------------------------- | :----------------------- | :------------- |
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Navigate between windows | Global         |
| `sh`                               | Horizontal split         | Global         |
| `sv`                               | Vertical split           | Global         |
| `<Esc><Esc>` (Terminal mode)       | Exit Terminal mode       | Global         |

---

### Visual Mode Text Movement

| Key     | Action                                    | Plugin/Feature |
| :------ | :---------------------------------------- | :------------- |
| `J`     | Move selection down                       | Global         |
| `K`     | Move selection up                         | Global         |
| `<A-j>` | Move selection down (maintains selection) | Global         |
| `<A-k>` | Move selection up (maintains selection)   | Global         |
| `p`     | Paste without replacing clipboard         | Global         |

---

### Buffer Management (`barbar.nvim`, `snacks.nvim`)

| Key                | Action                               | Plugin/Feature            |
| :----------------- | :----------------------------------- | :------------------------ |
| `<A-,>`            | Previous buffer                      | `barbar.nvim`             |
| `<A-.>`            | Next buffer                          | `barbar.nvim`             |
| `<A-S-,>`          | Move buffer previous                 | `barbar.nvim`             |
| `<A-S-.>`          | Move buffer next                     | `barbar.nvim`             |
| `<A-1>` to `<A-9>` | Jump to buffer 1-9                   | `barbar.nvim`             |
| `<A-0>`            | Jump to last buffer                  | `barbar.nvim`             |
| `<A-p>`            | Pin/Unpin current buffer             | `barbar.nvim`             |
| `<leader>bO`       | Close all buffers but current/pinned | `barbar.nvim`             |
| `<leader>bc`       | Close/Delete current buffer          | `snacks.nvim`             |
| `<leader>ba`       | Delete All Buffers                   | `snacks.nvim`             |
| `<leader>bo`       | Delete Other Buffers                 | `snacks.nvim`             |
| `<leader>bl`       | Switch to last buffer                | `Snacks` (or `bprevious`) |

---

### File Explorer

| Key         | Action                        | Plugin/Feature |
| :---------- | :---------------------------- | :------------- |
| `-`         | Open Oil file manager (float) | `oil.nvim`     |
| `<leader>e` | Open Snacks Explorer          | `snacks.nvim`  |

---

### File & Search (`fzf-lua`, `grug-far.nvim`, `snacks.nvim`, `mini.pick`)

| Key               | Action                                    | Plugin/Feature     |
| :---------------- | :---------------------------------------- | :----------------- |
| `<leader><space>` | Find Files (Snacks picker / FZF fallback) | `Snacks`/`fzf-lua` |
| `<leader>ff`      | Find Files (FZF)                          | `fzf-lua`          |
| `<leader>fC`      | Find in Config files (FZF)                | `fzf-lua`          |
| `<leader>fg`      | Live Grep (FZF)                           | `fzf-lua`          |
| `<leader>f/`      | Grep Current Dir (FZF)                    | `fzf-lua`          |
| `<leader>fo`      | Recent Files (FZF)                        | `fzf-lua`          |
| `<leader>fb`      | Open Buffers (FZF)                        | `fzf-lua`          |
| `<leader>fc`      | Commands (FZF)                            | `fzf-lua`          |
| `<leader>fw`      | Find word under cursor (FZF)              | `fzf-lua`          |
| `<leader>fW`      | Find WORD under cursor (FZF)              | `fzf-lua`          |
| `<leader>fh`      | Help Tags (FZF)                           | `fzf-lua`          |
| `<leader>fk`      | Keymaps (FZF)                             | `fzf-lua`          |
| `<leader>fd`      | Document Diagnostics (FZF)                | `fzf-lua`          |
| `<leader>fr`      | Resume Last Search (FZF)                  | `fzf-lua`          |
| `<leader>mp`      | Pick files                                | `mini.pick`        |
| `<leader>mg`      | Grep live                                 | `mini.pick`        |
| `<leader>sr`      | Search & Replace                          | `grug-far.nvim`    |
| `<leader>sR`      | AST Search & Replace                      | `grug-far.nvim`    |
| `<leader>sw`      | Search Word Under Cursor                  | `grug-far.nvim`    |
| `<leader>sb`      | Search in Current Buffer                  | `grug-far.nvim`    |
| `<leader>sf`      | Search in Project Root                    | `grug-far.nvim`    |
| `<leader>sv`      | Search Visual Selection                   | `grug-far.nvim`    |
| `<leader>rf`      | Rename current file                       | `snacks.nvim`      |
| `<leader>wn`      | Next Word Reference                       | `snacks.nvim`      |
| `<leader>wp`      | Previous Word Reference                   | `snacks.nvim`      |

---

### Git (`snacks.nvim`)

| Key          | Action                       | Plugin/Feature |
| :----------- | :--------------------------- | :------------- |
| `<leader>Gb` | Git Blame Line               | `snacks.nvim`  |
| `<leader>GB` | Git Browse                   | `snacks.nvim`  |
| `<leader>Gf` | Lazygit Current File History | `snacks.nvim`  |
| `<leader>GG` | Open Lazygit                 | `snacks.nvim`  |
| `<leader>Gl` | Lazygit Log                  | `snacks.nvim`  |

---

### LSP (Language Server Protocol) Keymaps (Buffer-local - active when LSP attached)

| Key           | Action                            | Plugin/Feature   |
| :------------ | :-------------------------------- | :--------------- |
| `gd`          | Go to Definition                  | `nvim-lspconfig` |
| `<leader>ca`  | Code Action                       | `nvim-lspconfig` |
| `<leader>cr`  | Rename Symbol                     | `nvim-lspconfig` |
| `<leader>f`   | Format buffer                     | `conform.nvim`   |
| `<leader>fgd` | Go to Definition (FZF picker)     | `fzf-lua`        |
| `<leader>fgr` | Go to References (FZF picker)     | `fzf-lua`        |
| `<leader>fgi` | Go to Implementation (FZF picker) | `fzf-lua`        |
| `<leader>fgt` | Type Definition (FZF picker)      | `fzf-lua`        |
| `<leader>fds` | Document Symbols (FZF picker)     | `fzf-lua`        |
| `<leader>fws` | Workspace Symbols (FZF picker)    | `fzf-lua`        |

---

### Go Development (`go.nvim`)

| Key           | Action                                | Plugin/Feature |
| :------------ | :------------------------------------ | :------------- |
| `<leader>ga`  | Alternate file                        | `go.nvim`      |
| `<leader>gi`  | Organize imports                      | `go.nvim`      |
| `<leader>gm`  | Mod tidy                              | `go.nvim`      |
| `<leader>gs`  | Fill struct                           | `go.nvim`      |
| `<leader>gj`  | JSON → struct                         | `go.nvim`      |
| `<leader>gI`  | Implement interface                   | `go.nvim`      |
| `<leader>gTa` | Add tags                              | `go.nvim`      |
| `<leader>gTr` | Remove tags                           | `go.nvim`      |
| `<leader>gb`  | Build package                         | `go.nvim`      |
| `<leader>gx`  | Run current file                      | `go.nvim`      |
| `<leader>gta` | Test all                              | `go.nvim`      |
| `<leader>gtf` | Test function                         | `go.nvim`      |
| `<leader>gtp` | Test package                          | `go.nvim`      |
| `<leader>gat` | Add test                              | `go.nvim`      |
| `<leader>gtc` | Show coverage                         | `go.nvim`      |
| `<leader>gtC` | Toggle coverage                       | `go.nvim`      |
| `<leader>gv`  | Go vet                                | `go.nvim`      |
| `<leader>gD`  | Show documentation                    | `go.nvim`      |
| `<leader>gdt` | Debug test (requires `dap-go` loaded) | `go.nvim`      |

#### Go Custom Commands

| Command        | Action                                                            | Plugin/Feature |
| :------------- | :---------------------------------------------------------------- | :------------- |
| `:GoWorkspace` | Full project maintenance (`GoModTidy`, `GoImports`, `GoGenerate`) | `go.nvim`      |
| `:GoQuickTest` | Quick test (`GoTestPkg -short`)                                   | `go.nvim`      |
| `:GoBenchmark` | Benchmark (`GoTest -bench=.`)                                     | `go.nvim`      |

---

### Database (`vim-dadbod-ui`)

| Key                          | Action                    | Plugin/Feature  |
| :--------------------------- | :------------------------ | :-------------- |
| `<leader>Do`                 | Database: Open UI         | `vim-dadbod-ui` |
| `<leader>Du`                 | Database: Toggle UI       | `vim-dadbod-ui` |
| `<leader>Dc`                 | Database: Close UI        | `vim-dadbod-ui` |
| `<leader>Df`                 | Database: Find Buffer     | `vim-dadbod-ui` |
| `<leader>Da`                 | Database: Add Connection  | `vim-dadbod-ui` |
| `<leader>Dn`                 | Database: Rename Buffer   | `vim-dadbod-ui` |
| `<leader>Dl`                 | Database: Last Query Info | `vim-dadbod-ui` |
| `<leader>Dr` (Normal/Visual) | Execute Query / Selection | `vim-dadbod-ui` |
| `<leader>DS`                 | Save Query                | `vim-dadbod-ui` |

#### Database Custom Commands

| Command     | Action                    | Plugin/Feature  |
| :---------- | :------------------------ | :-------------- |
| `:DBStatus` | Show DB connection status | `vim-dadbod-ui` |

---

### Treesitter (`nvim-treesitter`)

| Key          | Action                              | Plugin/Feature    |
| :----------- | :---------------------------------- | :---------------- |
| `<Enter>`    | Incremental selection (init/expand) | `nvim-treesitter` |
| `<S-Enter>`  | Incremental selection (scope)       | `nvim-treesitter` |
| `<BS>`       | Incremental selection (decrease)    | `nvim-treesitter` |
| `af`         | Around function (text object)       | `nvim-treesitter` |
| `if`         | Inner function (text object)        | `nvim-treesitter` |
| `ac`         | Around class (text object)          | `nvim-treesitter` |
| `ic`         | Inner class (text object)           | `nvim-treesitter` |
| `aa`         | Around parameter (text object)      | `nvim-treesitter` |
| `ia`         | Inner parameter (text object)       | `nvim-treesitter` |
| `al`         | Around loop (text object)           | `nvim-treesitter` |
| `il`         | Inner loop (text object)            | `nvim-treesitter` |
| `at`         | Around comment (text object)        | `nvim-treesitter` |
| `it`         | Inner comment (text object)         | `nvim-treesitter` |
| `ad`         | Around conditional (text object)    | `nvim-treesitter` |
| `id`         | Inner conditional (text object)     | `nvim-treesitter` |
| `ab`         | Around block (text object)          | `nvim-treesitter` |
| `ib`         | Inner block (text object)           | `nvim-treesitter` |
| `a=`         | Around assignment (text object)     | `nvim-treesitter` |
| `i=`         | Inner assignment (text object)      | `nvim-treesitter` |
| `aq`         | Around call (text object)           | `nvim-treesitter` |
| `iq`         | Inner call (text object)            | `nvim-treesitter` |
| `]m`         | Next function start                 | `nvim-treesitter` |
| `[m`         | Previous function start             | `nvim-treesitter` |
| `]M`         | Next function end                   | `nvim-treesitter` |
| `[M`         | Previous function end               | `nvim-treesitter` |
| `]c`         | Next class start                    | `nvim-treesitter` |
| `[c`         | Previous class start                | `nvim-treesitter` |
| `]C`         | Next class end                      | `nvim-treesitter` |
| `[C`         | Previous class end                  | `nvim-treesitter` |
| `<leader>pa` | Swap next parameter                 | `nvim-treesitter` |
| `<leader>pA` | Swap previous parameter             | `nvim-treesitter` |
| `<leader>pf` | Peek definition code (function)     | `nvim-treesitter` |
| `<leader>pc` | Peek definition code (class)        | `nvim-treesitter` |

---

### Markdown (`render-markdown.nvim`)

| Key          | Action                      | Plugin/Feature         |
| :----------- | :-------------------------- | :--------------------- |
| `<leader>mt` | Toggle Markdown render      | `render-markdown.nvim` |
| `<leader>me` | Enable Markdown render      | `render-markdown.nvim` |
| `<leader>md` | Disable Markdown render     | `render-markdown.nvim` |
| `<leader>ml` | Show Markdown log           | `render-markdown.nvim` |
| `<leader>mD` | Debug current Markdown line | `render-markdown.nvim` |
| `<leader>mc` | Show Markdown config        | `render-markdown.nvim` |
| `<leader>mE` | Expand view                 | `render-markdown.nvim` |
| `<leader>mC` | Contract view               | `render-markdown.nvim` |

---

### Todo Comments (`todo-comments.nvim`)

| Key          | Action                   | Plugin/Feature       |
| :----------- | :----------------------- | :------------------- |
| `]t`         | Next TODO comment        | `todo-comments.nvim` |
| `[t`         | Previous TODO comment    | `todo-comments.nvim` |
| `<leader>st` | Search TODOs (Telescope) | `todo-comments.nvim` |

---

### Utility Toggles (`snacks.nvim`)

| Key          | Action                       | Plugin/Feature |
| :----------- | :--------------------------- | :------------- |
| `<leader>ul` | Toggle Line Numbers          | `snacks.nvim`  |
| `<leader>uL` | Toggle Relative Line Numbers | `snacks.nvim`  |
| `<leader>ud` | Toggle Diagnostics           | `snacks.nvim`  |
| `<leader>uc` | Toggle `conceallevel`        | `snacks.nvim`  |
| `<leader>uT` | Toggle Treesitter highlights | `snacks.nvim`  |
| `<leader>ub` | Toggle Dark/Light Background | `snacks.nvim`  |
| `<leader>uh` | Toggle LSP Inlay Hints       | `snacks.nvim`  |
| `<leader>uD` | Toggle Dim Mode              | `snacks.nvim`  |
| `<leader>un` | Hide Notifications           | `snacks.nvim`  |
| `<leader>uN` | Show Notification History    | `snacks.nvim`  |

---

### Zen Mode & Terminal (`snacks.nvim`)

| Key          | Action              | Plugin/Feature |
| :----------- | :------------------ | :------------- |
| `<leader>z`  | Toggle Zen Mode     | `snacks.nvim`  |
| `<leader>Z`  | Zoom Current Window | `snacks.nvim`  |
| `<leader>tt` | Open Terminal       | `snacks.nvim`  |
| `<c-t>`      | Toggle Terminal     | `snacks.nvim`  |
| `<leader>TT` | New Terminal        | `snacks.nvim`  |

---

### Scratch & Utility (`snacks.nvim`)

| Key         | Action                  | Plugin/Feature |
| :---------- | :---------------------- | :------------- |
| `<leader>.` | Scratch Buffer          | `snacks.nvim`  |
| `<leader>S` | Select Scratch Buffer   | `snacks.nvim`  |
| `<leader>,` | Buffers (Snacks Picker) | `snacks.nvim`  |
| `<leader>:` | Command History         | `snacks.nvim`  |
| `<leader>n` | Notification History    | `snacks.nvim`  |

---

### Debugging (`snacks.nvim`)

| Function  | Action           | Plugin/Feature |
| :-------- | :--------------- | :------------- |
| `dd(...)` | Inspect variable | `snacks.nvim`  |
| `bt()`    | Show backtrace   | `snacks.nvim`  |

---

### Commenting (`Comment.nvim`)

| Key                | Action                                                              | Plugin/Feature |
| :----------------- | :------------------------------------------------------------------ | :------------- |
| `gcc`              | Comment/Uncomment current line                                      | `Comment.nvim` |
| `gc[motion]`       | Comment/Uncomment using motion (e.g., `gcip` for paragraph)         | `Comment.nvim` |
| `gbc`              | Comment/Uncomment current block                                     | `Comment.nvim` |
| `gb[motion]`       | Comment/Uncomment block using motion (e.g., `gbiB` for inner block) | `Comment.nvim` |
| `gc` (Visual mode) | Toggle line comments for selected lines                             | `Comment.nvim` |
| `gb` (Visual mode) | Toggle block comments for selected lines/block                      | `Comment.nvim` |

---

### Mini.nvim Sessions (`mini.sessions`)

| Key          | Action            | Plugin/Feature  |
| :----------- | :---------------- | :-------------- |
| `<leader>Ms` | Write session     | `mini.sessions` |
| `<leader>Mr` | Read last session | `mini.sessions` |
| `<leader>Md` | Delete session    | `mini.sessions` |

---

### Typing Practice (`typr`)

| Command      | Action                 | Plugin/Feature |
| :----------- | :--------------------- | :------------- |
| `:Typr`      | Start typing practice  | `typr`         |
| `:TyprStats` | Show typing statistics | `typr`         |

---

> **Tip**: Use `<leader>` followed by any key to see available mappings via `which-key.nvim`.

---
