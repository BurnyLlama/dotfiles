#!/bin/zsh

# If not on Arch, stop sourcing this file.
check_command_exists pacman || return

# Map yay to paru
check_command_exists paru && alias yay="paru"
