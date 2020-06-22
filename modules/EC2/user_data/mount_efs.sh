#!/bin/bash
sleep 120
sudo yum update -y
sudo yum install -y nfs-utils
source /opt/efs
sudo mkdir -p $efs_mount_path
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $mount_target_DNS:/ $efs_mount_path
sudo chmod go+rw $efs_mount_path
echo $mount_target_DNS:/ $efs_mount_path nfs defaults,_netdev 0 0 >> /etc/fstab

