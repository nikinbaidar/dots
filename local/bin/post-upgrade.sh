#!/usr/bin/env bash

cp /boot/* /efi/EFI/arch
# cp /efi/EFI/arch/initramfs-linux.img /efi/EFI/arch/initramfs-linux-fallback.img
mkinitcpio -P
echo "$(date '+%F %T'): system upgraded $(uname -r) -> $(pacman -Q linux | awk '{print $2}')" >> /var/log/post-upgrade.log
