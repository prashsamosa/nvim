# Ubuntu Enhanced ZSH Configuration Reference

## 🚀 Quick Start Commands

### System Management
- `sysupdate` - Update all system packages
- `sysinfo` - Display system information
- `testtools` - Check installed development tools
- `install_plugins` - Install Oh My Zsh plugins

### Navigation & File Operations
- `cx <dir>` - Change directory and list contents
- `fcd` - Fuzzy find and change to directory
- `mkcd <dir>` - Create directory and cd into it
- `..` / `...` - Go up 1/2 directories

### File Search & Management
- `f` - Fuzzy find file and copy path to clipboard
- `fv` - Fuzzy find and edit file with nvim
- `ff <pattern>` - Find files by name pattern
- `search_files <pattern>` - Search file contents (rg/grep)
- `extract <archive>` - Extract various archive formats
- `backup <file>` - Create timestamped backup

### Git Shortcuts
- `gst` - Git status
- `glog` - Git log (oneline, graph, all branches)
- `gd` / `gdc` - Git diff / cached diff
- `gaa` - Git add all
- `gcm "<msg>"` - Git commit with message
- `gp` / `gl` - Git push/pull
- `gco` / `gb` - Git checkout/branch
- `gacp "<msg>"` - Git add, commit, and push

### Docker Shortcuts
- `d` / `dc` - Docker / docker-compose
- `dps` / `dpa` - Docker ps / ps -a
- `di` - Docker images
- `dlog` / `dexec` - Docker logs / exec -it
- `drm` / `drmi` - Remove all containers/images

### System Monitoring
- `psg <pattern>` - Process grep
- `topcpu` / `topmem` - Top CPU/memory processes
- `fkill` - Fuzzy kill processes
- `ports` - Show listening ports

### Utilities
- `weather [location]` - Get weather info
- `qr <text>` - Generate QR code
- `json <file|string>` - Pretty print JSON
- `note [text]` - Create/edit daily notes
- `webserver [port]` - Start HTTP server (default: 8000)
- `myip` / `localip` - Get public/local IP
- `dsize [dir]` - Directory size
- `tree [level]` - Show directory tree

## 📁 File Listing Aliases (with eza)
- `ls` - Basic listing with icons
- `la` - All files with git info
- `ll` - Long format with git info
- `l` - Long format all files with header
- `lt` / `ltree` - Tree view (3 levels)
- `lsize` / `ltime` - Sort by size/time

## 🔧 Development Tools
- `vim` / `vi` / `v` - All aliased to nvim
- `python` / `pip` / `py` - Python3 shortcuts
- `cat` - Aliased to bat (syntax highlighting)
- `npmls` - List npm packages (depth 0)

## 🎯 FZF Keybindings
- `Ctrl+T` - Fuzzy file search
- `Ctrl+R` - Command history search
- `Alt+C` - Fuzzy directory change
- `?` - Toggle preview in FZF
- `Ctrl+A` - Select all in FZF
- `Ctrl+D` - Deselect all in FZF

## 🔄 Quick Shortcuts
- `:q` / `:wq` - Exit shell (vim-style)
- `c` / `cls` - Clear screen
- `h` - Show history
- `reload` - Reload ZSH config
- `zshconfig` - Edit ~/.zshrc
- `path` - Show PATH components

## 🎨 Theme & Prompt
- **Theme**: Starship with custom configuration
- **Colors**: Catppuccin Mocha theme
- **Icons**: Nerd fonts support for file types
- **Git Integration**: Branch and status indicators

## 📦 Essential Plugins
- `git` - Git aliases and completion
- `z` - Smart directory jumping
- `colored-man-pages` - Colorized man pages
- `zsh-autosuggestions` - Command suggestions
- `zsh-syntax-highlighting` - Syntax highlighting
- `sudo` - ESC ESC to prepend sudo
- `copypath` / `copyfile` - Copy paths/files
- `jsontools` - JSON utilities
- `web-search` - Web search from terminal

## 🛠 Path Management
Auto-detects and adds to PATH:
- `~/bin`, `~/.local/bin`
- Homebrew (if installed)
- Go, Rust, Node.js, Python, Deno, Bun
- rbenv, asdf version managers

## 📋 Installation Requirements
```bash
# Essential tools
sudo apt install fzf bat fd-find ripgrep neovim

# Modern alternatives
sudo apt install eza zoxide starship

# Optional enhancements
sudo apt install thefuck direnv mcfly atuin
```

## 🔍 Features
- **Performance**: ZSH compilation for faster loading
- **History**: 50k entries with deduplication
- **Completion**: Case-insensitive with fuzzy matching
- **Globbing**: Extended patterns and dot file inclusion
- **Error Correction**: Command and argument correction
- **XDG Compliance**: Proper config directory structure