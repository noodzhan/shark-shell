#!/usr/bin/env bash
#9965
#https://blog.csdn.net/codeLife1993/article/details/126852376
wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.24.0/blackbox_exporter-0.24.0.linux-amd64.tar.gz
mkdir -p /opt/prometheus/
cp blackbox_exporter-0.24.0.linux-amd64.tar.gz /opt/prometheus
cd /opt/prometheus
tar -xvf blackbox_exporter-0.24.0.linux-amd64.tar.gz
cd blackbox_exporter-0.24.0.linux-amd64
nohup ./blackbox_exporter --config.file=blackbox.yml &

