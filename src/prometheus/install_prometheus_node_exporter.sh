#!/usr/bin/env bash

# 安装prometheus node_exporter
mkdir -p ~/prometheus/node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v0.17.0/node_exporter-0.17.0.linux-amd64.tar.gz
cd ~/prometheus/node_exporter
tar xvfz node_exporter-0.17.0.linux-amd64.tar.gz
cd node_exporter-0.17.0.linux-amd64
nohup ./node_exporter &
# 开放端口
iptables -A INPUT -p tcp --dport 9100 -j ACCEPT

# vim /etc/prometheus/prometheus.yml

#scrape_configs:
#  # 添加作业并命名
#  - job_name: 'mysql'
#    # 静态添加node
#    static_configs:
#    # 指定监控端
#    - targets: ['192.168.1.131:9100']
