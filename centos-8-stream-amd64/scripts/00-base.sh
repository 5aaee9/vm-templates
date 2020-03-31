#!/bin/bash
set -ex

# QEMU Guest Agent setup
dnf install -y qemu-guest-agent epel-release
systemctl enable qemu-guest-agent

# PIP Install
dnf install -y python3-pip

# Software init
dnf install -y mtr git wget curl tar

# Install Cloud-Init
yum install -y cloud-init cloud-utils-growpart
