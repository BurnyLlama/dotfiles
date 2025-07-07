#!/bin/zsh

# Kernel compile on Gentoo
alias kcd='cd /usr/src/linux'
#alias kmake='make INSTALL_PATH=/boot/EFI/gentoo/ CC=clang LLVM=1 LLVM_IAS=1 -j12'
alias kmake='/usr/bin/make INSTALL_PATH=/boot/EFI/gentoo/ KBUILD_OUTPUT=${HOME}/Development/KERNEL -j12'
alias kconf-cp='zcat /proc/config.gz > ${HOME}/Development/KERNEL/.config && kmake oldconfig'
function mkinitramfs {
    KERNEL_VER=$1
    doas dracut --zstd --kernel-image /boot/EFI/gentoo/vmlinuz-${KERNEL_VER}-gentoo -f -p -H --no-kernel --early-microcode /boot/EFI/gentoo/initramfs-${KERNEL_VER}-gentoo.img
}
function mkinitramfs-rev {
    KERNEL_VER=$1
    KERNEL_REV=$2
    doas dracut --zstd --kernel-image /boot/EFI/gentoo/vmlinuz-${KERNEL_VER}-gentoo-r${KERNEL_REV} -f -p -H --no-kernel --early-microcode /boot/EFI/gentoo/initramfs-${KERNEL_VER}-gentoo-r${KERNEL_REV}.img
}


# Portage
alias esearch='\emerge --search'
alias emerge='doas emerge'
alias equ='equery uses'

function emerge-try-fix-slot-conflict {
    echo "Try running this:"
    echo "emerge --ignore-default-opts -va1 $(qdepends -Qqq -F '%{CAT}/%{PN}:%{SLOT}' "^${1}" | tr '\n' ' ')"
    #emerge --ignore-default-opts -va1 $(qdepends -Qqq -F '%{CAT}/%{PN}:%{SLOT}' "^${1}")
}
