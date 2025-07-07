#!/bin/zsh

# Easily set GPU settings with dpm:
gpu-profile-set() {
    case $1 in
        performance)
            sudo dpm-query set all high performance
            ;;
        battery)
            sudo dpm-query set all low battery
            ;;
        balanced)
            sudo dpm-query set all auto balanced
            ;;
        *)
            echo "${Red}Unknown profile: $1${Reset}"
            echo "> Please use one of the following: ${Blue}performance, battery, balanced${Reset}"
            ;;
    esac
}
