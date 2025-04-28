### DEFERING ###
# Allow defering of slower tasks...
source ${ZDOTDIR}/zsh-defer/zsh-defer.plugin.zsh



### PATH ###
export PATH="${HOME}/.local/scripts:${HOME}/.local/bin:${HOME}/.cargo/bin:${HOME}/.config/composer/vendor/bin:${PATH}"
export fpath=( ~/.config/zsh/.zfunc "${fpath[@]}" )




### THEME + TERMINAL + START-UP MESSAGE ###
source "${ZDOTDIR}/theme.zsh"
TERM=xterm-256color
echo -e "\e[34m\e[1mBeinvenue au terminal, $USER!\e[39m"



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
zmodload zsh/complist
_comp_options+=(globdots) # Include files beginning with a dot (.)

# Styling of menus and such...
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu none
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:descriptions' format '[%d]'

# Automatically find new executables. :)
zstyle ':completion:*' rehash true

# Auto cd into typed directories
setopt autocd

# Alt + Backspace uses BASH-style deletion, not ZSH.
autoload -U select-word-style
select-word-style bash

# Line editor
autoload zed



### FZF previews ###
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# Min height
zstyle ':fzf-tab:*' fzf-min-height 12
# Directories previews
#zstyle ':fzf-tab:complete:*:*' fzf-preview 'lsd --color always --icon always --icon-theme fancy $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'zsh-fzf-dispatcher'
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
# Preview man pages
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'
# Preview variables.
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'



### VARIABLES ###
# A character to place at the end of a line if the line doesn't end with '\n'
export PROMPT_EOL_MARK=""

# Say how long a command took, if it took more than 3 seconds
export REPORTTIME=3

# Uhhh, found this on the interwebs... https://github.com/fdellwing/zsh-bat/blob/master/zsh-bat.plugin.zsh
# Added --paging=always since I disabled paging for bat...
export MANPAGER="sh -c 'col -bx | bat -l man --paging=always -p'"



### COMMAND HISTORY ###
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups



### ALIASES ###
# git
alias gita="git status --short -M | fzf -m --ansi --preview='git diff --color-words {2}' | awk '{print \$2}' | xargs -- git add"

# Dotfile bullshit...
alias dotfile='/usr/bin/git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME'
alias .f='dotfile'
alias .fa="git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME status --short -M | fzf -m --ansi --preview='git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME diff --color-words {2}' | awk '{print \$2}' | xargs -- git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME add"
alias dotfile-detect-hard-coded-user="dotfile ls-tree -r main --name-only | xargs grep --line-number $USER 2> /dev/null"

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

# aria2
alias aria2c="aria2c -x 16 -j 16 -s 16"

# SQLite
SQLITE_HISTORY="${HOME}/.cache/sqlite_history"
alias sqlite3="sqlite3 --column --header"

# Colorise grep! :o
alias grep="grep --color=auto"

# Colorise cat (by using bat)
alias cat="bat"

# Colorise commands with grc
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh
[[ -s "/usr/share/grc/grc.zsh" ]] && source /usr/share/grc/grc.zsh

# FZF theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#6B6B94,current-fg:#FCFCFF,bg:-1,current-bg:-1
  --color=hl:#2184DB,current-hl:#5fd7ff,info:#8484AE,marker:#C3E344
  --color=prompt:#27E596,spinner:#27E596,pointer:#2FEBEB,header:#27E596
  --color=border:#3B3B5E,scrollbar:#52527A,preview-fg:#FCFCFF,label:#CECEE3
  --color=query:#CECEE3
  --border="rounded" --border-label="" --preview-window="border-rounded" --padding="0,1"
  --margin="1" --prompt="  " --marker=" " --pointer=" "
  --separator="─" --scrollbar="┃" --layout="reverse"'

# Annoying lesshst... Unsure?
LESSHISTFILE="/tmp/less-hist-$USER"
#alias less='less --lesskey-file=${HOME}/.config/lesskey'
#alias man='man --pager="less --lesskey-file=${HOME}/.config/lesskey"'

# Aur helpers:
alias yay='yay --mflags "--config /etc/makepkg.conf"'
alias yay="paru"

