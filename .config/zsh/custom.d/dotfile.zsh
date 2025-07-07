#!/bin/zsh

# Useful aliases for handling version controlled dotfiles.

alias dotfile='/usr/bin/git --git-dir="$HOME/.local/dotfiles" --work-tree="$HOME"'
alias .f='dotfile'

# Interactive git-file-adder.
alias .fa="dotfile status --short -M | fzf -m --ansi --preview='dotfile diff --color-words {2}' | awk '{print \$2}' | xargs -- dotfile add"

# Usedul to prevent leaking user name -- and making sure configurations are portable.
alias dotfile-detect-hard-coded-user="dotfile ls-tree -r main --name-only | xargs grep --line-number $USER 2> /dev/null"
