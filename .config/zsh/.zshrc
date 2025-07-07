### DEFERING ###
# Allow defering of slower tasks...
source ${ZDOTDIR}/plugins/zsh-defer/zsh-defer.plugin.zsh


### PATH ###
export PATH="${HOME}/.local/scripts:${HOME}/.local/bin:${HOME}/.cargo/bin:${HOME}/.config/composer/vendor/bin:${PATH}"
export fpath=( ~/.config/zsh/.zfunc "${fpath[@]}" )


### THEME + TERMINAL + START-UP MESSAGE ###
source "${ZDOTDIR}/ansi_colors.zsh" # Allows use of ansi colors (and styles).
source "${ZDOTDIR}/theme.zsh"
TERM=xterm-256color
echo -e "${Blue}Beinvenue au terminal, $USER!${Reset}"


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
export MANPAGER="bat -l man --paging=always"


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


### CUSTOM ALIASES, FUNCTIONS, ETC. ###

# Make sure there is a custom.zsh "config file".
if [ ! -f "$ZDOTDIR/custom.zsh" ]; then
    echo -e "${Red}Missing '${ZDOTDIR}/custom.zsh'. ${Yellow}Copying over default from '${ZDOTDIR}/custom.default.zsh'!${Reset}"
    cp "${ZDOTDIR}/custom.default.zsh" "${ZDOTDIR}/custom.zsh"
    chmod +x "$ZDOTDIR/custom.zsh"
fi

# Warn if custom.zsh doesn't match custom.default.zsh.
cmp --silent "$ZDOTDIR/custom.zsh" "$ZDOTDIR/custom.default.zsh" || echo -e "${Yellow}Your custom.zsh file doesn't match the default.\n${Reset}> Run ${Blue}'cp ${ZDOTDIR}/custom.default.zsh ${ZDOTDIR}/custom.zsh'${Reset} if you want to update your custom aliases!${Reset}"

# Source it.
source "$ZDOTDIR/custom.zsh"

# This allows auto completions after doas and sudo to work as expected.
alias doas="doas "
alias sudo="sudo "


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

### Shell integrations ###
eval "$(fzf --zsh)"


### Autos ###
# Automatically download new dotfile changes.
setsid -- dotfile-sync &>/dev/null


### PLUGINS ###
# Notify when long-running commands finnish
export AUTO_NOTIFY_THRESHOLD=30
export AUTO_NOTIFY_TITLE="Command finished!"
export AUTO_NOTIFY_BODY="'%command' took %elapsed seconds and exited with code %exit_code"
export AUTO_NOTIFY_IGNORE=("vim" "nvim" "man" "sleep" "wl-paste")
export AUTO_NOTIFY_ICON_SUCCESS=emblem-success
export AUTO_NOTIFY_ICON_FAILURE=emblem-error
zsh-defer source ${ZDOTDIR}/plugins/zsh-auto-notify/auto-notify.plugin.zsh
# Fuzzy finder menu
zsh-defer source ${ZDOTDIR}/plugins/fzf-tab/fzf-tab.plugin.zsh
# Auto suggestions; very pleasant.
zsh-defer source ${ZDOTDIR}/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
# Give suggestions of what command to write.
zsh-defer source ${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# Load syntax highlighting in the end!
zsh-defer source ${ZDOTDIR}/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
