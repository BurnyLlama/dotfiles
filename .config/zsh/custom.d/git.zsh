#!/bin/zsh

# Interactive git-file-adder.
alias gita="git status --short -M | fzf -m --ansi --preview='git diff --color-words {2}' | awk '{print \$2}' | xargs -- git add"

# Usedul to prevent leaking user name -- and making sure configurations are portable.
alias git-detect-hard-coded-user="git ls-tree -r HEAD --name-only | xargs grep --line-number $USER 2> /dev/null"
