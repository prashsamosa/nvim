# Neovim Configuration - Complete Keymap Reference

## Leader Keys

- **Leader**: `<Space>`
- **Local Leader**: `\`

## General Navigation & Editing

### Basic Operations

| Key          | Mode                 | Action                      | Description              |
| ------------ | -------------------- | --------------------------- | ------------------------ |
| `jk`         | Insert               | `<ESC>`                     | Exit insert mode         |
| `<leader>nh` | Normal               | `:nohlsearch`               | Clear search highlights  |
| `<C-s>`      | Normal/Insert/Visual | `:w`                        | Save file                |
| `gl`         | Normal               | `vim.diagnostic.open_float` | Show diagnostic in float |

### Text Manipulation

| Key         | Mode   | Action             | Description                       |
| ----------- | ------ | ------------------ | --------------------------------- |
| `<leader>+` | Normal | `<C-a>`            | Increment number                  |
| `<leader>-` | Normal | `<C-x>`            | Decrement number                  |
| `p`         | Visual | `"_dP`             | Paste without replacing clipboard |
| `J`         | Visual | `:m '>+1<CR>gv=gv` | Move selection down               |
| `K`         | Visual | `:m '<-2<CR>gv=gv` | Move selection up                 |
| `<A-j>`     | Visual | `:m '>+1<CR>gv=gv` | Move selection down (alt)         |
| `<A-k>`     | Visual | `:m '<-2<CR>gv=gv` | Move selection up (alt)           |
| `<`         | Visual | `<gv`              | Indent left and reselect          |
| `>`         | Visual | `>gv`              | Indent right and reselect         |

### Utility

| Key          | Mode   | Action                   | Description                  |
| ------------ | ------ | ------------------------ | ---------------------------- |
| `<leader>ur` | Normal | Redraw/Clear/Diff update | Comprehensive screen refresh |

## Window Management

### Navigation

| Key          | Mode            | Action               | Description            |
| ------------ | --------------- | -------------------- | ---------------------- |
| `<C-h>`      | Normal/Terminal | Move to left window  | Window navigation      |
| `<C-j>`      | Normal/Terminal | Move to lower window | Window navigation      |
| `<C-l>`      | Normal/Terminal | Move to right window | Window navigation      |
| `<leader>wh` | Normal          | Move to left window  | Alternative window nav |
| `<leader>wj` | Normal          | Move to lower window | Alternative window nav |
| `<leader>wk` | Normal          | Move to upper window | Alternative window nav |
| `<leader>wl` | Normal          | Move to right window | Alternative window nav |

### Resizing

| Key         | Mode   | Action                 | Description   |
| ----------- | ------ | ---------------------- | ------------- |
| `<C-Up>`    | Normal | Increase window height | Resize window |
| `<C-Down>`  | Normal | Decrease window height | Resize window |
| `<C-Left>`  | Normal | Decrease window width  | Resize window |
| `<C-Right>` | Normal | Increase window width  | Resize window |

### Splitting

| Key  | Mode   | Action    | Description      |
| ---- | ------ | --------- | ---------------- |
| `sh` | Normal | `:split`  | Horizontal split |
| `sv` | Normal | `:vsplit` | Vertical split   |

## Terminal

### Terminal Mode

| Key          | Mode     | Action                   | Description         |
| ------------ | -------- | ------------------------ | ------------------- |
| `<ESC><ESC>` | Terminal | `<C-\><C-n>`             | Exit terminal mode  |
| `<C-h>`      | Terminal | Navigate to left window  | Terminal window nav |
| `<C-j>`      | Terminal | Navigate to lower window | Terminal window nav |
| `<C-l>`      | Terminal | Navigate to right window | Terminal window nav |

### Snacks Terminal

| Key          | Mode            | Action          | Description            |
| ------------ | --------------- | --------------- | ---------------------- |
| `<leader>tt` | Normal          | Open terminal   | Snacks terminal        |
| `<C-t>`      | Normal/Terminal | Toggle terminal | Snacks terminal toggle |
| `<leader>TT` | Normal          | New terminal    | New Snacks terminal    |

## LSP (Language Server Protocol)

### Navigation

