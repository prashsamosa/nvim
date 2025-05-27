# ZSH Shortcuts & Commands Reference

## 🔥 Essential File Operations

### Directory Listing (No Permissions Shown)
```bash
ls          # List files with icons, directories first
la          # List all files (including hidden) with git status
ll          # Long listing without permissions, with git status
l           # Detailed listing with header, no permissions
lf          # Full listing without permissions
```

### Special File Views
```bash
lt          # Tree view (3 levels deep)
ltree       # Tree view (alias for lt)
lsize       # List sorted by file size
ltime       # List sorted by modification time
```

### When You Need Permissions
```bash
lsp         # List with permissions (ls with permissions)
llp         # Long list with permissions
```

## 🚀 Navigation & Search

### Fuzzy Finding
```bash
fcd         # Fuzzy find and cd to directory
fv          # Fuzzy find and edit file
f           # Fuzzy find file and copy path to clipboard
```

### Smart Navigation
```bash
cx <dir>    # Change directory and list contents
mkcd <dir>  # Create directory and cd into it
z <query>   # Jump to frequently used directories (zoxide)
```

### Directory Stack
```bash
cd -        # Go to previous directory
dirs        # Show directory stack
popd        # Pop directory from stack
pushd       # Push current directory to stack
```

## ⚡ Terminal Shortcuts

### Essential Shortcuts
```bash
c           # Clear screen
cls         # Clear screen (alias)
h           # Show history
reload      # Reload .zshrc configuration
:q          # Exit (vim-style)
:wq         # Exit (vim-style)
```

### History Navigation
```bash
Ctrl+R      # Reverse history search
Ctrl+P      # Previous command (or Up arrow)
Ctrl+N      # Next command (or Down arrow)
!!          # Repeat last command
!<num>      # Run command number <num> from history
```

## 🛠️ Development Tools

### Editor Shortcuts
```bash
v <file>    # Open file in nvim
vim <file>  # Open file in nvim (alias)
vi <file>   # Open file in nvim (alias)
zshconfig   # Edit .zshrc file
```

### Python Shortcuts
```bash
python      # Python3 (alias)
pip         # pip3 (alias)
py          # Python3 (alias)
```

### Git Operations
```bash
gst         # git status
glog        # git log with graph
gd          # git diff
gdc         # git diff --cached
gaa         # git add --all
gcm         # git commit -m
gp          # git push
gl          # git pull
gco         # git checkout
gb          # git branch
gba         # git branch -a
gacp <msg>  # Add all, commit with message, and push
```

## 🔍 File & Text Operations

### File Viewing
```bash
cat <file>  # View file with syntax highlighting (bat)
catp <file> # View file without highlighting (bat --plain)
```

### File Search
```bash
ff <name>   # Find files by name in current directory
search_files <term>  # Search text in files (ripgrep/grep)
```

### Archives
```bash
extract <file>  # Extract any archive format
tarx <file>     # Extract tar file
tarc <file>     # Create tar archive
tarz <file>     # Create compressed tar archive
```

## 💻 System Information

### Network
```bash
myip        # Get public IP address
localip     # Get local IP addresses
ports       # Show network ports
ping <host> # Ping 5 times (limited)
fastping    # Quick ping test
```

### Processes
```bash
psg <name>  # Find processes by name
topcpu      # Top 10 CPU-consuming processes
topmem      # Top 10 memory-consuming processes
fkill       # Fuzzy find and kill processes
```

## 🐳 Docker Shortcuts

```bash
d           # docker
dc          # docker-compose
dps         # docker ps
dpa         # docker ps -a
di          # docker images
drm         # Remove all containers
drmi        # Remove all images
```

## 🎯 FZF (Fuzzy Finder) Controls

### Inside FZF Interface
```bash
?           # Toggle preview window
Ctrl+A      # Select all items
Ctrl+D      # Deselect all items
Ctrl+T      # Toggle all items
Tab         # Select/deselect item
Shift+Tab   # Select/deselect item (reverse)
Enter       # Accept selection
Esc         # Cancel
Ctrl+C      # Cancel
```

