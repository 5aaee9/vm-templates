#!/bin/bash
set -ux

# clean caches
yum -y clean all

# Clean Cloud-Init
cloud-init clean --logs
systemctl stop cloud-init
rm -rf /var/lib/cloud/

ls -lah /usr/bin/cloud-init
cat /usr/bin/cloud-init

sync
