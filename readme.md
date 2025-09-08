## 📁 Directory Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── .luacheckrc                # Luacheck configuration
├── .luarc.json                # Lua language server config
├── lua/
│   ├── config/                # Core configuration
│   │   ├── autocmds.lua       # Auto-commands
│   │   ├── globals.lua        # Global variables
│   │   ├── keymaps.lua        # Key mappings
│   │   ├── lazy.lua           # Plugin manager setup
│   │   └── options.lua        # Neovim options
│   ├── plugins/               # Plugin configurations
│   │   ├── [plugin-name].lua  # Individual plugin configs
│   │   └── ...
│   ├── servers/               # LSP server configurations
│   │   ├── init.lua           # LSP initialization
│   │   ├── [server-name].lua  # Individual server configs
│   │   └── ...
│   └── utils/                 # Utility modules
│       ├── diagnostics.lua   # Diagnostic configuration
│       └── lsp.lua            # LSP utilities and keymaps
```

## ⚙️ Core Configuration

### Leader Keys

- **Leader**: `<Space>`
- **Local Leader**: `<Space>`

### Key Mappings

#### Navigation & Movement

| Key           | Mode   | Action                             |
| ------------- | ------ | ---------------------------------- |
| `<C-h/j/k/l>` | Normal | Navigate windows                   |
| `<C-d>/<C-u>` | Normal | Half page up/down (centered)       |
| `n/N`         | Normal | Next/prev search result (centered) |

#### Buffer & File Management

| Key             | Mode   | Action               |
| --------------- | ------ | -------------------- |
| `<leader>e`     | Normal | Toggle file explorer |
| `<leader>m`     | Normal | Focus file explorer  |
| `<leader>bn/bp` | Normal | Next/previous buffer |
| `<leader>rc`    | Normal | Edit config file     |

#### Fuzzy Finding (FZF)

| Key             | Mode   | Action                     |
| --------------- | ------ | -------------------------- |
| `<leader>ff`    | Normal | Find files                 |
| `<leader>fg`    | Normal | Live grep                  |
| `<leader>fb`    | Normal | Find buffers               |
| `<leader>fh`    | Normal | Help tags                  |
| `<leader>fs/fS` | Normal | Document/workspace symbols |

#### LSP Operations

| Key          | Mode   | Action                                |
| ------------ | ------ | ------------------------------------- |
| `<leader>gd` | Normal | LSP finder (definitions + references) |
| `<leader>gD` | Normal | Go to definition                      |
| `<leader>gS` | Normal | Go to definition in split             |
| `<leader>gr` | Normal | Show references                       |
| `<leader>gi` | Normal | Go to implementation                  |
| `<leader>gt` | Normal | Go to type definition                 |
| `<leader>ca` | Normal | Code actions                          |
| `<leader>rn` | Normal | Rename symbol                         |
| `<leader>oi` | Normal | Organize imports                      |
| `K`          | Normal | Hover documentation                   |

#### Diagnostics

| Key             | Mode   | Action                          |
| --------------- | ------ | ------------------------------- |
| `<leader>d`     | Normal | Show diagnostics (cursor)       |
| `<leader>D`     | Normal | Show diagnostics (line)         |
| `<leader>nd/pd` | Normal | Next/previous diagnostic        |
| `<leader>xx`    | Normal | Workspace diagnostics (Trouble) |
| `<leader>xX`    | Normal | Buffer diagnostics (Trouble)    |

#### Window Management

| Key              | Mode   | Action                        |
| ---------------- | ------ | ----------------------------- |
| `<leader>sv/sh`  | Normal | Split vertically/horizontally |
| `<C-Up/Down>`    | Normal | Resize height                 |
| `<C-Left/Right>` | Normal | Resize width                  |

---
