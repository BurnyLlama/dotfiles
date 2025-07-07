#!/bin/zsh

# Useful aliases for handling version controlled dotfiles.

alias dotfile='/usr/bin/git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME'
alias .f='dotfile'

# Interactive git-file-adder.
alias .fa="git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME status --short -M | fzf -m --ansi --preview='git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME diff --color-words {2}' | awk '{print \$2}' | xargs -- git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME add"

# Usedul to prevent leaking user name -- and making sure configurations are portable.
alias dotfile-detect-hard-coded-user="dotfile ls-tree -r main --name-only | xargs grep --line-number $USER 2> /dev/null"
