# 🧃 snacks.nvim — Full Feature Guide & Shortcuts

A comprehensive and delightful Neovim enhancement plugin by folke/snacks.nvim, featuring pickers, explorer, toggleable settings, Zen mode, Git tools, LSP navigation, and more — all with ergonomic keymaps and visual polish.

## ⚙️ Plugin Setup

Install via lazy.nvim:

```lua
{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  init = function()
    -- Debug utilities
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd

        -- Toggle Mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", {
          off = 0,
          on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2
        }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })

    -- Auto Rename on File Move (Oil.nvim)
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
  end,

  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
                                                                               
                 ████ ██████           █████      ██                     
                ███████████             █████                           
                █████████ ███████████████████ ███   ███████████   
               █████████  ███    █████████████ █████ ██████████████  
              █████████ ██████████ █████████ █████ █████ ████ █████  
            ███████████ ███    ███ █████████ █████ █████ ████ █████ 
           ██████  █████████████████████ ████ █████ █████ ████ ██████
        ]]
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    rename = { enabled = true },
    zen = { enabled = true },
  },

  config = function(_, opts)
    require("snacks").setup(opts)
  end,
}
```

## 🧠 Keybindings Overview

### 🎯 Pickers
| Mapping | Description |
|---------|-------------|
| `<leader><space>` | Smart File Picker |
| `<leader>,` | Buffer Picker |
| `<leader>/` | Grep Live |
| `<leader>:` | Command History |
| `<leader>n` | Notification History |

### 📁 Explorer
| Mapping | Description |
|---------|-------------|
| `<leader>e` | File Explorer |

### 🔍 File/Git
| Mapping | Description |
|---------|-------------|
| `<leader>ff` | Find Files |
| `<leader>fc` | Config Files |
| `<leader>fg` | Git Files |
| `<leader>fr` | Recent Files |
| `<leader>fp` | Project Switcher |

### 🧪 Git Tools
| Mapping | Description |
|---------|-------------|
| `<leader>gs` | Git Status |
| `<leader>gb` | Git Branches |
| `<leader>gd` | Git Diff (Hunks) |
| `<leader>gL` | Git Line Log |
| `<leader>gl` | Git Log |
| `<leader>gf` | Git File Log |
| `<leader>gS` | Git Stash |
| `<leader>gB` | Git Browse |
| `<leader>gg` | Lazygit |

### 🔧 LSP Navigation
| Mapping | Description |
|---------|-------------|
| `gd` | Go to Definition |
| `gD` | Go to Declaration |
| `gr` | References |
| `gI` | Implementations |
| `gy` | Type Definitions |
| `<leader>ss` | Document Symbols |
| `<leader>sS` | Workspace Symbols |

### 🔍 Grep
| Mapping | Description |
|---------|-------------|
| `<leader>sb` | Grep Buffer Lines |
| `<leader>sB` | Grep Open Buffers |
| `<leader>sg` | Grep All |
| `<leader>sw` | Grep Visual Word |

### 🧘 Zen & Buffer Management
| Mapping | Description |
|---------|-------------|
| `<leader>z` | Toggle Zen Mode |
| `<leader>Z` | Toggle Zoom Mode |
| `<leader>bd` | Delete Current Buffer |
| `<leader>ba` | Delete All Buffers |
| `<leader>bo` | Delete Other Buffers |

### ✏️ Scratch Buffer
| Mapping | Description |
|---------|-------------|
| `<leader>.` | Toggle Scratch Buffer |
| `<leader>S` | Select Scratch Buffer |

### ⌨️ Rename / File Ops
| Mapping | Description |
|---------|-------------|
| `<leader>cR` | Rename File |

### 🔠 Word Navigation
| Mapping | Description |
|---------|-------------|
| `]]` | Next Word Reference |
| `[[` | Prev Word Reference |

### 🔔 Notifications
| Mapping | Description |
|---------|-------------|
| `<leader>un` | Dismiss Notifications |

### 🔥 Terminal
| Mapping | Description |
|---------|-------------|
| `<C-/>` | Toggle Terminal |
| `<C-_>` | Toggle Terminal |

### 📰 Neovim News
| Mapping | Description |
|---------|-------------|
| `<leader>N` | View news.txt |

## 🧪 Debug Helpers
| Command | Description |
|---------|-------------|
| `dd(...)` | Debug Inspect |
| `bt()` | Debug Backtrace |
| `vim.print` | Global Print Hook |

## 📦 Auto Rename Integration (Oil.nvim)
Automatically keeps file references in sync on rename via Oil:

```lua
vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    if event.data.actions.type == "move" then
      Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
    end
  end,
})
```

## Toggle Options
The plugin provides a clean way to toggle various Neovim options:

- Spell checking: `<leader>us`
- Line wrapping: `<leader>uw`
- Relative line numbers: `<leader>uL`
- Diagnostics: `<leader>ud`
- Line numbers: `<leader>ul`
- Conceal level: `<leader>uc`
- Treesitter: `<leader>uT`
- Light/dark background: `<leader>ub`
- Inlay hints: `<leader>uh`
- Indent guides: `<leader>ug`
- Dim mode: `<leader>uD`