#!/bin/env bash

# Add this to your crontab to keep it up to date automatically!

cd "$ZDOTDIR/plugins" || exit

for PLUGIN in `find . -maxdepth 1 -mindepth 1 -type d`; do
    echo "Updating $PLUGIN ..."
    cd "$PLUGIN" || return
    git pull
    cd ..
done
