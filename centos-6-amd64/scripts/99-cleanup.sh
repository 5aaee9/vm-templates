#!/bin/bash
set -ux

# clean caches
yum -y clean all

# Clean Cloud-Init
cloud-init clean --logs
service cloud-init stop
rm -rf /var/lib/cloud/

sync
