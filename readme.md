## Keymaps Reference

### Leader Keys

- **Leader**: `<Space>`
- **Local Leader**: `\`

### Essential Mappings

| Mode  | Key          | Action        | Description              |
| ----- | ------------ | ------------- | ------------------------ |
| i     | `jk`         | `<ESC>`       | Exit insert mode         |
| n     | `<leader>nh` | `:nohlsearch` | Clear highlights         |
| n     | `<leader>+`  | `<C-a>`       | Increment number         |
| n     | `<leader>-`  | `<C-x>`       | Decrement number         |
| v     | `p`          | `"_dP`        | Paste without yanking    |
| n,v   | `<leader>y`  | `"+y`         | Yank to system clipboard |
| n,i,v | `<C-s>`      | `:w`          | Save file                |
| n     | `<C-a>`      | `ggVG`        | Select all               |

### Navigation

| Mode | Key     | Action    | Description                       |
| ---- | ------- | --------- | --------------------------------- |
| n    | `<C-d>` | `<C-d>zz` | Half page down and center         |
| n    | `<C-u>` | `<C-u>zz` | Half page up and center           |
| n    | `n`     | `nzzzv`   | Next search result (centered)     |
| n    | `N`     | `Nzzzv`   | Previous search result (centered) |

### Window Management

| Mode | Key          | Action    | Description        |
| ---- | ------------ | --------- | ------------------ |
| n    | `<C-h>`      | `<C-w>h`  | Go to left window  |
| n    | `<C-j>`      | `<C-w>j`  | Go to lower window |
| n    | `<C-k>`      | `<C-w>k`  | Go to upper window |
| n    | `<C-l>`      | `<C-w>l`  | Go to right window |
| n    | `<leader>\|` | `:vsplit` | Vertical split     |
| n    | `<leader>\\` | `:split`  | Horizontal split   |

### Visual Mode

| Mode | Key | Action             | Description     |
| ---- | --- | ------------------ | --------------- |
| v    | `J` | `:m '>+1<CR>gv=gv` | Move line down  |
| v    | `K` | `:m '<-2<CR>gv=gv` | Move line up    |
| v    | `<` | `<gv`              | Decrease indent |
| v    | `>` | `>gv`              | Increase indent |

### Terminal

| Mode | Key          | Action              | Description           |
| ---- | ------------ | ------------------- | --------------------- |
| t    | `<ESC><ESC>` | `<C-\\><C-n>`       | Exit terminal mode    |
| t    | `<C-h>`      | `:wincmd h`         | Terminal left window  |
| t    | `<C-j>`      | `:wincmd j`         | Terminal lower window |
| t    | `<C-k>`      | `:wincmd k`         | Terminal upper window |
| t    | `<C-l>`      | `:wincmd l`         | Terminal right window |
| n,t  | `<C-t>`      | `Snacks.terminal()` | Open terminal         |

### LSP

| Mode | Key          | Action                        | Description          |
| ---- | ------------ | ----------------------------- | -------------------- |
| n    | `gd`         | `vim.lsp.buf.definition`      | Go to definition     |
| n    | `gr`         | `vim.lsp.buf.references`      | Go to references     |
| n    | `gi`         | `vim.lsp.buf.implementation`  | Go to implementation |
| n    | `gt`         | `vim.lsp.buf.type_definition` | Type definition      |
| n    | `K`          | `vim.lsp.buf.hover`           | Hover documentation  |
| n    | `gK`         | `vim.lsp.buf.signature_help`  | Signature help       |
| i    | `<C-h>`      | `vim.lsp.buf.signature_help`  | Signature help       |
| n,v  | `<leader>ca` | `vim.lsp.buf.code_action`     | Code actions         |
| n    | `<leader>cr` | `vim.lsp.buf.rename`          | Rename symbol        |
| n    | `<leader>ih` | Toggle inlay hints            | Toggle inlay hints   |

### Diagnostics

| Mode | Key          | Action                      | Description           |
| ---- | ------------ | --------------------------- | --------------------- |
| n    | `<leader>df` | `vim.diagnostic.open_float` | Show line diagnostics |
| n    | `]d`         | `vim.diagnostic.goto_next`  | Next diagnostic       |
| n    | `[d`         | `vim.diagnostic.goto_prev`  | Previous diagnostic   |

### Quickfix

| Mode | Key  | Action   | Description       |
| ---- | ---- | -------- | ----------------- |
| n    | `]q` | `:cnext` | Next quickfix     |
| n    | `[q` | `:cprev` | Previous quickfix |

### Buffer Management (Barbar)

| Mode | Key                | Action                             | Description       |
| ---- | ------------------ | ---------------------------------- | ----------------- |
| n    | `<A-1>` to `<A-9>` | `BufferGoto 1-9`                   | Go to buffer 1-9  |
| n    | `<A-0>`            | `BufferLast`                       | Go to last buffer |
| n    | `<A-,>`            | `BufferPrevious`                   | Previous buffer   |
| n    | `<A-.>`            | `BufferNext`                       | Next buffer       |
| n    | `<A-c>`            | `BufferClose`                      | Close buffer      |
| n    | `<A-p>`            | `BufferPin`                        | Pin buffer        |
| n    | `<leader>bo`       | `BufferCloseAllButCurrentOrPinned` | Close others      |
| n    | `<leader>bd`       | `Snacks.bufdelete()`               | Delete buffer     |

