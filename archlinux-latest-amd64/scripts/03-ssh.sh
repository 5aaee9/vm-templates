#!/bin/bash
set -ex

sed -i 's|^\(#\)\?\(PermitRootLogin\) \(.*\)|\2 yes|' /mnt/etc/ssh/sshd_config