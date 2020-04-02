#!/bin/bash
set -ex

cat > /etc/cloud/cloud.cfg <<EOF
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
  - runcmd
  - mounts
  - locale
  - set-passwords
  - package-update-upgrade-install
  - ntp
  - timezone
  - resolv_conf

system_info:
  default_user:
    name: root

growpart:
  mode: auto
  devices: ['/dev/sda2']
  ignore_growroot_disabled: false

runcmd:
  - [ cloud-init-per, once, grow_VG, pvresize, /dev/sda2 ]
  - [ cloud-init-per, once, grow_LV, lvextend, -l, +100%FREE, /dev/system/root ]
  - [ cloud-init-per, once, grow_fs, xfs_growfs, -d, / ]
EOF

# Disable PredictableNetworkInterfaceNames
# https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/
sed -i 's#^\(GRUB_CMDLINE_LINUX=".*\)"$#\1 net.ifnames=0 biosdevname=0"#' /etc/default/grub

grub2-mkconfig -o /boot/grub2/grub.cfg
if [ -d /boot/efi/EFI/redhat ]; then
    grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
fi
