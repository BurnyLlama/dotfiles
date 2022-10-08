### VARIABLES ###
export PATH="${PATH}:${HOME}/.local/scripts:${HOME}/.local/bin:/home/fabbe/.cargo/bin"
fpath=( ~/.config/zsh/zfunc "${fpath[@]}" )

# pnpm
export PNPM_HOME="/home/fabbe/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

#export LANG="en_GB.UTF-8"

# A character to place at the end of a line if the line doesn't end with '\n'
export PROMPT_EOL_MARK=""

# Say how long a command took, if it took more than 3 seconds
export REPORTTIME=3


### COMMAND HISTORY ###
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE



### THEME + TERMINAL + START-UP MESSAGE ###
source /data/zsh/qwik.zsh-theme
TERM=xterm-256color
echo -e "\e[34m\e[1mWelcome back, $USER!"



### VIM BINDS ###
# bindkey -v
# 
# function zle-keymap-select () {
    # case $KEYMAP in
        # vicmd) echo -ne '\e[1 q';;      # block
        # viins|main) echo -ne '\e[5 q';; # beam
    # esac
# }
# zle -N zle-keymap-select
# zle-line-init() {
    # zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    # echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
# 
# # Edit line in vim with ctrl-e:
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^e' edit-command-line
## Stolen from Luke... Hihihihi




### MODULES ###
# Colors
autoload -U colors && colors

# Tab completion
autoload -Uz compinit && compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zmodload zsh/complist
_comp_options+=(globdots) # Include files beginning with a dot (.)

# Automatically find new executables. :)
zstyle ':completion:*' rehash true

# Auto cd into typed directories
setopt autocd

# Alt + Backspace uses BASH-style deletion, not ZSH.
autoload -U select-word-style
select-word-style bash

# Line editor
autoload zed



### ALIASES ###
# Dotfile bullshit...
alias dotfile='/usr/bin/git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME'
alias .f='dotfile'

# See kernel logs with color and all...
alias kernel-logs="doas dmesg --color=always | less -R"

# Editor
alias edit="nvim"
alias vim="nvim"

# Edit config
alias zshconfig="edit ${ZDOTDIR}/.zshrc"

# Listing files and folders
alias \
	ls="lsd -h"    \
	la="ls -A"     \
	ll="ls -l"     \
	l="ls -Al"

# Verbosity :)
alias \
	cp="cp -iv" \
	mv="mv -iv" \
	rm="rm -vI"

# Auto-make parents if they don't exist with mkdir
alias mkdir="mkdir -pv"

# Get rid of that ugly .wget-hsts file...
alias wget="wget --hsts-file ~/.cache/wget-hsts"

# SQLite
SQLITE_HISTORY="${HOME}/.cache/sqlite_history"
alias sqlite3="sqlite3 --column --header"

# Colorise grep! :o
alias grep="grep --color=auto"

# Annoying lesshst... Unsure?
LESSHISTFILE=/tmp/less-hist-fabbe
#alias less='less --lesskey-file=${HOME}/.config/lesskey'
#alias man='man --pager="less --lesskey-file=${HOME}/.config/lesskey"'

# Aur helpers:
alias yay='yay --mflags "--config /etc/makepkg.conf"'
alias yay="paru"

# Portage
alias esearch='emerge --search'
alias emerge='doas emerge'
alias equ='equery uses'

# xbps
alias xq='xbps-query'
alias xi='doas xbps-install'
alias xr='doas xbps-remove'

# Clear the swap from junk:
alias swap-clear="sudo swapoff /dev/sda1 && sudo swapon /dev/sda1"

# JACK
alias jack_setup='pacmd load-module module-jack-sink sink_name=DirectOut client_name=DirectOut'

# Easily set GPU settings with dpm:
alias performance="sudo dpm-query set all high performance"
alias battery="sudo dpm-query set all low battery"
alias balanced="sudo dpm-query set all auto balanced"

# npm → pnpm
#alias npm="pnpm"

# Life hack?
alias doas="doas "

# Hhihihihi
alias luamake=/home/fabbe/.local/share/nvim/lspservers/lua-language-server/3rd/luamake/luamake

### KEYBINDS ###
bindkey -e      # Use emacs instead of vim
stty stop undef # Disable terminal freeze on ctrl-s

# Go forward/backword one word. (CTRL + < and/or CTRL + >)
bindkey "^[[1;5C"   forward-word
bindkey "^[[1;5D"   backward-word
#bindkey '^[OA'      history-substring-search-up
#bindkey '^[OB'      history-substring-search-down

# [del], [home], and [end] working:
bindkey "${terminfo[khome]}"    beginning-of-line
bindkey "${terminfo[kend]}"     end-of-line
bindkey "${terminfo[kdch1]}"    delete-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi



### DISTCC
# Know what you do ples.
#export PATH="/usr/lib/distcc/bin:$PATH"
#export DISTCC_HOSTS="localhost/15,cpp,lzo 192.168.1.86/5,cpp,lzo"
#eval `pump --startup`

#alias make='make CC=distcc CXX=distcc -j24'
#alias cmake='cmake -DCMAKE_C_COMPILER_LAUNCHER=distcc -DCMAKE_CXX_COMPILER_LAUNCHER=distcc -DCMAKE_CXX_COMPILER="g++" -DCMAKE_C_COMPILER="gcc" -Ddistcc="ON"'

### SCCACHE
export SCCACHE_DIR="/data/sccache" 
export SCCACHE_CACHE_SIZE="10G"

# RUST
export RUSTC_WRAPPER="sccache"
#export RUSTFLAGS="-C target-feature=-crt-static" # Fixes dylibs or some bullshit for musl...

### PLUGINS ###
# Auto suggestions; very pleasant.
#source /data/zsh/zsh-history-substring-search.zsh
source /data/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load syntax highlighting in the end!
source /data/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

if [[ -d /run/host ]]; then
    echo -e "\n\e[31m\e[1mIn a distrobox-container... Ignore previous sourcing errors... Sourcing properly!\n\n"
    source /run/host/data/zsh/qwik.zsh-theme
    source /run/host/data/zsh/zsh-history-substring-search.zsh
    source /run/host/data/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

    # Load syntax highlighting in the end!
    source /run/host/data/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
fi
