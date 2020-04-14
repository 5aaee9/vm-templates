#!/bin/bash
set -ex

CHROOT="arch-chroot /mnt"
DISK=/dev/sda

echo "* Partitioning disk"

# Create new disk part with fdisk
#
#   1 /boot 512M
#   2 /     all
fdisk $DISK <<EOF
o
n
p


+512M
n
p



p
w
EOF

mkfs.ext4 $DISK"1"
mkfs.ext4 $DISK"2"

mount $DISK"2" /mnt
mkdir /mnt/boot
mount $DISK"1" /mnt/boot

echo "* Install archlinux"
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
