# WSL ZSH Configuration Reference

## 🚀 Quick Start Commands

### WSL-Specific Commands
- `explorer` / `winex` - Open Windows Explorer
- `notepad` - Open Windows Notepad
- `code` - Open VS Code (Windows)
- `powershell` / `cmd` - Windows shells
- `clip` - Copy to Windows clipboard
- `open` - Open with default Windows app

### WSL Path Conversion
- `wpath <linux-path>` - Convert Linux path to Windows path
- `lpath <windows-path>` - Convert Windows path to Linux path
- `winopen [file/dir]` - Open file/directory in Windows

### System Management
- `sysupdate` - Update all system packages
- `sysinfo` - Display system information (includes WSL info)
- `testtools` - Check development tools (includes Windows tools)
- `install_plugins` - Install Oh My Zsh plugins

### Navigation & File Operations
- `cx <dir>` - Change directory and list contents
- `fcd` - Fuzzy find and change to directory
- `mkcd <dir>` - Create directory and cd into it
- `..` / `...` - Go up 1/2 directories

### File Search & Management
- `f` - Fuzzy find file and copy path to Windows clipboard
- `fv` - Fuzzy find and edit file with nvim
- `ff <pattern>` - Find files by name pattern
- `search_files <pattern>` - Search file contents (rg/grep)
- `extract <archive>` - Extract various archive formats (includes .exe)
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
- `lf` / `lsp` / `llp` - Various long formats
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

## 🖥️ Windows Integration Features

### Clipboard Integration
- Automatic detection of `clip.exe` for copying paths
- Cross-platform clipboard support (Linux tools as fallback)

### Windows Tools in PATH
- Windows System32 utilities
- Git for Windows commands
- VS Code Windows installation
- PowerShell 7
- Docker Desktop Windows

### File Operations
- `winopen` - Smart file/directory opening in Windows
- Path conversion utilities for seamless file sharing
- Windows executable extraction support

## 🎨 Theme & Prompt
- **Theme**: Starship with custom configuration
- **Colors**: Catppuccin Mocha theme
- **Icons**: Nerd fonts support for file types
- **Git Integration**: Branch and status indicators
- **WSL Indicator**: Shows WSL distribution name

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
- **WSL-specific Windows paths**

## 📋 Installation Requirements
```bash
# Essential tools
sudo apt install fzf bat fd-find ripgrep neovim

# Modern alternatives
sudo apt install eza zoxide starship

# Optional enhancements
sudo apt install thefuck direnv mcfly atuin

# Windows tools (auto-detected)
# - Git for Windows
# - VS Code
# - PowerShell
# - Docker Desktop
```

## 🔍 WSL-Specific Features
- **Auto-detection**: Recognizes WSL environment via `$WSL_DISTRO_NAME`
- **Path Integration**: Windows paths automatically added to PATH
- **Clipboard**: Seamless clipboard integration with Windows
- **File Operations**: Native Windows file operations from Linux
- **Cross-platform**: Commands work in both Linux and Windows contexts
- **Performance**: Optimized for WSL with proper path handling

## 💡 Pro Tips
1. Use `wpath` and `lpath` for easy path conversion between Windows/Linux
2. `winopen .` opens current directory in Windows Explorer
3. `clip` command copies directly to Windows clipboard
4. VS Code integration works seamlessly with `code` command
5. Docker commands work with Docker Desktop on Windows
6. All Linux tools work normally while maintaining Windows integration