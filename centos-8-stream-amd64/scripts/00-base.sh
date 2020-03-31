#!/bin/bash
set -ex

# QEMU Guest Agent setup
dnf install -y qemu-guest-agent epel-release

# Cloud-Init
dnf install -y cloud-init cloud-utils-growpart

# PIP Install
dnf install -y python3-pip

# Software init
dnf install -y mtr

systemctl enable qemu-guest-agent
