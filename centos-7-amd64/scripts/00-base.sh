#!/bin/bash
set -ex

echo "* Setup QEMU-GA"
yum install qemu-guest-agent -y
systemctl enable qemu-guest-agent

echo "* Disable PredictableNetworkInterfaceNames"

# Disable PredictableNetworkInterfaceNames
# https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/
sed -i 's#^\(GRUB_CMDLINE_LINUX=".*\)"$#\1 net.ifnames=0 biosdevname=0"#' /etc/default/grub

grub2-mkconfig -o /boot/grub2/grub.cfg
if [ -d /boot/efi/EFI/redhat ]; then
    grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
fi

echo "* Install cloud-init"
yum install -y cloud-init cloud-utils-growpart