# Kernel compile on Gentoo
alias kcd='cd /usr/src/linux'
#alias kmake='make INSTALL_PATH=/boot/EFI/gentoo/ CC=clang LLVM=1 LLVM_IAS=1 -j12'
alias kmake='/usr/bin/make INSTALL_PATH=/boot/EFI/gentoo/ KBUILD_OUTPUT=${HOME}/Development/KERNEL -j12'
alias kconf-cp='zcat /proc/config.gz > ${HOME}/Development/KERNEL/.config && kmake oldconfig'
function mkinitramfs {
    KERNEL_VER=$1
    doas dracut --zstd --kernel-image /boot/EFI/gentoo/vmlinuz-${KERNEL_VER}-gentoo -f -p -H --no-kernel --early-microcode /boot/EFI/gentoo/initramfs-${KERNEL_VER}-gentoo.img
}
function mkinitramfs-rev {
    KERNEL_VER=$1
    KERNEL_REV=$2
    doas dracut --zstd --kernel-image /boot/EFI/gentoo/vmlinuz-${KERNEL_VER}-gentoo-r${KERNEL_REV} -f -p -H --no-kernel --early-microcode /boot/EFI/gentoo/initramfs-${KERNEL_VER}-gentoo-r${KERNEL_REV}.img
}


# Portage
alias esearch='\emerge --search'
alias emerge='doas emerge'
alias equ='equery uses'

function emerge-try-fix-slot-conflict {
    echo "Try running this:"
    echo "emerge --ignore-default-opts -va1 $(qdepends -Qqq -F '%{CAT}/%{PN}:%{SLOT}' "^${1}" | tr '\n' ' ')"
    #emerge --ignore-default-opts -va1 $(qdepends -Qqq -F '%{CAT}/%{PN}:%{SLOT}' "^${1}")
}

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

# Start tabby ml (https://github.com/TabbyML/tabby)
alias start_tabby='cd "${HOME}/.local/bin/tabby-ml" && ./tabby serve --model DeepseekCoder-1.3B --chat-model Qwen2-1.5B-Instruct --device vulkan'

# Wayland Headless VNC
alias wayvnc-headless="WLR_BACKENDS=headless wayland-env river -c ~/.config/river/headless"

# Life hack?
alias doas="doas "



### KEYBINDS ###
bindkey -e      # Use emacs instead of vim
stty stop undef # Disable terminal freeze on ctrl-s

# Go forward/backword one word. (CTRL + < and/or CTRL + >)
bindkey "^[[1;5C"   forward-word
bindkey "^[[1;5D"   backward-word
bindkey '^[OA'      history-substring-search-up
bindkey '^[OB'      history-substring-search-down

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



### Compilers and dev tools
# RUST
export RUSTC_WRAPPER="sccache"
#export RUSTFLAGS="-C target-feature=-crt-static" # Fixes dylibs or some bullshit for musl...

# SCCACHE
export SCCACHE_DIR="/data/sccache"
export SCCACHE_CACHE_SIZE="10G"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end



### Shell integrations ###
eval "$(fzf --zsh)"



### PLUGINS ###
# Notify when long-running commands finnish
export AUTO_NOTIFY_THRESHOLD=20
export AUTO_NOTIFY_TITLE="Command finished!"
export AUTO_NOTIFY_BODY="'%command' took %elapsed seconds and exited with code %exit_code"
export AUTO_NOTIFY_IGNORE=("vim" "nvim" "man" "sleep" "wl-paste")
export AUTO_NOTIFY_ICON_SUCCESS=emblem-success
export AUTO_NOTIFY_ICON_FAILURE=emblem-error
zsh-defer source ${ZDOTDIR}/zsh-auto-notify/auto-notify.plugin.zsh
# Fuzzy finder menu
zsh-defer source ${ZDOTDIR}/fzf-tab/fzf-tab.plugin.zsh
# Auto suggestions; very pleasant.
zsh-defer source ${ZDOTDIR}/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
# Give suggestions of what command to write.
zsh-defer source ${ZDOTDIR}/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# Load syntax highlighting in the end!
zsh-defer source ${ZDOTDIR}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