| Key         | Mode   | Action                | Description                 |
| ----------- | ------ | --------------------- | --------------------------- |
| `gd`        | Normal | Go to definition      | LSP navigation              |
| `gD`        | Normal | Go to declaration     | LSP navigation              |
| `gi`        | Normal | Go to implementation  | LSP navigation              |
| `gr`        | Normal | Go to references      | LSP navigation              |
| `gt`        | Normal | Go to type definition | LSP navigation              |
| `K`         | Normal | Hover documentation   | LSP hover                   |
| `<leader>k` | Normal | Signature help        | LSP signature help          |
| `<C-k>`     | Insert | Signature help        | LSP signature help (insert) |

### Code Actions

| Key          | Mode          | Action        | Description     |
| ------------ | ------------- | ------------- | --------------- |
| `<leader>ca` | Normal/Visual | Code action   | LSP code action |
| `<leader>cr` | Normal        | Rename symbol | LSP rename      |

### Workspace

| Key          | Mode   | Action                  | Description   |
| ------------ | ------ | ----------------------- | ------------- |
| `<leader>wa` | Normal | Add workspace folder    | LSP workspace |
| `<leader>wr` | Normal | Remove workspace folder | LSP workspace |
| `<leader>wl` | Normal | List workspace folders  | LSP workspace |

### FZF-LSP Integration

| Key           | Mode   | Action                | Description  |
| ------------- | ------ | --------------------- | ------------ |
| `<leader>fgd` | Normal | FZF definitions       | LSP with FZF |
| `<leader>fgr` | Normal | FZF references        | LSP with FZF |
| `<leader>fgi` | Normal | FZF implementations   | LSP with FZF |
| `<leader>fgt` | Normal | FZF type definitions  | LSP with FZF |
| `<leader>fds` | Normal | FZF document symbols  | LSP with FZF |
| `<leader>fws` | Normal | FZF workspace symbols | LSP with FZF |

## Diagnostics

### Navigation & Display

| Key          | Mode   | Action                   | Description       |
| ------------ | ------ | ------------------------ | ----------------- |
| `[d`         | Normal | Previous diagnostic      | Built-in 0.11     |
| `]d`         | Normal | Next diagnostic          | Built-in 0.11     |
| `[D`         | Normal | First diagnostic         | Built-in 0.11     |
| `]D`         | Normal | Last diagnostic          | Built-in 0.11     |
| `<leader>dl` | Normal | Diagnostic loclist       | Custom diagnostic |
| `<leader>dq` | Normal | Diagnostic quickfix      | Custom diagnostic |
| `<leader>df` | Normal | Show diagnostic float    | Custom diagnostic |
| `<leader>fd` | Normal | FZF document diagnostics | FZF diagnostics   |

## File Management

### File Operations

| Key               | Mode   | Action           | Description          |
| ----------------- | ------ | ---------------- | -------------------- |
| `<leader><space>` | Normal | Find files       | Snacks/FZF files     |
| `-`               | Normal | Oil file manager | Oil floating         |
| `<leader>e`       | Normal | Snacks explorer  | Snacks file explorer |
| `<leader>rf`      | Normal | Rename file      | Snacks rename        |

### FZF File Operations

| Key          | Mode   | Action         | Description      |
| ------------ | ------ | -------------- | ---------------- |
| `<leader>ff` | Normal | Find files     | FZF files        |
| `<leader>fC` | Normal | Find in config | FZF config files |
| `<leader>fo` | Normal | Recent files   | FZF oldfiles     |
| `<leader>fb` | Normal | Open buffers   | FZF buffers      |
| `<leader>fc` | Normal | Commands       | FZF commands     |
| `<leader>fh` | Normal | Help tags      | FZF help         |
| `<leader>fk` | Normal | Keymaps        | FZF keymaps      |
| `<leader>fr` | Normal | Resume search  | FZF resume       |

## Search & Replace

### FZF Search

| Key          | Mode   | Action                 | Description           |
| ------------ | ------ | ---------------------- | --------------------- |
| `<leader>fg` | Normal | Live grep              | FZF live grep         |
| `<leader>f/` | Normal | Grep current dir       | FZF current directory |
| `<leader>fw` | Normal | Find word under cursor | FZF grep word         |
| `<leader>fW` | Normal | Find WORD under cursor | FZF grep WORD         |

### Grug-far Search & Replace

