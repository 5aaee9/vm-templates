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
  - bootcmd
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

bootcmd:
  - [ cloud-init-per, once, grow_VG, pvresize, /dev/sda2 ]
  - [ cloud-init-per, once, grow_LV, lvextend, -l, +100%FREE, /dev/centos/root ]
  - [ cloud-init-per, once, grow_fs, xfs_growfs, -d, / ]
EOF
