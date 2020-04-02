#!/bin/bash
set -ex

yes | arch-chroot /mnt pacman -Scc
