#!/bin/bash
set -ex

echo "* Install QEMU guest agent"
apt-get update -y
apt-get install qemu-guest-agent -y
systemctl enable qemu-guest-agent

# cloud-init cloud-guest-utils

# cleanup
apt autoremove --purge -y
apt-get clean -y
rm -r /var/lib/apt/lists /var/cache/apt/archives
