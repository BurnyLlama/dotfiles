#!/bin/zsh

# Listing files and folders
alias \
    ls="lsd -h"    \
    la="ls -A"     \
    ll="ls -l"     \
    l="ls -Al"

# Auto-make parents if they don't exist with mkdir
alias mkdir="mkdir -pv"

# Colorise grep! :o
alias grep="grep --color=auto"

# Colorise cat (by using bat)
alias cat="bat"

# Get rid of that ugly .wget-hsts file...
alias wget="wget --hsts-file ~/.cache/wget-hsts"

# aria2
alias aria2c="aria2c -x 16 -j 16 -s 16"

# SQLite
SQLITE_HISTORY="${HOME}/.cache/sqlite_history"
alias sqlite3="sqlite3 --column --header"

# Annoying lesshst... Unsure?
LESSHISTFILE="/tmp/less-hist-$USER"
