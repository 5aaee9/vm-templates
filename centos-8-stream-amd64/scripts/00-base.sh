#!/bin/bash
set -ex

# QEMU Guest Agent setup
dnf install -y qemu-guest-agent epel-release
systemctl enable qemu-guest-agent

# Cloud-Init
dnf install -y acpid cloud-init cloud-utils-growpart
systemctl enable acpid

# PIP Install
dnf install -y python3-pip

# Software init
dnf install -y mtr