| Key          | Mode   | Action               | Description      |
| ------------ | ------ | -------------------- | ---------------- |
| `<leader>sr` | Normal | Search & replace     | Grug-far main    |
| `<leader>sR` | Normal | AST search & replace | Grug-far AST     |
| `<leader>sw` | Normal | Search word          | Grug-far word    |
| `<leader>sb` | Normal | Search in buffer     | Grug-far buffer  |
| `<leader>sf` | Normal | Search in project    | Grug-far project |
| `<leader>sv` | Visual | Search selection     | Grug-far visual  |

## Buffer Management

### Buffer Operations

| Key          | Mode   | Action                | Description          |
| ------------ | ------ | --------------------- | -------------------- |
| `<leader>bl` | Normal | Switch to last buffer | Buffer navigation    |
| `<leader>bc` | Normal | Close/delete buffer   | Snacks buffer delete |
| `<leader>ba` | Normal | Delete all buffers    | Snacks delete all    |
| `<leader>bo` | Normal | Delete other buffers  | Snacks delete others |

### Barbar Buffer Navigation

| Key                | Mode   | Action               | Description       |
| ------------------ | ------ | -------------------- | ----------------- |
| `<A-,>`            | Normal | Previous buffer      | Barbar navigation |
| `<A-.>`            | Normal | Next buffer          | Barbar navigation |
| `<A-S-,>`          | Normal | Move buffer left     | Barbar reorder    |
| `<A-S-.>`          | Normal | Move buffer right    | Barbar reorder    |
| `<A-1>` to `<A-9>` | Normal | Go to buffer N       | Barbar direct     |
| `<A-0>`            | Normal | Go to last buffer    | Barbar last       |
| `<A-p>`            | Normal | Pin buffer           | Barbar pin        |
| `<leader>bO`       | Normal | Close all but pinned | Barbar cleanup    |

## Quickfix & Location Lists

### Navigation

| Key  | Mode   | Action            | Description         |
| ---- | ------ | ----------------- | ------------------- |
| `]q` | Normal | Next quickfix     | Quickfix navigation |
| `[q` | Normal | Previous quickfix | Quickfix navigation |
| `]l` | Normal | Next location     | Location list       |
| `[l` | Normal | Previous location | Location list       |

## Git Integration

### Snacks Git

| Key          | Mode          | Action         | Description          |
| ------------ | ------------- | -------------- | -------------------- |
| `<leader>Gb` | Normal        | Git blame line | Snacks git blame     |
| `<leader>GB` | Normal/Visual | Git browse     | Snacks git browse    |
| `<leader>Gf` | Normal        | File history   | Lazygit file history |
| `<leader>GG` | Normal        | Open Lazygit   | Lazygit main         |
| `<leader>Gl` | Normal        | Lazygit log    | Lazygit log          |

## Go Development

### Go-specific Operations

| Key          | Mode   | Action              | Description    |
| ------------ | ------ | ------------------- | -------------- |
| `<leader>ga` | Normal | Alternate file      | Go alternate   |
| `<leader>gi` | Normal | Organize imports    | Go imports     |
| `<leader>gm` | Normal | Mod tidy            | Go mod tidy    |
| `<leader>gs` | Normal | Fill struct         | Go fill struct |
| `<leader>gj` | Normal | JSON to struct      | Go json2struct |
| `<leader>gI` | Normal | Implement interface | Go implement   |

### Go Tags

| Key           | Mode          | Action      | Description    |
| ------------- | ------------- | ----------- | -------------- |
| `<leader>gTa` | Normal/Visual | Add tags    | Go add tags    |
| `<leader>gTr` | Normal/Visual | Remove tags | Go remove tags |

### Go Build & Run

| Key          | Mode   | Action           | Description |
| ------------ | ------ | ---------------- | ----------- |
| `<leader>gb` | Normal | Build package    | Go build    |
| `<leader>gx` | Normal | Run current file | Go run      |

### Go Testing

| Key           | Mode   | Action          | Description        |
| ------------- | ------ | --------------- | ------------------ |
| `<leader>gta` | Normal | Test all        | Go test all        |
| `<leader>gtf` | Normal | Test function   | Go test function   |
| `<leader>gtp` | Normal | Test package    | Go test package    |
| `<leader>gat` | Normal | Add test        | Go add test        |
| `<leader>gtc` | Normal | Show coverage   | Go coverage        |
| `<leader>gtC` | Normal | Toggle coverage | Go coverage toggle |

