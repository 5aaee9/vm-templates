#!/bin/bash
set -ex

cat > /etc/cloud/cloud.cfg <<EOF
disable_root: false
ssh_pwauth: true

cloud_init_modules:
  - growpart
  - seed_random
  - ssh
  - ca-certs
cloud_config_modules:
  - package-update-upgrade-install
EOF
