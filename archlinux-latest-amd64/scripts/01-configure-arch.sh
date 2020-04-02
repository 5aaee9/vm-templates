#!/bin/bash
set -ex

CHROOT="arch-chroot /mnt"
DISK=/dev/vda

echo "* Configure SSH"
yes | $CHROOT pacman -S openssh
$CHROOT systemctl enable sshd
$CHROOT passwd <<EOF
packer
packer
EOF

echo "* Configure networking"

$CHROOT systemctl enable systemd-networkd
$CHROOT systemctl enable systemd-resolved

cat > /mnt/etc/systemd/network/20-wired.network <<EOF
[Match]
Name=eth0

[Network]
DHCP=ipv4
EOF

echo "* Install GRUB"
yes | $CHROOT pacman -S grub
sed -i 's#^\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"$#\1 net.ifnames=0 biosdevname=0"#' /mnt/etc/default/grub
$CHROOT grub-install --target=i386-pc $DISK
$CHROOT grub-mkconfig -o /boot/grub/grub.cfg

echo "* Install qemu-guest-agent"
yes | $CHROOT pacman -S qemu-guest-agent
$CHROOT systemctl enable qemu-ga
