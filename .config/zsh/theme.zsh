#!/bin/zsh

# ZSH autoloads
autoload -U  colors && colors
autoload -Uz promptinit && promptinit
autoload -Uz vcs_info

# PROMPT modules
local return_status="%(?:%F{green}✓:%F{red}✗)"
local user_name="%F{green}%n"
local host_name="%F{blue}%m"
local user_indicator="%F{cyan}$"

# Create the prompt
format_prompt () {
PROMPT="
%B${user_name}%F{cyan}@${host_name} ${crnt_path}${vcs_info_msg_0_}
${return_status} ${user_indicator}%f%b "
}

# Makes a path if in a normal directory and repo-name if in a vcs-folder.
path_or_vcs () {
    # Have it be a path or a repo name
    [[ -z "$vcs_info_msg_0_" ]] && crnt_path="%F{red}󰉖 %/" || crnt_path=""

    # If in git repo, give relative path
    vcs_root_dir='%F{red}󰉖 %r %F{15}on %F{magenta}󰘬 %b'
    vcs_sub_dir='%F{red}󰉖 %r/%S %F{15}on %F{magenta}󰘬 %b'

    # This is the scuffed check :)
    zstyle ':vcs_info:git*' formats '%S'
    vcs_info
    [[ "$vcs_info_msg_0_" == "." ]] \
        && zstyle ':vcs_info:git*' formats $vcs_root_dir \
        || zstyle ':vcs_info:git*' formats $vcs_sub_dir

    # Finally set the vcs_info again...
    vcs_info
}

# Pre-cmd function
precmd () {
    vcs_info # Enable git status
    path_or_vcs
    format_prompt
}

# Format how ouput of `time` will look. (Also affects $REPORTTIME output!)
TIMEFMT="
-------------------
${fg_bold[green]}Process statistics:${fg_no_bold[green]}
${fg[green]}󰣖 ${fg[white]}Job: ${fg[cyan]}%J
${fg[green]}󱎫 ${fg[white]}Time stats:
   ${fg[green]}󱤥 ${fg[white]}User:    ${fg[cyan]}%U
   ${fg[green]}󱫨 ${fg[white]}System:  ${fg[cyan]}%S
   ${fg[green]}󱫬 ${fg[white]}Elapsed: ${fg[cyan]}%E
${fg[green]}󰄧 ${fg[white]}RAM usage: ${fg[cyan]}%M
${fg[green]}󰍛 ${fg[white]}CPU usage: ${fg[cyan]}%P${reset_color}
"
