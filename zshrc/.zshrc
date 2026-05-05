#!/bin/zsh

# Performance: Compile .zshrc for faster loading
[[ ~/.zshrc -nt ~/.zshrc.zwc ]] && zcompile ~/.zshrc

# Skip global compinit for faster startup
export SKIP_GLOBAL_COMPINIT=1

# =============================================================================
# OH MY ZSH
# =============================================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Disabled: Starship handles the prompt

plugins=(
    git
    colored-man-pages
    command-not-found
    sudo
    copypath
    copyfile
    jsontools
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Performance optimizations
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true
CASE_SENSITIVE=false
HYPHEN_INSENSITIVE=true
DISABLE_AUTO_UPDATE=false
UPDATE_ZSH_DAYS=7
ENABLE_CORRECTION=true
COMPLETION_WAITING_DOTS=false  # Disabled: can cause glitches with Starship

source "$ZSH/oh-my-zsh.sh"

# =============================================================================
# ENVIRONMENT
# =============================================================================

# Homebrew initialization (only once, at the top of environment section)
if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERMINAL='ghostty'

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Ensure XDG directories exist (including less/ for LESSHISTFILE)
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" \
         "$XDG_CACHE_HOME/zsh" "$XDG_CACHE_HOME/less"

export LESS='-R -i -w -M -z-4'
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

# =============================================================================
# PATH
# =============================================================================

path_dirs=(
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.bun/bin"
    "/snap/bin"
)

for dir in $path_dirs; do
    [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]] && PATH="$dir:$PATH"
done
unset path_dirs

# =============================================================================
# TOOL INITIALIZATION
# =============================================================================

# ASDF - optimized path
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh" ]]; then
    source "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh"
elif [[ -f "$HOME/.asdf/asdf.sh" ]]; then
    source "$HOME/.asdf/asdf.sh"
fi

# Language-specific paths (optimized)
if command -v go >/dev/null 2>&1; then
    export GOPATH="$(go env GOPATH)"
    PATH="$GOPATH/bin:$PATH"
fi

# Cache npm prefix to avoid slow lookups
if command -v npm >/dev/null 2>&1; then
    export NPM_PREFIX="${NPM_PREFIX:-$HOME/.npm-global}"
    [[ -d "$NPM_PREFIX/bin" ]] && PATH="$NPM_PREFIX/bin:$PATH"
fi

command -v python3 >/dev/null 2>&1 && PATH="$(python3 -m site --user-base)/bin:$PATH"

# =============================================================================
# HISTORY
# =============================================================================

HISTFILE="$XDG_STATE_HOME/zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY SHARE_HISTORY HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_VERIFY HIST_REDUCE_BLANKS

# =============================================================================
# SHELL OPTIONS
# =============================================================================

setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt COMPLETE_IN_WORD ALWAYS_TO_END AUTO_MENU AUTO_LIST
setopt EXTENDED_GLOB GLOB_DOTS NO_CASE_GLOB
setopt LONG_LIST_JOBS NOTIFY CORRECT INTERACTIVE_COMMENTS

# =============================================================================
# EXTERNAL TOOLS
# =============================================================================

# Initialize modern tools
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"
command -v gh >/dev/null 2>&1 && eval "$(gh completion -s zsh)"

# FZF setup
if [[ -f "$HOME/.fzf.zsh" ]]; then
    source "$HOME/.fzf.zsh"
elif command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)" 2>/dev/null
fi

# =============================================================================
# FZF CONFIGURATION
# =============================================================================

