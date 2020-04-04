#!/bin/bash

set -ex

echo "* Install QEMU GA"

yum install qemu-guest-agent -y
chkconfig qemu-ga on

echo "* Disable SELinux"

if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    setenforce 0
fi

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