### FZF Key Bindings in Terminal
```bash
Ctrl+T      # Paste selected files/dirs to command line
Ctrl+R      # Paste selected command from history
Alt+C       # cd into selected directory
```

## 🧰 Utility Functions

### File Operations
```bash
backup <file>       # Create timestamped backup of file
dsize [dir]         # Show directory size (current dir if none specified)
json <file|text>    # Pretty print JSON
```

### Fun Utilities
```bash
weather [location]  # Get weather forecast
qr <text>          # Generate QR code for text
```

## 🎨 Terminal Customization

### Starship Prompt Features
- 🌱 Git branch indicator with status
- 🐍 Python version indicator
- ⬢ Node.js version indicator
- 🦀 Rust version indicator
- 🐹 Go version indicator
- ☕ Java version indicator
- ⏱️ Command execution time (for long commands)

### Color Scheme
- Uses Catppuccin theme for consistent colors
- Enhanced syntax highlighting with bat
- Colorized directory listings with eza

## 🔧 Advanced Features

### Auto-completion
- Case-insensitive completion
- Smart completion with menu selection
- Git-aware completion
- Colorized completion matches

### History Management
- 50,000 command history
- Shared history between sessions
- Duplicate removal
- Timestamp recording
- Instant history sharing

### Performance Optimizations
- Compiled .zshrc for faster loading
- Lazy loading of tools
- Optimized PATH management
- Smart plugin loading

## 📋 WSL-Specific (Windows Subsystem for Linux)

```bash
explorer    # Open Windows Explorer
notepad     # Open Windows Notepad
clip        # Copy to Windows clipboard
winex       # Open current directory in Windows Explorer
```

## 🎯 Pro Tips

### Keyboard Shortcuts
```bash
Ctrl+A      # Move to beginning of line
Ctrl+E      # Move to end of line
Ctrl+K      # Delete from cursor to end of line
Ctrl+U      # Delete from cursor to beginning of line
Ctrl+W      # Delete word before cursor
Alt+F       # Move forward one word
Alt+B       # Move backward one word
Ctrl+L      # Clear screen (alternative to 'c')
```

### Command Line Editing
```bash
Ctrl+X+E    # Edit current command in $EDITOR
Ctrl+/      # Undo last change
Alt+.       # Insert last argument from previous command
!!          # Previous command
!$          # Last argument from previous command
!^          # First argument from previous command
```

### Globbing & Patterns
```bash
**/*.txt        # Recursive search for .txt files
*.{jpg,png}     # Match multiple extensions
file[0-9]       # Match files with numbers
^pattern        # Exclude pattern (with EXTENDED_GLOB)
```

### History Expansion
```bash
!vim            # Last command starting with 'vim'
!?search?       # Last command containing 'search'
^old^new        # Replace 'old' with 'new' in last command
!!:s/old/new    # Substitute in last command
```

## 🚨 Quick Fixes

### Common Issues
```bash
# If you get "command not found" errors:
hash -r         # Refresh command hash table

# If completion is slow:
rm ~/.zcompdump*  # Remove completion cache
compinit        # Reinitialize completion

# If history is messed up:
fc -R           # Reload history from file
```

### Performance Debugging
```bash
# Time zsh startup:
time zsh -i -c exit

# Debug zsh loading:
zsh -x
```

## 📚 Learning More

### Documentation Commands
```bash
man zsh         # ZSH manual
help            # List shell builtins
which <cmd>     # Show path of command
type <cmd>      # Show how command would be interpreted
```

### Configuration Files
```bash
~/.zshrc        # Main configuration
~/.zsh_history  # Command history
~/.config/starship.toml  # Prompt configuration
```

---

## 🎉 Remember

- Use `la` for daily file listing (no permissions clutter)
- Use `fcd` to quickly navigate to any directory
- Use `fv` to quickly open any file
- Use `Ctrl+R` for powerful history search
- Use `search_files` instead of `grep` for better results
- All file operations respect `.gitignore` and hide common junk folders

**Enjoy your supercharged terminal! 🚀**