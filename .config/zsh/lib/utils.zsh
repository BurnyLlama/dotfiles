#!/bin/zsh

function check_command_exists() {
    command -v "$1" > /dev/null 2>&1
}
