#!/bin/bash
set -ex

echo "* Setup QEMU-GA"
yum install qemu-guest-agent -y
systemctl enable qemu-guest-agent

echo "* Install cloud-init"
yum install -y cloud-init cloud-utils-growpart
