#!/bin/bash
set -ex

CHROOT="arch-chroot /mnt"

cd /mnt/
wget https://space.indexyz.me/packages/growpart-0.31-1-any.pkg.tar.xz
yes | $CHROOT pacman -U /growpart-0.31-1-any.pkg.tar.xz
rm -f growpart-0.31-1-any.pkg.tar.xz
yes | $CHROOT pacman -S cloud-init
# Patch growpart
# https://github.com/karelzak/util-linux/issues/949
cd /mnt/usr/bin
patch --ignore-whitespace <<"EOF"
--- /root/growpart      2020-04-14 11:08:04.540000001 +0000
+++ growpart    2020-04-14 11:10:39.746666669 +0000
@@ -245,7 +245,7 @@ resize_sfdisk() {

        debug 1 "$sector_num sectors of $sector_size. total size=${disk_size} bytes"

-       rqe sfd_dump sfdisk --unit=S --dump "${DISK}" >"${dump_out}" ||
+       rqe sfd_dump sfdisk --unit=S --dump "${DISK}" | grep -v '^sector-size' >"${dump_out}" ||
                fail "failed to dump sfdisk info for ${DISK}"
        RESTORE_HUMAN="$dump_out"

EOF

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
