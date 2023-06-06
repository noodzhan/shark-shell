#!/usr/bin/env bash
# https://github.com/prometheus/mysqld_exporter/releases/download/v0.14.0/mysqld_exporter-0.14.0.linux-amd64.tar.gz
# dashboardId: 7362
mkdir -p /opt/prometheus/
cd /opt/prometheus
wget https://www.noodb.com/resource/software/mysqld_exporter-0.14.0.linux-amd64.tar.gz
tar -xvf mysqld_exporter-0.14.0.linux-amd64.tar.gz
cd mysqld_exporter-0.14.0.linux-amd64

# 执行sql
# mysql
# CREATE USER 'grafana'@'%' IDENTIFIED BY 'ypkj@1234';
# GRANT ALL PRIVILEGES ON *.* TO 'grafana'@'%';
# flush privileges;

echo -e "[client]
         user=grafana
         password=ypkj@1234" >> .my.cnf
nohup ./mysqld_exporter --config.my-cnf=.my.cnf &

# 开发端口
iptables -A INPUT -p tcp --dport 9104 -j ACCEPT


# vim /etc/prometheus/prometheus.yml

#scrape_configs:
#  # 添加作业并命名
#  - job_name: 'mysql'
#    # 静态添加node
#    static_configs:
#    # 指定监控端
#    - targets: ['192.168.1.131:9104']