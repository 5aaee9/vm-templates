#!/bin/bash
set -ex

echo "* Setup QEMU-GA"
yum install qemu-guest-agent -y
systemctl enable qemu-guest-agent
