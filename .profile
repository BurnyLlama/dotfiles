export GDK_SCALE=1
export QT_SCALE_FACTOR=1
export QT_AUTO_SCREEN_SET_FACTOR=0

export PATH="${HOME}/.local/scripts:${HOME}/.local/bin:/home/fabbe/.cargo/bin:${PATH}"

# pnpm
export PNPM_HOME="/home/fabbe/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# cargo and rustup
[[ -d "$HOME/.cargo" ]] && . "$HOME/.cargo/env"

#for toolchain in `ls -1 ${HOME}/.rustup/toolchains/`; do
#    export PATH="${HOME}/.rustup/toolchains/${toolchain}/bin:${PATH}"
#done
