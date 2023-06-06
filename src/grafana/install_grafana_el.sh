#!/bin/bash
# version: grafana-enterprise-9.5.2-1.x86_64
# root
sudo yum install -y https://dl.grafana.com/enterprise/release/grafana-enterprise-9.5.2-1.x86_64.rpm
# 替换配置文件
sudo cp ./config/grafana.ini /etc/grafana/

sudo systemctl start grafana-server

sudo iptables -A INPUT -p tcp --dport 3000 -j ACCEPT

#http://192.168.1.131:3000/

