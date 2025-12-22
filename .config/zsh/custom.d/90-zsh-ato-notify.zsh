#!/bin/zsh

export AUTO_NOTIFY_THRESHOLD=30
export AUTO_NOTIFY_TITLE="Command finished!"
export AUTO_NOTIFY_BODY="'%command' took %elapsed seconds and exited with code %exit_code"
export AUTO_NOTIFY_EXPIRE_TIME=5000 # Remove after 5 seconds.
export AUTO_NOTIFY_IGNORE=("vim" "nvim" "man" "sleep" "wl-paste")
export AUTO_NOTIFY_ICON_SUCCESS=emblem-success
export AUTO_NOTIFY_ICON_FAILURE=emblem-error
