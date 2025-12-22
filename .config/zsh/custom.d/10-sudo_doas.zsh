#!/bin/zsh

# This allows auto completions after doas and sudo to work as expected.
check_command_exists sudo && alias sudo="sudo " && alias elevate="sudo "
check_command_exists doas && alias doas="doas " && alias elevate="doas "
