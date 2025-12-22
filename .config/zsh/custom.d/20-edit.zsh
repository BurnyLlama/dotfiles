#!/bin/zsh

# Editor
check_command_exists nvim && alias edit="nvim"
check_command_exists nvim && alias vim="nvim"

# Edit config
alias zshconfig="edit ${ZDOTDIR}/.zshrc"
