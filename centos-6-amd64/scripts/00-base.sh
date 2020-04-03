#!/bin/bash

set -ex

echo "* Install QEMU GA"

yum install qemu-guest-agent -y
chkconfig qemu-ga on

echo "* Install cloud-init"
export CLOUD_INIT_VERSION="20.1"
yum install centos-release-scl -y
yum install git wget rh-python36 -y


cd /usr/local/src/
wget https://launchpad.net/cloud-init/trunk/${CLOUD_INIT_VERSION}/+download/cloud-init-${CLOUD_INIT_VERSION}.tar.gz
tar zxvf cloud-init-${CLOUD_INIT_VERSION}.tar.gz
rm -f cloud-init-${CLOUD_INIT_VERSION}.tar.gz

PYTHON_PATH="/opt/rh/rh-python36/root/usr/bin"
cd cloud-init-${CLOUD_INIT_VERSION}

$PYTHON_PATH/pip install -r requirements.txt
$PYTHON_PATH/python setup.py build
$PYTHON_PATH/python setup.py install --init-system sysvinit

cd ..
rm -rf cloud-init-${CLOUD_INIT_VERSION}


for bin in cloud-id cloud-init cloud-init-per; do
    ln -s $PYTHON_PATH/$bin /usr/bin/$bin
done

for svc in cloud-config cloud-final cloud-init cloud-init-local; do
    chkconfig $svc on
done