### Go Utilities

| Key           | Mode   | Action             | Description         |
| ------------- | ------ | ------------------ | ------------------- |
| `<leader>gv`  | Normal | Go vet             | Go vet              |
| `<leader>gD`  | Normal | Show documentation | Go doc              |
| `<leader>gdt` | Normal | Debug test         | Go debug test (DAP) |

## Database (Dadbod)

### Database Operations

| Key          | Mode   | Action             | Description     |
| ------------ | ------ | ------------------ | --------------- |
| `<leader>Do` | Normal | Database UI open   | Dadbod UI       |
| `<leader>Du` | Normal | Database UI toggle | Dadbod toggle   |
| `<leader>Dc` | Normal | Database UI close  | Dadbod close    |
| `<leader>Df` | Normal | Find buffer        | Dadbod find     |
| `<leader>Da` | Normal | Add connection     | Dadbod add conn |
| `<leader>Dn` | Normal | Rename buffer      | Dadbod rename   |
| `<leader>Dl` | Normal | Last query info    | Dadbod info     |

### SQL File Operations (Auto-mapped in SQL files)

| Key          | Mode          | Action        | Description    |
| ------------ | ------------- | ------------- | -------------- |
| `<leader>Dr` | Normal/Visual | Execute query | Execute SQL    |
| `<leader>DS` | Normal        | Save query    | Save SQL query |

## Markdown

### Render Markdown

| Key          | Mode   | Action         | Description       |
| ------------ | ------ | -------------- | ----------------- |
| `<leader>mt` | Normal | Toggle render  | Markdown toggle   |
| `<leader>me` | Normal | Enable render  | Markdown enable   |
| `<leader>md` | Normal | Disable render | Markdown disable  |
| `<leader>ml` | Normal | Show log       | Markdown log      |
| `<leader>mD` | Normal | Debug line     | Markdown debug    |
| `<leader>mc` | Normal | Show config    | Markdown config   |
| `<leader>mE` | Normal | Expand view    | Markdown expand   |
| `<leader>mC` | Normal | Contract view  | Markdown contract |

## TODO Comments

### TODO Navigation

| Key          | Mode   | Action        | Description     |
| ------------ | ------ | ------------- | --------------- |
| `]t`         | Normal | Next TODO     | TODO navigation |
| `[t`         | Normal | Previous TODO | TODO navigation |
| `<leader>st` | Normal | Search TODOs  | TODO telescope  |

## Treesitter

### Incremental Selection

| Key         | Mode          | Action                | Description          |
| ----------- | ------------- | --------------------- | -------------------- |
| `<Enter>`   | Normal/Visual | Init/expand selection | Treesitter selection |
| `<S-Enter>` | Visual        | Scope incremental     | Treesitter scope     |
| `<BS>`      | Visual        | Node decremental      | Treesitter decrease  |

### Text Objects Navigation

| Key  | Mode   | Action                  | Description         |
| ---- | ------ | ----------------------- | ------------------- |
| `]m` | Normal | Next function start     | Treesitter function |
| `[m` | Normal | Previous function start | Treesitter function |
| `]M` | Normal | Next function end       | Treesitter function |
| `[M` | Normal | Previous function end   | Treesitter function |
| `]c` | Normal | Next class start        | Treesitter class    |
| `[c` | Normal | Previous class start    | Treesitter class    |
| `]C` | Normal | Next class end          | Treesitter class    |
| `[C` | Normal | Previous class end      | Treesitter class    |

### Parameter Swapping

| Key          | Mode   | Action                  | Description     |
| ------------ | ------ | ----------------------- | --------------- |
| `<leader>pa` | Normal | Swap next parameter     | Treesitter swap |
| `<leader>pA` | Normal | Swap previous parameter | Treesitter swap |

### Code Peeking

| Key          | Mode   | Action        | Description     |
| ------------ | ------ | ------------- | --------------- |
| `<leader>pf` | Normal | Peek function | Treesitter peek |
| `<leader>pc` | Normal | Peek class    | Treesitter peek |

## Snacks Utilities

### Snacks Picker