### File Management (FZF)

| Mode | Key          | Action                        | Description                 |
| ---- | ------------ | ----------------------------- | --------------------------- |
| n    | `<leader>ff` | `FzfLua files`                | Find files                  |
| n    | `<leader>fg` | `FzfLua live_grep`            | Live grep                   |
| n    | `<leader>fb` | `FzfLua buffers`              | Buffers                     |
| n    | `<leader>fh` | `FzfLua helptags`             | Help tags                   |
| n    | `<leader>fo` | `FzfLua oldfiles`             | Recent files                |
| n    | `<leader>fc` | `FzfLua commands`             | Commands                    |
| n    | `<leader>fk` | `FzfLua keymaps`              | Keymaps                     |
| n    | `<leader>fd` | `FzfLua diagnostics_document` | Document diagnostics        |
| n    | `<leader>fw` | `FzfLua grep_cword`           | Find word under cursor      |
| n    | `<leader>fW` | `FzfLua grep_cWORD`           | Find WORD under cursor      |
| n    | `<leader>fr` | `FzfLua resume`               | Resume last search          |
| n    | `<leader>fC` | Find in config                | Find files in config dir    |
| n    | `<leader>f/` | Grep current dir              | Live grep current directory |

### File Explorer (Oil)

| Mode | Key | Action             | Description       |
| ---- | --- | ------------------ | ----------------- |
| n    | `-` | `oil.open_float()` | Open file manager |

### Git (Gitsigns)

| Mode | Key          | Action        | Description               |
| ---- | ------------ | ------------- | ------------------------- |
| n    | `]h`         | Next hunk     | Next git hunk             |
| n    | `[h`         | Previous hunk | Previous git hunk         |
| n    | `<leader>hs` | Stage hunk    | Stage hunk                |
| n    | `<leader>hr` | Reset hunk    | Reset hunk                |
| n    | `<leader>hS` | Stage buffer  | Stage buffer              |
| n    | `<leader>hR` | Reset buffer  | Reset buffer              |
| n    | `<leader>hp` | Preview hunk  | Preview hunk              |
| n    | `<leader>hb` | Blame line    | Blame line                |
| n    | `<leader>hd` | Diff this     | Diff this                 |
| n    | `<leader>tb` | Toggle blame  | Toggle current line blame |

### Code Formatting (Conform)

| Mode | Key          | Action          | Description           |
| ---- | ------------ | --------------- | --------------------- |
| n,v  | `<leader>f`  | Format code     | Format code           |
| n    | `<leader>cF` | `ConformToggle` | Toggle format on save |

### Search & Replace (GrugFar)

| Mode | Key          | Action                   | Description              |
| ---- | ------------ | ------------------------ | ------------------------ |
| n    | `<leader>R`  | Open search & replace    | Search & replace         |
| n    | `<leader>rw` | Search word under cursor | Search word under cursor |
| n    | `<leader>rb` | Search in current buffer | Search in current buffer |
| v    | `<leader>rv` | Search visual selection  | Search visual selection  |

### Go Development (go.nvim)

| Mode | Key          | Action         | Description          |
| ---- | ------------ | -------------- | -------------------- |
| n    | `<leader>ga` | `GoAlt`        | Go to alternate file |
| n    | `<leader>gi` | `GoImports`    | Go imports           |
| n    | `<leader>gb` | `GoBuild`      | Go build             |
| n    | `<leader>gr` | `GoRun`        | Go run               |
| n    | `<leader>gt` | `GoTest`       | Go test              |
| n    | `<leader>gT` | `GoTestFile`   | Go test file         |
| n    | `<leader>gf` | `GoFillStruct` | Go fill struct       |
| n    | `<leader>ge` | `GoIfErr`      | Go add if err        |

### Database (Dadbod)

| Mode | Key          | Action              | Description        |
| ---- | ------------ | ------------------- | ------------------ |
| n    | `<leader>Do` | `DBUI`              | DB: Open           |
| n    | `<leader>Du` | `DBUIToggle`        | DB: Toggle         |
| n    | `<leader>Da` | `DBUIAddConnection` | DB: Add connection |
| n    | `<leader>Dr` | `DBUIExecute`       | Execute query      |
| v    | `<leader>Dr` | `DBUIExecute`       | Execute selection  |

### Todo Comments

| Mode | Key          | Action                | Description           |
| ---- | ------------ | --------------------- | --------------------- |
| n    | `]t`         | Next todo comment     | Next todo comment     |
| n    | `[t`         | Previous todo comment | Previous todo comment |
| n    | `<leader>ft` | `TodoFzfLua`          | Todo comments         |

### Snacks (Various Features)

