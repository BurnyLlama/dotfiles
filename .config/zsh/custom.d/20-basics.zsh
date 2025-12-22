#!/bin/zsh

# Listing files and folders
alias \
    ls="lsd -h"    \
    la="lsd -A"     \
    ll="lsd -l"     \
    l="lsd -Al"

# Auto-make parents if they don't exist with mkdir
alias mkdir="mkdir -pv"

# Colorise grep! :o
alias grep="grep --color=auto"

# Colorise cat (by using bat)
check_command_exists bat && alias cat="bat"

# Get rid of that ugly .wget-hsts file...
check_command_exists wget && alias wget="wget --hsts-file ~/.cache/wget-hsts"

# aria2
check_command_exists aria2c && alias aria2c="aria2c -x 16 -j 16 -s 16"

# SQLite
SQLITE_HISTORY="${HOME}/.cache/sqlite_history"
check_command_exists sqlite3 && alias sqlite3="sqlite3 --column --header"

# Annoying lesshst... Unsure?
LESSHISTFILE="/tmp/less-hist-$USER"
