#!/bin/zsh

if ! check_command_exists grc; then
    echo -e "${Red}󰀦 'grc' is not installed!${Reset}"
    echo -e "${Blue}󱞩 󰋼 Please install 'grc' to enable colorisation of various commands.${Reset}"
    return 1
fi

# Colorise commands with grc
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh
[[ -s "/usr/share/grc/grc.zsh" ]] && source /usr/share/grc/grc.zsh
