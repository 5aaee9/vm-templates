#!/bin/bash
set -ex

# QEMU Guest Agent setup
dnf install -y qemu-guest-agent epel-release
systemctl enable qemu-guest-agent

# PIP Install
dnf install -y python3-pip

# Software init
dnf install -y mtr git wget curl tar

# Disable PredictableNetworkInterfaceNames
# https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/
sed -i 's#^\(GRUB_CMDLINE_LINUX=".*\)"$#\1 net.ifnames=0 biosdevname=0"#' /etc/default/grub

grub2-mkconfig -o /boot/grub2/grub.cfg
if [ -d /boot/efi/EFI/redhat ]; then
    grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
fi
