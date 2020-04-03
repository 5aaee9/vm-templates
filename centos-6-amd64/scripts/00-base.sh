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
