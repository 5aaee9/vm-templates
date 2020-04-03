#!/bin/bash

set -ex

echo "* Install QEMU GA"

yum install qemu-guest-agent -y
chkconfig qemu-ga on

echo "* Install cloud-init"
yum install epel-release -y
yum install cloud-init cloud-utils-growpart dracut-modules-growroot -y

for svc in cloud-config cloud-final cloud-init cloud-init-local; do
    chkconfig $svc on
done
