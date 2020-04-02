#!/bin/bash
set -ex

passwd root <<EOF
packer
packer
EOF

systemctl start sshd
