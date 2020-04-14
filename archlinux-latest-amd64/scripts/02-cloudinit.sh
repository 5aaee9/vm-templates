#!/bin/bash
set -ex

CHROOT="arch-chroot /mnt"

cd /mnt/
wget https://space.indexyz.me/packages/growpart-0.31-1-any.pkg.tar.xz
yes | $CHROOT pacman -U /growpart-0.31-1-any.pkg.tar.xz
rm -f growpart-0.31-1-any.pkg.tar.xz
yes | $CHROOT pacman -S cloud-init

cat > /mnt/etc/cloud/cloud.cfg <<EOF
users:
  - default

disable_root: false
ssh_pwauth: true

ssh_deletekeys: true
ssh_genkeytypes: ['rsa', 'dsa', 'ecdsa']

datasource_list: [ NoCloud, ConfigDrive ]

cloud_init_modules:
  - growpart
  - resizefs
  - seed_random
  - set_hostname
  - update_hostname
  - ssh
  - ca-certs

cloud_config_modules:
  - mounts
  - locale
  - set-passwords
  - ntp
  - timezone
  - resolv_conf

system_info:
  distro: arch
  default_user:
    name: root

growpart:
  mode: auto
  devices: ['/']
  ignore_growroot_disabled: false
EOF

$CHROOT systemctl enable cloud-init-local.service
$CHROOT systemctl enable cloud-init.service
$CHROOT systemctl enable cloud-config.service
$CHROOT systemctl enable cloud-final.service
