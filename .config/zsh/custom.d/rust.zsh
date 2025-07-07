#!/bin/zsh

# RUST
check_command_exists sccache && export RUSTC_WRAPPER="sccache"
#export RUSTFLAGS="-C target-feature=-crt-static" # Fixes dylibs or some bullshit for musl...

# SCCACHE
export SCCACHE_DIR="/data/sccache"
export SCCACHE_CACHE_SIZE="10G"
