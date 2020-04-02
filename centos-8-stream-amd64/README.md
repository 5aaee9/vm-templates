# centos-8-stream-amd64

## Quick start
```
wget https://files.indexyz.me/QEMU/Templates/centos-8-stream-amd64.qcow2

qm create 999 --name CentOS-8-Stream \
  --memory 512 \
  --sockets 1 \
  --smp 1 \
  --net0 virtio,bridge=vmbr0 \
  --ostype l26 \
  --agent 1,type=virtio \
  --ide2 local:cloudinit \
  --scsihw virtio-scsi-pci \
  --bootdisk scsi0

qm importdisk 999 centos-8-stream-amd64.qcow2 local
qm set 999 --scsi0 local:999/vm-999-disk-0.raw
qm template 999
```