| Mode | Key          | Action                    | Description             |
| ---- | ------------ | ------------------------- | ----------------------- |
| n    | `<leader>e`  | `Snacks.explorer()`       | Explorer                |
| n    | `<leader>gg` | `Snacks.lazygit()`        | Lazygit                 |
| n    | `<leader>z`  | `Snacks.zen()`            | Zen mode                |
| n    | `<leader>Z`  | `Snacks.zen.zoom()`       | Zoom mode               |
| n    | `<leader>un` | Show notification history | Notification history    |
| n    | `<leader>s`  | `Snacks.scratch()`        | Scratch buffer          |
| n    | `<leader>ss` | Select scratch            | Select scratch          |
| n    | `<leader>cR` | Rename file               | Rename file             |
| n,v  | `<leader>gB` | Git browse                | Git browse              |
| n,t  | `]w`         | Next reference            | Next word reference     |
| n,t  | `[w`         | Previous reference        | Previous word reference |

### Snacks Toggles

| Mode | Key          | Action              | Description         |
| ---- | ------------ | ------------------- | ------------------- |
| n    | `<leader>ud` | Toggle diagnostics  | Toggle diagnostics  |
| n    | `<leader>ul` | Toggle line numbers | Toggle line numbers |
| n    | `<leader>uw` | Toggle wrap         | Toggle line wrap    |
| n    | `<leader>us` | Toggle spelling     | Toggle spelling     |
| n    | `<leader>uT` | Toggle treesitter   | Toggle treesitter   |
| n    | `<leader>ub` | Toggle background   | Toggle background   |

### Treesitter Selections

| Mode | Key         | Action            | Description          |
| ---- | ----------- | ----------------- | -------------------- |
| n    | `<Enter>`   | Init selection    | Initialize selection |
| n    | `<Enter>`   | Node incremental  | Expand selection     |
| n    | `<S-Enter>` | Scope incremental | Expand to scope      |
| n    | `<BS>`      | Node decremental  | Shrink selection     |

### Treesitter Text Objects

| Mode | Key  | Action                  | Description             |
| ---- | ---- | ----------------------- | ----------------------- |
| n,v  | `af` | Around function         | Around function         |
| n,v  | `if` | Inside function         | Inside function         |
| n,v  | `ac` | Around class            | Around class            |
| n,v  | `ic` | Inside class            | Inside class            |
| n    | `]m` | Next function start     | Next function start     |
| n    | `[m` | Previous function start | Previous function start |
| n    | `]c` | Next class start        | Next class start        |
| n    | `[c` | Previous class start    | Previous class start    |

### Mini.nvim Mappings

| Mode | Key   | Action            | Description         |
| ---- | ----- | ----------------- | ------------------- |
| n,v  | `gsa` | Add surround      | Add surround        |
| n    | `gsd` | Delete surround   | Delete surround     |
| n    | `gsr` | Replace surround  | Replace surround    |
| n,v  | `gS`  | Split/join toggle | Split/join toggle   |
| n    | `g=`  | Evaluate          | Evaluate expression |
| n,v  | `gx`  | Exchange          | Exchange text       |
| n,v  | `gm`  | Multiply          | Multiply text       |
| n,v  | `gr`  | Replace           | Replace text        |
| n,v  | `gs`  | Sort              | Sort text           |

### Markdown

| Mode | Key          | Action                  | Description            |
| ---- | ------------ | ----------------------- | ---------------------- |
| n    | `<leader>mt` | `RenderMarkdown toggle` | Toggle markdown render |

### Commands

- `:StartupTime` - Show startup time
- `:ConformToggle` - Toggle format on save
- `:Mason` - Open Mason
- `:Typr` - Start typing practice
- `:TyprStats` - Show typing stats

### Completion (Blink.cmp)

| Mode | Key         | Action                      | Description          |
| ---- | ----------- | --------------------------- | -------------------- |
| i    | `<CR>`      | Accept completion           | Accept completion    |
| i    | `<Tab>`     | Next completion/snippet     | Next completion      |
| i    | `<S-Tab>`   | Previous completion/snippet | Previous completion  |
| i    | `<C-d>`     | Show/hide documentation     | Toggle documentation |
| i    | `<C-e>`     | Hide completion             | Hide completion      |
| i    | `<C-space>` | Show completion             | Show completion      |

---

## Notes

1. The main issue is with mason-lspconfig's `automatic_enable` option which may not work in 0.11+
2. Mason-LSPConfig Compatibility
Since Neovim 0.11 introduced vim.lsp.config, mason-lspconfig's feature set has been reduced and automatic_enable may not work as expected. Your configuration should work but may need manual server enabling.
3. Potential Fixes Needed

**lua/plugins/mason.lua** - Update to handle Neovim 0.11 properly:
```lua
config = function(_, opts)
  require("mason-lspconfig").setup(opts)

  -- For Neovim 0.11+, we need to manually enable servers
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup_handlers({
    function(server_name)
      -- Enable the server using vim.lsp.enable
      vim.lsp.enable(server_name)
    end,
  })
end,
```
