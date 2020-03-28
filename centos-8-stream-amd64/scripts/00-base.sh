#!/bin/bash
set -ex

dnf install -y qemu-guest-agent epel-release
dnf install -y python3-pip

systemctl enable qemu-guest-agent