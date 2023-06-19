#!/usr/bin/env bash


tar -xvf TDengine-server-3.0.1.6*.tar.gz
cd TDengine-server-3.0.1.6
bash install.sh

# 修改配置文件即可。

systemctl start taosd
systemctl enable taosd

systemctl start taosadapter
systemctl enable taosadapter


bash ./tb_init.sh

## 开放6400端口


