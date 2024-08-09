#!/usr/bin/env bash

# dashboardID 9628
# 安装prometheus node_exporter
mkdir -p /opt/prometheus/
cp ../package/postgres_exporter-0.12.0.linux-amd64.tar.gz /opt/prometheus/
cd /opt/prometheus/
#wget https://www.noodb.com/resource/software/postgres_exporter-0.12.0.linux-amd64.tar.gz
tar xvf postgres_exporter-0.12.0.linux-amd64.tar.gz
cd postgres_exporter-0.12.0.linux-amd64
export DATA_SOURCE_NAME="postgresql://postgres:postgres@127.0.0.1:5432/thingsboard?sslmode=disable"
nohup ./postgres_exporter &
# 开放端口
iptables -A INPUT -p tcp --dport 9187 -j ACCEPT

# vim /etc/prometheus/prometheus.yml

#scrape_configs:
#  # 添加作业并命名
#  - job_name: 'postgres'
#    # 静态添加node
#    static_configs:
#    # 指定监控端
#    - targets: ['192.168.1.131:9187']