| Key          | Mode   | Action               | Description          |
| ------------ | ------ | -------------------- | -------------------- |
| `<leader>,`  | Normal | Buffers picker       | Snacks buffers       |
| `<leader>:`  | Normal | Command history      | Snacks commands      |
| `<leader>sn` | Normal | Notification history | Snacks notifications |

### Snacks Zen & Focus

| Key         | Mode   | Action      | Description |
| ----------- | ------ | ----------- | ----------- |
| `<leader>z` | Normal | Zen mode    | Snacks zen  |
| `<leader>Z` | Normal | Zoom window | Snacks zoom |

### Snacks Scratch & Utilities

| Key         | Mode   | Action         | Description           |
| ----------- | ------ | -------------- | --------------------- |
| `<leader>.` | Normal | Scratch buffer | Snacks scratch        |
| `<leader>S` | Normal | Select scratch | Snacks scratch select |

### Snacks Word References

| Key          | Mode            | Action                  | Description  |
| ------------ | --------------- | ----------------------- | ------------ |
| `<leader>]w` | Normal/Terminal | Next word reference     | Snacks words |
| `<leader>[w` | Normal/Terminal | Previous word reference | Snacks words |

### Mini.nvim Sessions

| Key          | Mode   | Action         | Description   |
| ------------ | ------ | -------------- | ------------- |
| `<leader>Ms` | Normal | Write session  | Mini sessions |
| `<leader>Mr` | Normal | Read session   | Mini sessions |
| `<leader>Md` | Normal | Delete session | Mini sessions |

### Mini.nvim Pick

| Key          | Mode   | Action     | Description    |
| ------------ | ------ | ---------- | -------------- |
| `<leader>mp` | Normal | Pick files | Mini pick      |
| `<leader>mg` | Normal | Grep live  | Mini pick grep |

## Toggle Options

### UI Toggles

| Key          | Mode   | Action                       | Description |
| ------------ | ------ | ---------------------------- | ----------- |
| `<leader>uL` | Normal | Toggle relative numbers      | UI toggle   |
| `<leader>ud` | Normal | Toggle diagnostics           | UI toggle   |
| `<leader>ul` | Normal | Toggle line numbers          | UI toggle   |
| `<leader>uc` | Normal | Toggle conceallevel          | UI toggle   |
| `<leader>uT` | Normal | Toggle treesitter highlights | UI toggle   |
| `<leader>ub` | Normal | Toggle background            | UI toggle   |
| `<leader>uh` | Normal | Toggle inlay hints           | UI toggle   |
| `<leader>uD` | Normal | Toggle dim mode              | UI toggle   |
| `<leader>uN` | Normal | Hide diagnostics             | UI toggle   |
| `<leader>un` | Normal | Show notifications           | UI toggle   |

## Format

### Code Formatting

| Key         | Mode          | Action        | Description    |
| ----------- | ------------- | ------------- | -------------- |
| `<leader>f` | Normal/Visual | Format buffer | Conform format |

---

## Conflicts & Issues Resolved

### Fixed Issues:

1. **LSP Signature Help**: Changed from `<C-k>` to `<leader>k` to avoid terminal navigation conflicts
2. **Terminal Navigation**: Removed `<C-k>` mapping in terminal mode to prevent conflicts
3. **Snacks Keymaps**: Resolved potential conflicts with unique prefixes
4. **Buffer Management**: Centralized buffer operations under consistent prefixes

### Key Design Principles:

- **Consistent Prefixes**: Related functions grouped under logical prefixes
- **Mode Awareness**: Different behaviors in different modes where appropriate
- **Conflict Avoidance**: No overlapping keymaps that would cause issues
- **Fallback Support**: FZF integration with LSP fallbacks where appropriate

### Recommended Improvements:

1. Consider using `<leader>w` prefix for all window operations
2. Group all LSP operations under `<leader>l` if you prefer more organization
3. Add more database shortcuts if you use SQL frequently
4. Consider adding project-specific keymaps for your most-used languages

---

## Notes:

- All keymaps are set with `silent = true` for clean operation
- LSP keymaps are automatically applied when LSP attaches to a buffer
- File-type specific keymaps (Go, SQL, Markdown) are auto-loaded for relevant files
- FZF integration provides enhanced search capabilities with LSP fallbacks
