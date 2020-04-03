#!/bin/bash
set -ux

# clean caches
yum -y clean all

UDEV_RULES=(
    '70-persistent-net.rules'
)

for rule in "${UDEV_RULES[@]}"; do
    rm -f "/etc/udev/rules.d/${rule}"
    ln -sf /dev/null "/etc/udev/rules.d/${rule}"
done

# Clean UP HDADDR in eth0
sed -i '/^HWADDR=".*"$/d' /etc/sysconfig/network-scripts/ifcfg-eth0

sync
