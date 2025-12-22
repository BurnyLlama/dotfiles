#!/bin/zsh

### VARIABLES ###
# Set to true to disable dotfilectl sync warnings on shell startup.
DOTFILECTL_SYNC_DISABLE=false
# Set to true to disable the warning for a non-matching custom.zsh on shell startup.
DOTFILECTL_CUSTOM_WARNING_DISABLE=false
# Disable custom theme
ZSH_THEME_DISABLE=false
# Disable banner/welcome message
ZSH_BANNER_DISABLE=false
# Disable respective plugins
ZSH_PLUGIN_DISABLE_AUTO_NOTIFY=false
ZSH_PLUGIN_DISABLE_FZF_TAB=false
ZSH_PLUGIN_DISABLE_HISTORY_SUBSRTING_SEARCH=false
ZSH_PLUGIN_DISABLE_AUTOSUGGESTIONS=false
ZSH_PLUGIN_DISABLE_SYNTAX_HIGHLIGHTING=false


### ALIASES AND FUNCTIONS ###
source "${ZDOTDIR}/custom.d/00-path.zsh"
source "${ZDOTDIR}/custom.d/10-dotfile.zsh"
source "${ZDOTDIR}/custom.d/10-sudo_doas.zsh"
source "${ZDOTDIR}/custom.d/20-basics.zsh"
source "${ZDOTDIR}/custom.d/20-edit.zsh"
source "${ZDOTDIR}/custom.d/20-verbosity.zsh"
source "${ZDOTDIR}/custom.d/30-fzf.zsh"
source "${ZDOTDIR}/custom.d/30-git.zsh"
source "${ZDOTDIR}/custom.d/30-grc.zsh"
source "${ZDOTDIR}/custom.d/30-kernel.zsh"
source "${ZDOTDIR}/custom.d/30-man.zsh"
source "${ZDOTDIR}/custom.d/30-node.zsh"
source "${ZDOTDIR}/custom.d/30-power_options.zsh"
source "${ZDOTDIR}/custom.d/30-rust.zsh"
source "${ZDOTDIR}/custom.d/50-arch.zsh"
source "${ZDOTDIR}/custom.d/50-gentoo.zsh"
source "${ZDOTDIR}/custom.d/50-void.zsh"
source "${ZDOTDIR}/custom.d/90-zsh-ato-notify.zsh"
