#!/bin/zsh

# If not on Void, stop sourcing this file.
check_command_exists xbps || return

# xbps
alias xq='xbps-query'
alias xi='elevate xbps-install'
alias xr='elevate xbps-remove'
