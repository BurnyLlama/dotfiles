#!/bin/zsh

# Easily set GPU settings with dpm:
gpu-profile-set() {
    if ! check_command_exists dpm-query; then
        echo -e "${Red}󰀦 'dpm-query' is not installed!${Reset}"
        return 1
    fi

    case $1 in
        performance)
            elevate dpm-query set all high performance
            ;;
        battery)
            elevate dpm-query set all low battery
            ;;
        balanced)
            elevate dpm-query set all auto balanced
            ;;
        *)
            echo "${Red}󰀦 Unknown profile: $1${Reset}"
            echo ">   󱞩 󰋼 Please use one of the following: ${Blue}performance, battery, balanced${Reset}"
            ;;
    esac
}