if command -v fzf >/dev/null 2>&1; then
    # Modern file commands
    if command -v fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
    elif command -v rg >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git/*'"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi

    # Catppuccin Mocha theme with custom prompt/pointer/marker
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --prompt='▶ ' --pointer='►' --marker='✓' --bind='ctrl-a:select-all,ctrl-d:deselect-all'"

    # Previews
    command -v bat >/dev/null 2>&1 && {
        export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :100 {}'"
        export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always {} 2>/dev/null || ls -la {}'"
    }
fi

# =============================================================================
# ALIASES
# =============================================================================

# Editor
alias vim='nvim' vi='nvim' v='nvim'

# Python
command -v python3 >/dev/null 2>&1 && {
    alias python='python3' pip='pip3' py='python3'
}

# Quick navigation
alias :q='exit' :wq='exit' c='clear' cls='clear'
alias reload='source ~/.zshrc && echo "✅ Reloaded!"'
alias ..='cd ..' ...='cd ../..' ....='cd ../../..'

# Network utilities
alias myip='curl -s https://checkip.amazonaws.com'
alias localip="ip route get 1.1.1.1 | awk '{print \$NF; exit}'"
alias ports='ss -tulanp'

# Modern replacements
if command -v bat >/dev/null 2>&1; then
    alias cat='bat' catp='bat --plain'
    export BAT_THEME="Catppuccin Mocha"
fi

if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons --group-directories-first'
    alias la='eza -a --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first --git'
    alias l='eza -la --icons --group-directories-first --git'
    alias lt='eza --tree --level=3 --icons'
else
    alias ls='ls --color=auto' la='ls -a --color=auto'
    alias ll='ls -l --color=auto' l='ls -la --color=auto'
fi

# Git shortcuts
alias g='git' gst='git status' glog='git log --oneline --graph --decorate'
alias gd='git diff' gdc='git diff --cached' gaa='git add --all'
alias gcm='git commit -m' gp='git push' gl='git pull'
alias gco='git checkout' gb='git branch' gf='git fetch' gm='git merge'

# Docker
command -v docker >/dev/null 2>&1 && {
    alias d='docker' dc='docker-compose' dps='docker ps'
    alias di='docker images' dexec='docker exec -it'
    alias dclean='docker system prune -f' dlogs='docker logs -f'
}

# System management
alias sctl='sudo systemctl' jctl='sudo journalctl'
alias sstart='sudo systemctl start' sstop='sudo systemctl stop'
alias srestart='sudo systemctl restart' sstatus='systemctl status'

# Package management
alias install='sudo apt install' update='sudo apt update'
alias upgrade='sudo apt update && sudo apt upgrade -y'
alias search='apt search' remove='sudo apt remove'
alias autoremove='sudo apt autoremove' autoclean='sudo apt autoclean'

# =============================================================================
# FUNCTIONS
# =============================================================================

# Enhanced cd with listing (uses eza if available, falls back to ls -la)
cx() { cd "$@" && (command -v eza >/dev/null 2>&1 && eza -la --icons || ls -la) }

# Fuzzy navigation
fcd() {
    local dir
    if command -v fd >/dev/null 2>&1; then
        dir=$(fd --type d --hidden --follow --exclude .git | fzf --preview 'eza --tree --level=2 --color=always {} 2>/dev/null || ls -la {}')
    else
        dir=$(find . -type d | fzf --preview 'ls -la {}')
    fi
    [[ -n "$dir" ]] && cd "$dir"
}

# Fuzzy edit
fv() {
    local file
    if command -v fd >/dev/null 2>&1; then
        file=$(fd --type f --hidden --follow --exclude .git | fzf --preview 'bat --color=always --line-range :100 {} 2>/dev/null || head -100 {}')
    else
        file=$(find . -type f | fzf --preview 'head -100 {}')
    fi
    [[ -n "$file" ]] && "$EDITOR" "$file"
}

# Utilities
mkcd() { mkdir -p "$1" && cd "$1" }
backup() { cp -r "$1"{,.backup-"$(date +%Y%m%d-%H%M%S)"} }
weather() { curl -s "wttr.in/${1:-}" }
gacp() { git add --all && git commit -m "$1" && git push }

# Extract archives
extract() {
    case "$1" in
        *.tar.bz2|*.tbz2) tar xjf "$1" ;;
        *.tar.gz|*.tgz)   tar xzf "$1" ;;
        *.tar.xz|*.txz)   tar xJf "$1" ;;
        *.tar)             tar xf  "$1" ;;
        *.bz2)             bunzip2 "$1" ;;
        *.gz)              gunzip  "$1" ;;
        *.zip)             unzip   "$1" ;;
        *.7z)              7z x    "$1" ;;
        *.rar)             unrar x "$1" ;;
        *) echo "Unknown archive format: $1" ;;
    esac
}

# System info
sysinfo() {
    echo "┌── System Information ──┐"
    echo "System: $(lsb_release -d 2>/dev/null | cut -f2 || uname -s)"
    echo "Kernel: $(uname -r)"
    echo "Shell: $SHELL ($ZSH_VERSION)"
    echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
    echo "Memory: $(free -h | awk '/^Mem:/ {print $3"/"$2" ("int($3/$2*100)"%)"}')"
    echo "Disk: $(df -h / | awk 'NR==2 {print $3"/"$2" ("$5")"}')"
}

# Quick cleanup - scoped to zsh cache only to avoid nuking valid app caches
cleanup() {
    echo "🧹 Cleaning up..."
    sudo apt autoremove -y && sudo apt autoclean
    [[ -d "$XDG_CACHE_HOME/zsh" ]] && find "$XDG_CACHE_HOME/zsh" -type f -atime +7 -delete 2>/dev/null
    sudo journalctl --vacuum-time=7d
    echo "✅ Cleanup completed!"
}

# Process killer with fzf
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    [[ -n "$pid" ]] && echo "$pid" | xargs kill -"${1:-9}"
}

# =============================================================================
# COMPLETION OPTIMIZATION
# =============================================================================

# Optimized compinit - full rebuild if dump is older than 24h, else skip check
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Completion styles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# =============================================================================
# STARTUP
# =============================================================================

[[ $- == *i* ]] && echo "samosa"
