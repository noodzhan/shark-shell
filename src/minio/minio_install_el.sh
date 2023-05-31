#!/usr/bin/env bash

# 安装minio
# 安装位置：/usr/local/bin

wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
sudo mv minio /usr/local/bin

userdel minio
groupdel minio
groupadd -r minio
useradd -M -r -g minio minio

rm -rf /opt/minio/data
mkdir -p /opt/minio/data
chown -R minio:minio /opt/minio/data

# 配置文件
cp ./minio.env /etc/default
mv /etc/default/minio.env /etc/default/minio


# 设置service
cp ./minio.service /etc/systemd/system

systemctl status minio
systemctl restart minio
