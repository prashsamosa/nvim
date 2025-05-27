# =============================================================================
# ZSH CONFIGURATION - Enhanced Version
# =============================================================================

# Performance optimization - compile config if needed
if [[ ~/.zshrc -nt ~/.zshrc.zwc ]] || [[ ! -f ~/.zshrc.zwc ]]; then
    zcompile ~/.zshrc &>/dev/null
fi

# Skip global compinit for faster startup
skip_global_compinit=1

# =============================================================================
# OH MY ZSH SETUP
# =============================================================================

export ZSH="$HOME/.oh-my-zsh"

# Theme selection
ZSH_THEME="robbyrussell"

# Plugin configuration
plugins=(
    git
    z
    colored-man-pages
    command-not-found
    zsh-autosuggestions
    zsh-syntax-highlighting
    # Note: zsh-syntax-highlighting should be last
)

# Oh My Zsh settings
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="false"
export UPDATE_ZSH_DAYS=7
DISABLE_MAGIC_FUNCTIONS="false"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# =============================================================================
# PATH CONFIGURATION
# =============================================================================

# Function to safely add to PATH
path_prepend() {
    [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH"
}

path_append() {
    [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && PATH="$PATH:$1"
}

# Personal bin directories
path_prepend "$HOME/bin"
path_prepend "$HOME/.local/bin"

# Homebrew setup (macOS and Linux)
if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ASDF version manager
if command -v brew &>/dev/null && [[ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]]; then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
elif [[ -f "$HOME/.asdf/asdf.sh" ]]; then
    source "$HOME/.asdf/asdf.sh"
fi

# Programming language paths
# Go
if command -v go &>/dev/null; then
    export GOPATH="$(go env GOPATH)"
    path_append "$(go env GOPATH)/bin"
fi

# Rust/Cargo
path_append "$HOME/.cargo/bin"

# Ruby/rbenv
if [[ -d "$HOME/.rbenv" ]]; then
    path_prepend "$HOME/.rbenv/bin"
    eval "$(rbenv init - zsh)"
fi

# Node.js/npm global packages
if command -v npm &>/dev/null; then
    path_append "$(npm config get prefix)/bin"
fi

# Python/pip user packages
if command -v python3 &>/dev/null; then
    path_append "$(python3 -m site --user-base)/bin"
fi

# =============================================================================
# HISTORY CONFIGURATION
# =============================================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

# History options
setopt EXTENDED_HISTORY          # Write timestamps to history
setopt SHARE_HISTORY            # Share history between sessions
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicates first
setopt HIST_IGNORE_DUPS         # Don't record duplicates
setopt HIST_IGNORE_ALL_DUPS     # Remove older duplicates
setopt HIST_FIND_NO_DUPS        # Don't show duplicates in search
setopt HIST_IGNORE_SPACE        # Don't record commands starting with space
setopt HIST_SAVE_NO_DUPS        # Don't save duplicates
setopt HIST_VERIFY              # Verify history expansion
setopt HIST_BEEP               # Beep on history errors

# Key bindings for history search
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^R' history-incremental-search-backward

# =============================================================================
# ZSH OPTIONS
# =============================================================================

# Directory navigation
setopt AUTO_CD              # Change directory without cd
setopt AUTO_PUSHD           # Automatically push directories to stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicate directories
setopt PUSHD_SILENT         # Don't print directory stack

# Completion
setopt COMPLETE_IN_WORD     # Complete from both ends of word
setopt ALWAYS_TO_END        # Move cursor to end after completion
setopt AUTO_MENU            # Show completion menu on tab
setopt AUTO_LIST            # List choices on ambiguous completion
setopt AUTO_PARAM_SLASH     # Add slash after directory completion

# Globbing
setopt EXTENDED_GLOB        # Use extended globbing
setopt GLOB_DOTS           # Match dotfiles without explicit dot

# Job control
setopt AUTO_CONTINUE        # Background jobs continue when disowned
setopt LONG_LIST_JOBS       # Show jobs in long format
setopt NOTIFY              # Report job status immediately

# =============================================================================
# STARSHIP PROMPT CONFIGURATION
# =============================================================================

# Ensure config directory exists
mkdir -p ~/.config

# Enhanced starship config
if [[ ! -f ~/.config/starship.toml ]]; then
    cat > ~/.config/starship.toml << 'EOF'
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$python\
$nodejs\
$rust\
$golang\
$java\
$cmd_duration\
$line_break\
$character"""

command_timeout = 5000

[directory]
truncation_length = 3
truncate_to_repo = true
style = "blue bold"

[git_branch]
symbol = "🌱 "
style = "bright-green bold"

[git_status]
conflicted = "⚡"
ahead = "⇡"
behind = "⇣"
diverged = "⇕"
up_to_date = ""
untracked = "?"
stashed = "$"
modified = "!"
staged = "+"
renamed = "»"
deleted = "✘"

[character]
success_symbol = "[❯](purple)"
error_symbol = "[❯](red)"
vicmd_symbol = "[❮](green)"

[cmd_duration]
min_time = 2000
format = "took [$duration](bold yellow)"

[python]
symbol = "🐍 "

[nodejs]
symbol = "⬢ "

[rust]
symbol = "🦀 "

[golang]
symbol = "🐹 "

[java]
symbol = "☕ "
EOF
fi

# Initialize starship
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# =============================================================================
# FZF (FUZZY FINDER) CONFIGURATION
# =============================================================================

# FZF installation check and setup
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
elif command -v fzf &>/dev/null; then
    # Modern fzf setup
    if fzf --version 2>&1 | grep -q -- '--zsh'; then
        eval "$(fzf --zsh 2>/dev/null || true)"
    fi
fi

if command -v fzf &>/dev/null; then
    # Enhanced FZF commands
    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude node_modules"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git --exclude node_modules"

        _fzf_compgen_path() { fd --hidden --follow --exclude .git --exclude node_modules . "$1"; }
        _fzf_compgen_dir() { fd --type d --hidden --follow --exclude .git --exclude node_modules . "$1"; }
    elif command -v rg &>/dev/null; then
        export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git/*' --glob '!node_modules/*'"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    else
        export FZF_DEFAULT_COMMAND="find . -type f -not -path '*/\.*' -not -path '*/node_modules/*' -not -path '*/.git/*'"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="find . -type d -not -path '*/\.*' -not -path '*/node_modules/*' -not -path '*/.git/*'"
    fi

    # Enhanced FZF options with better colors and previews
    export FZF_DEFAULT_OPTS="
        --height 40% --layout=reverse --border --margin=1 --padding=1
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
        --prompt='❯ ' --pointer='▶' --marker='✓'
        --bind='?:toggle-preview'
        --bind='ctrl-a:select-all'
        --bind='ctrl-d:deselect-all'
        --bind='ctrl-t:toggle-all'
        --preview-window='right:50%:wrap'"

    # Enhanced preview commands
    if command -v eza &>/dev/null && command -v bat &>/dev/null; then
        show_file_or_dir_preview="if [[ -d {} ]]; then eza --tree --color=always --level=2 {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
    elif command -v bat &>/dev/null; then
        show_file_or_dir_preview="if [[ -d {} ]]; then ls -la --color=always {}; else bat -n --color=always --line-range :500 {}; fi"
    else
        show_file_or_dir_preview="if [[ -d {} ]]; then ls -la {}; else head -500 {}; fi"
    fi

    export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
    export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --level=2 {} 2>/dev/null || ls -la --color=always {}'"

    # Custom completion function
    _fzf_comprun() {
        local command=$1; shift
        case "$command" in
            cd)           fzf --preview 'eza --tree --color=always --level=2 {} 2>/dev/null || ls -la --color=always {}' "$@" ;;
            export|unset) fzf --preview "eval 'echo \${}'" "$@" ;;
            ssh)          fzf --preview 'dig {}' "$@" ;;
            *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
        esac
    }
fi

# =============================================================================
# TOOL INTEGRATIONS
# =============================================================================

# Zoxide (smart directory jumping)
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# The Fuck (command correction)
if command -v thefuck &>/dev/null; then
    eval "$(thefuck --alias)"
    eval "$(thefuck --alias fk)"
fi

# Direnv (environment management)
if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

# McFly (intelligent history search)
if command -v mcfly &>/dev/null; then
    eval "$(mcfly init zsh)"
fi

# =============================================================================
# ALIASES & SHORTCUTS
# =============================================================================

# Editor aliases
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Python aliases
alias python='python3'
alias pip='pip3'
alias py='python3'

# Shell convenience
alias :q='exit'
alias :wq='exit'
alias c='clear'
alias cls='clear'
alias h='history'
alias reload='source ~/.zshrc && echo "ZSH config reloaded!"'
alias zshconfig='$EDITOR ~/.zshrc'

# System information
alias myip='curl -s http://checkip.amazonaws.com'
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ports='netstat -tulanp'

# Enhanced file operations
if command -v bat &>/dev/null; then
    alias cat='bat'
    alias catp='bat --plain'
    export BAT_THEME="Catppuccin-mocha"
fi

# File listing without permissions - REFINED FOR YOUR REQUEST
if command -v eza &>/dev/null; then
    # Standard listing without permissions
    alias ls='eza --icons --group-directories-first --no-permissions'
    alias la='eza -a --icons --group-directories-first --no-permissions --git'
    alias ll='eza -l --icons --group-directories-first --no-permissions --git'
    alias l='eza -la --icons --group-directories-first --no-permissions --git --header'
    alias lf='eza -la --icons --group-directories-first --no-permissions --git'  # Full listing without permissions

    # Special aliases with different views
    alias lt='eza --tree --level=3 --icons --git --no-permissions'
    alias ltree='eza --tree --level=3 --icons --git --no-permissions'
    alias lsize='eza -la --icons --group-directories-first --git --sort=size --no-permissions'
    alias ltime='eza -la --icons --group-directories-first --git --sort=modified --no-permissions'

    # If you ever need permissions, use these
    alias lsp='eza -la --icons --group-directories-first --git'  # ls with permissions
    alias llp='eza -l --icons --group-directories-first --git'   # ll with permissions
else
    # Fallback for systems without eza - using ls with custom format
    alias ls='ls --color=auto'
    alias la='ls -a --color=auto'
    alias ll='ls -l --color=auto --time-style=long-iso'
    alias l='ls -la --color=auto --time-style=long-iso'
    alias lf='ls -la --color=auto --time-style=long-iso'
fi

# Git aliases (additional to Oh My Zsh git plugin)
alias gst='git status'
alias glog='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gdc='git diff --cached'
alias gaa='git add --all'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gba='git branch -a'

# Docker aliases
if command -v docker &>/dev/null; then
    alias d='docker'
    alias dc='docker-compose'
    alias dps='docker ps'
    alias dpa='docker ps -a'
    alias di='docker images'
    alias drm='docker rm $(docker ps -aq)'
    alias drmi='docker rmi $(docker images -q)'
fi

# Process management
alias psg='ps aux | grep'
alias topcpu='ps aux --sort=-%cpu | head -10'
alias topmem='ps aux --sort=-%mem | head -10'

# Network
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'

# Archives
alias tarx='tar -xvf'
alias tarc='tar -cvf'
alias tarz='tar -czvf'

# =============================================================================
# CUSTOM FUNCTIONS
# =============================================================================

# Enhanced directory navigation
cx() {
    cd "$@" && (command -v eza &>/dev/null && eza -la --icons --git --no-permissions || ls -la)
}

# Fuzzy directory search and navigation
fcd() {
    local dir
    if command -v fd &>/dev/null; then
        dir=$(fd --type d --hidden --exclude .git --exclude node_modules | fzf --preview 'eza --tree --color=always --level=2 --no-permissions {} 2>/dev/null || ls -la {}')
    else
        dir=$(find . -type d -not -path '*/\.*' -not -path '*/node_modules/*' | fzf --preview 'ls -la {}')
    fi
    [[ -n "$dir" ]] && cd "$dir" && (command -v eza &>/dev/null && eza -la --icons --git --no-permissions || ls -la)
}

# Enhanced file finder with clipboard support
f() {
    local file
    if command -v fd &>/dev/null; then
        file=$(fd --type f --hidden --exclude .git --exclude node_modules | fzf --preview 'bat --color=always --line-range :500 {} 2>/dev/null || head -500 {}')
    else
        file=$(find . -type f -not -path '*/\.*' -not -path '*/node_modules/*' | fzf --preview 'head -500 {}')
    fi

    if [[ -n "$file" ]]; then
        local abs_path=$(realpath "$file")
        if command -v pbcopy &>/dev/null; then
            echo -n "$abs_path" | pbcopy
        elif command -v xclip &>/dev/null; then
            echo -n "$abs_path" | xclip -selection clipboard
        elif command -v wl-copy &>/dev/null; then
            echo -n "$abs_path" | wl-copy
        else
            echo "No clipboard utility found (pbcopy, xclip, wl-copy)"
        fi
        echo "Path copied: $abs_path"
    fi
}

# Fuzzy file editor
fv() {
    local file
    if command -v fd &>/dev/null; then
        file=$(fd --type f --hidden --exclude .git --exclude node_modules | fzf --preview 'bat --color=always --line-range :500 {} 2>/dev/null || head -500 {}')
    else
        file=$(find . -type f -not -path '*/\.*' -not -path '*/node_modules/*' | fzf --preview 'head -500 {}')
    fi
    [[ -n "$file" ]] && $EDITOR "$file"
}

# Enhanced mkdir with cd
mkcd() {
    [[ -z "$1" ]] && { echo "Usage: mkcd <directory>"; return 1; }
    mkdir -p "$1" && cd "$1"
}

# Enhanced extract function
extract() {
    if [[ ! -f "$1" ]]; then
        echo "Error: '$1' is not a valid file"
        return 1
    fi

    case "$1" in
        *.tar.bz2|*.tbz2) tar xjf "$1" ;;
        *.tar.gz|*.tgz)   tar xzf "$1" ;;
        *.tar.xz|*.txz)   tar xJf "$1" ;;
        *.bz2)            bunzip2 "$1" ;;
        *.rar)            unrar x "$1" ;;
        *.gz)             gunzip "$1" ;;
        *.tar)            tar xf "$1" ;;
        *.zip)            unzip "$1" ;;
        *.Z)              uncompress "$1" ;;
        *.7z)             7z x "$1" ;;
        *.xz)             unxz "$1" ;;
        *.exe)            cabextract "$1" ;;
        *)                echo "Error: '$1' - unknown archive method" ;;
    esac
}

# Git utilities
gacp() {
    [[ -z "$1" ]] && { echo "Usage: gacp <commit-message>"; return 1; }
    git add --all && git commit -m "$1" && git push
}

# Find and kill process
fkill() {
    local pid
    if [[ "$UID" != "0" ]]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [[ -n "$pid" ]]; then
        echo "$pid" | xargs kill -${1:-9}
    fi
}

# Create backup of file
backup() {
    [[ -z "$1" ]] && { echo "Usage: backup <file>"; return 1; }
    cp "$1"{,.backup-$(date +%Y%m%d-%H%M%S)}
}

# Weather function
weather() {
    local location="${1:-}"
    curl -s "http://wttr.in/${location}"
}

# QR code generator
qr() {
    [[ -z "$1" ]] && { echo "Usage: qr <text>"; return 1; }
    curl -s "http://qrenco.de/$1"
}

# JSON pretty print
json() {
    if [[ -f "$1" ]]; then
        python3 -m json.tool "$1"
    else
        echo "$1" | python3 -m json.tool
    fi
}

# Size of directory
dsize() {
    du -sh "${1:-.}" | cut -f1
}

# Quick find in current directory
ff() {
    find . -type f -name "*${1}*" 2>/dev/null
}

# Quick grep in files - renamed to avoid conflicts
search_files() {
    if command -v rg &>/dev/null; then
        rg "$@"
    else
        grep -r "$@" .
    fi
}

# =============================================================================
# COMPLETION ENHANCEMENTS
# =============================================================================

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Completion menu
zstyle ':completion:*' menu select

# Colors in completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Group matches and describe
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# =============================================================================
# WSL SPECIFIC CONFIGURATIONS
# =============================================================================

# WSL clipboard integration
if grep -qi microsoft /proc/version 2>/dev/null; then
    # WSL utilities
    alias explorer='/mnt/c/Windows/explorer.exe'
    alias notepad='/mnt/c/Windows/notepad.exe'

    # Better WSL clipboard function
    clip() {
        if [[ $# -eq 0 ]]; then
            clip.exe
        else
            echo "$@" | clip.exe
        fi
    }

    # Open current directory in Windows Explorer
    alias winex='explorer.exe .'
fi

# =============================================================================
# WELCOME MESSAGE & CLEANUP
# =============================================================================

# Clean up functions
unset -f path_prepend path_append


# Display welcome message with system info
echo "🚀 ZSH environment loaded successfully!"
# The following lines are commented out to only show the above message:
# if command -v starship &>/dev/null; then echo "✨ Starship prompt active"; fi
# if command -v fzf &>/dev/null; then echo "🔍 FZF fuzzy finder ready"; fi
# if command -v zoxide &>/dev/null; then echo "📍 Zoxide smart navigation enabled"; fi
# if command -v eza &>/dev/null; then echo "📁 Enhanced file listing (no permissions) active"; fi
# if command -v bat &>/dev/null; then echo "🦇 Syntax highlighting with bat enabled"; fi

# Quick tips on first load - commented out
# if [[ ! -f ~/.zsh_setup_complete ]]; then
#     echo ""
#     echo "💡 Quick Tips:"
#     echo "   • Use 'la' to list all files (no permissions shown)"
#     echo "   • Use 'fcd' for fuzzy directory navigation"
#     echo "   • Use 'fv' to fuzzy find and edit files"
#     echo "   • Use Ctrl+R for enhanced history search"
#     # echo "   • Use 'lsp' if you need to see permissions" # This line is already commented out
#     echo ""
#     touch ~/.zsh_setup_complete
# fi
