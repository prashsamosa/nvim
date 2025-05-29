export ZSH_DEBUG=${ZSH_DEBUG:-false}
[[ "$ZSH_DEBUG" == "true" ]] && set -x

if [[ ~/.zshrc -nt ~/.zshrc.zwc ]] || [[ ! -f ~/.zshrc.zwc ]]; then
    zcompile ~/.zshrc &>/dev/null
fi

export skip_global_compinit=1

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
    git z colored-man-pages command-not-found
    zsh-autosuggestions zsh-syntax-highlighting
    sudo copypath copyfile jsontools web-search
)

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

source "$ZSH/oh-my-zsh.sh"

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export LESS='-R -i -w -M -z-4'
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

path_prepend() { [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH"; }
path_append() { [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && PATH="$PATH:$1"; }

path_prepend "$HOME/bin"
path_prepend "$HOME/.local/bin"

if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if command -v brew &>/dev/null && [[ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]]; then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
elif [[ -f "$HOME/.asdf/asdf.sh" ]]; then
    source "$HOME/.asdf/asdf.sh"
fi

if command -v go &>/dev/null; then
    export GOPATH="$(go env GOPATH)"
    path_append "$(go env GOPATH)/bin"
fi

path_append "$HOME/.cargo/bin"

if [[ -d "$HOME/.rbenv" ]]; then
    path_prepend "$HOME/.rbenv/bin"
    eval "$(rbenv init - zsh)"
fi

if command -v npm &>/dev/null; then
    path_append "$(npm config get prefix)/bin"
fi

if command -v python3 &>/dev/null; then
    path_append "$(python3 -m site --user-base)/bin"
fi

path_append "$HOME/.deno/bin"
path_append "$HOME/.bun/bin"
path_append "/snap/bin"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY SHARE_HISTORY HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_VERIFY HIST_REDUCE_BLANKS

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT PUSHD_TO_HOME
setopt COMPLETE_IN_WORD ALWAYS_TO_END AUTO_MENU AUTO_LIST AUTO_PARAM_SLASH
setopt COMPLETE_ALIASES EXTENDED_GLOB GLOB_DOTS NO_CASE_GLOB NUMERIC_GLOB_SORT
setopt AUTO_CONTINUE LONG_LIST_JOBS NOTIFY CORRECT CORRECT_ALL INTERACTIVE_COMMENTS

mkdir -p "$HOME/.config"

if [[ ! -f "$HOME/.config/starship.toml" ]]; then
    cat > "$HOME/.config/starship.toml" << 'EOF'
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
$docker_context\
$aws\
$gcloud\
$cmd_duration\
$line_break\
$character"""

command_timeout = 5000

[directory]
truncation_length = 3
truncate_to_repo = true
style = "blue bold"
read_only = " 🔒"

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
detect_extensions = ["py"]
version_format = "v${raw}"

[nodejs]
symbol = "⬢ "
detect_files = ["package.json", ".nvmrc"]
version_format = "v${raw}"

[rust]
symbol = "🦀 "
detect_files = ["Cargo.toml"]

[golang]
symbol = "🐹 "
detect_files = ["go.mod", "go.sum"]

[java]
symbol = "☕ "
detect_files = ["pom.xml", "build.gradle.kts", "build.sbt", ".java-version"]

[docker_context]
symbol = "🐳 "
only_with_files = false

[aws]
symbol = "☁️ "
format = 'on [$symbol($profile )(\($region\) )]($style)'

[gcloud]
symbol = "☁️ "
format = 'on [$symbol$account(@$domain)(\($region\))]($style) '

[package]
symbol = "📦 "
EOF
fi

if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

if [[ -f "$HOME/.fzf.zsh" ]]; then
    source "$HOME/.fzf.zsh"
elif command -v fzf &>/dev/null; then
    if fzf --version 2>&1 | grep -q -- '--zsh'; then
        eval "$(fzf --zsh 2>/dev/null || true)"
    fi
fi

if command -v fzf &>/dev/null; then
    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .npm --exclude .cache"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git --exclude node_modules --exclude .npm --exclude .cache"
        _fzf_compgen_path() { fd --hidden --follow --exclude .git --exclude node_modules . "$1"; }
        _fzf_compgen_dir() { fd --type d --hidden --follow --exclude .git --exclude node_modules . "$1"; }
    elif command -v rg &>/dev/null; then
        export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git/*' --glob '!node_modules/*' --glob '!.npm/*' --glob '!.cache/*'"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    else
        export FZF_DEFAULT_COMMAND="find . -path '*/.*' -prune -o -type f -print 2>/dev/null | sed 's|^\./||'"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="find . -path '*/.*' -prune -o -type d -print 2>/dev/null | sed 's|^\./||'"
    fi

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
        --bind='ctrl-u:preview-up,ctrl-d:preview-down'
        --bind='ctrl-f:preview-page-down,ctrl-b:preview-page-up'
        --preview-window='right:50%:wrap'"

    if command -v eza &>/dev/null && command -v bat &>/dev/null; then
        show_file_or_dir_preview="if [[ -d {} ]]; then eza --tree --color=always --level=2 {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
    elif command -v bat &>/dev/null; then
        show_file_or_dir_preview="if [[ -d {} ]]; then ls -la --color=always {}; else bat -n --color=always --line-range :500 {}; fi"
    else
        show_file_or_dir_preview="if [[ -d {} ]]; then ls -la {}; else head -500 {}; fi"
    fi

    export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
    export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --level=2 {} 2>/dev/null || ls -la --color=always {}'"

    _fzf_comprun() {
        local command=$1; shift
        case "$command" in
            cd) fzf --preview 'eza --tree --color=always --level=2 {} 2>/dev/null || ls -la --color=always {}' "$@" ;;
            export|unset) fzf --preview "eval 'echo \${}'" "$@" ;;
            ssh) fzf --preview 'dig {}' "$@" ;;
            *) fzf --preview "$show_file_or_dir_preview" "$@" ;;
        esac
    }
fi

command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
command -v thefuck &>/dev/null && eval "$(thefuck --alias)" && eval "$(thefuck --alias fk)"
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"
command -v mcfly &>/dev/null && eval "$(mcfly init zsh)"
command -v atuin &>/dev/null && eval "$(atuin init zsh)"
command -v gh &>/dev/null && eval "$(gh completion -s zsh)"

alias vim='nvim' vi='nvim' v='nvim'
if command -v python3 &>/dev/null; then
    alias python='python3' pip='pip3' py='python3'
fi

alias :q='exit' :wq='exit' c='clear' cls='clear' h='history'
alias reload='source ~/.zshrc && echo "ZSH reloaded!"'
alias zshconfig='$EDITOR ~/.zshrc'
alias ..='cd ..' ...='cd ../..'

alias myip='curl -s http://checkip.amazonaws.com'
alias localip="ip route get 1 | awk '{print \$NF; exit}'"
alias ports='ss -tulanp'

if command -v bat &>/dev/null; then
    alias cat='bat' catp='bat --plain' catraw='/bin/cat'
    export BAT_THEME="Catppuccin-mocha"
fi

if command -v eza &>/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias la='eza -a --icons --group-directories-first --git'
    alias ll='eza -l --icons --group-directories-first --git'
    alias l='eza -la --icons --group-directories-first --git --header'
    alias lf='eza -la --icons --group-directories-first --git'
    alias lt='eza --tree --level=3 --icons --git'
    alias ltree='eza --tree --level=3 --icons --git'
    alias lsize='eza -la --icons --group-directories-first --git --sort=size'
    alias ltime='eza -la --icons --group-directories-first --git --sort=modified'
else
    alias ls='ls --color=auto' la='ls -a --color=auto'
    alias ll='ls -l --color=auto --time-style=long-iso'
    alias l='ls -la --color=auto --time-style=long-iso'
    alias lf='ls -la --color=auto --time-style=long-iso'
fi

alias gst='git status' glog='git log --oneline --graph --decorate --all'
alias gd='git diff' gdc='git diff --cached' gaa='git add --all'
alias gcm='git commit -m' gp='git push' gl='git pull'
alias gco='git checkout' gb='git branch' gba='git branch -a'

if command -v docker &>/dev/null; then
    alias d='docker' dc='docker-compose' dps='docker ps' dpa='docker ps -a'
    alias di='docker images' dlog='docker logs' dexec='docker exec -it'
    alias drm='docker rm $(docker ps -aq)'
    alias drmi='docker rmi $(docker images -q)'
fi

alias psg='ps aux | grep'
alias topcpu='ps aux --sort=-%cpu | head -10'
alias topmem='ps aux --sort=-%mem | head -10'
alias top10='topcpu'
alias ping='ping -c 5' fastping='ping -c 100 -s.2'
alias tarx='tar -xvf' tarc='tar -cvf' tarz='tar -czvf'
alias serve='python3 -m http.server' path='echo "$PATH" | tr ":" "\n"'
alias npmls='npm list --depth=0'

alias install='sudo apt install' update='sudo apt update && sudo apt upgrade -y'
alias search='apt search' remove='sudo apt remove' autoremove='sudo apt autoremove'

cx() { cd "$@" && (command -v eza &>/dev/null && eza -la --icons --git || ls -la); }

fcd() {
    local dir
    if command -v fd &>/dev/null; then
        dir=$(fd --type d --hidden --exclude .git --exclude node_modules | fzf --preview 'eza --tree --color=always --level=2 {} 2>/dev/null || ls -la {}')
    else
        dir=$(find . -type d -not -path '*/\.*' -not -path '*/node_modules/*' | fzf --preview 'ls -la {}')
    fi
    [[ -n "$dir" ]] && cd "$dir" && (command -v eza &>/dev/null && eza -la --icons --git || ls -la)
}

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
            echo "No clipboard utility found"
        fi
        echo "Path copied: $abs_path"
    fi
}

fv() {
    local file
    if command -v fd &>/dev/null; then
        file=$(fd --type f --hidden --exclude .git --exclude node_modules | fzf --preview 'bat --color=always --line-range :500 {} 2>/dev/null || head -500 {}')
    else
        file=$(find . -type f -not -path '*/\.*' -not -path '*/node_modules/*' | fzf --preview 'head -500 {}')
    fi
    [[ -n "$file" ]] && "$EDITOR" "$file"
}

mkcd() { [[ -z "$1" ]] && { echo "Usage: mkcd <directory>"; return 1; }; mkdir -p "$1" && cd "$1"; }

extract() {
    [[ ! -f "$1" ]] && { echo "Error: '$1' is not a valid file"; return 1; }
    case "$1" in
        *.tar.bz2|*.tbz2) tar xjf "$1" ;;
        *.tar.gz|*.tgz) tar xzf "$1" ;;
        *.tar.xz|*.txz) tar xJf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *.xz) unxz "$1" ;;
        *) echo "Error: '$1' - unknown archive method" ;;
    esac
}

gacp() { [[ -z "$1" ]] && { echo "Usage: gacp <message>"; return 1; }; git add --all && git commit -m "$1" && git push; }

fkill() {
    local pid
    if [[ "$UID" != "0" ]]; then
        pid=$(ps -f -u "$UID" | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi
    [[ -n "$pid" ]] && echo "$pid" | xargs kill -"${1:-9}"
}

backup() { [[ -z "$1" ]] && { echo "Usage: backup <file>"; return 1; }; cp "$1"{,.backup-"$(date +%Y%m%d-%H%M%S)"}; }

weather() {
    local location="${1:-}"
    if ! command -v curl &>/dev/null; then
        echo "❌ curl required"; return 1
    fi
    local weather_data=$(curl -s --connect-timeout 5 --max-time 10 "http://wttr.in/${location}" 2>/dev/null)
    [[ -z "$weather_data" || "$weather_data" =~ "ERROR" ]] && { echo "❌ Unable to fetch weather data"; return 1; }
    echo "$weather_data"
}

qr() {
    [[ -z "$1" ]] && { echo "Usage: qr <text>"; return 1; }
    local qr_code=$(curl -s --connect-timeout 5 "http://qrenco.de/$1" 2>/dev/null)
    [[ -z "$qr_code" ]] && { echo "❌ Unable to generate QR code"; return 1; }
    echo "$qr_code"
}

json() {
    if [[ -f "$1" ]]; then
        python3 -m json.tool "$1"
    else
        echo "$1" | python3 -m json.tool
    fi
}

dsize() { du -sh "${1:-.}" | cut -f1; }
ff() { find . -type f -name "*${1}*" 2>/dev/null; }
search_files() { command -v rg &>/dev/null && rg "$@" || grep -r "$@" .; }

tree() {
    if command -v eza &>/dev/null; then
        eza --tree --level="${1:-3}" --icons --git
    elif command -v tree &>/dev/null; then
        command tree -L "${1:-3}" -C
    else
        find . -type d | head -20 | sed 's;[^/]*/;|____;g;s;____|; |;g'
    fi
}

note() {
    local note_file="$HOME/.notes/$(date +%Y-%m-%d).md"
    mkdir -p "$(dirname "$note_file")"
    if [[ $# -eq 0 ]]; then
        "$EDITOR" "$note_file"
    else
        echo "$(date '+%H:%M') - $*" >> "$note_file"
    fi
}

webserver() { python3 -m http.server "${1:-8000}"; }

sysupdate() {
    echo "🔄 Updating system packages..."
    if command -v apt &>/dev/null; then
        sudo apt update && sudo apt upgrade -y
    elif command -v yum &>/dev/null; then
        sudo yum update -y
    elif command -v pacman &>/dev/null; then
        sudo pacman -Syu
    elif command -v brew &>/dev/null; then
        brew update && brew upgrade
    else
        echo "No supported package manager found"
    fi
}

testtools() {
    local tools=("git" "starship" "zoxide" "fzf" "eza" "bat" "fd" "rg" "nvim")
    echo "🔍 Checking tools:"
    for tool in "${tools[@]}"; do
        command -v "$tool" &>/dev/null && echo "  ✅ $tool" || echo "  ❌ $tool"
    done
    echo ""
    echo "📦 Install missing tools:"
    echo "  sudo apt install fzf bat fd-find ripgrep neovim"
}

sysinfo() {
    echo "💻 System Info:"
    echo "OS: $(uname -s -r)"
    echo "Shell: $SHELL ($ZSH_VERSION)"
    echo "Editor: $EDITOR"
    command -v starship &>/dev/null && echo "Prompt: Starship $(starship --version | head -1)"
}

install_plugins() {
    echo "🔧 Installing Oh My Zsh plugins..."
    [[ ! -d "$ZSH/custom/plugins/zsh-autosuggestions" ]] && {
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    }
    [[ ! -d "$ZSH/custom/plugins/zsh-syntax-highlighting" ]] && {
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    }
    echo "✅ Complete. Restart shell or run: source ~/.zshrc"
}

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

unset -f path_prepend path_append

echo "🚀 ZSH loaded successfully!"