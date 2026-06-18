#!/usr/bin/env bash

if [[ $(hostnamectl hostname) = 'leviathan' ]]; then
    cp /boot/* /efi/EFI/arch
    mkinitcpio -P
fi
kernel_version=$(pacman -Q linux | awk '{print $2}')
echo "[$(date '+%F %T')] system upgraded -> ${kernel_version}" >> /var/log/post-upgrade.log
