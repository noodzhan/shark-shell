#!/usr/bin/env bash
wget https://github.com/danielqsj/kafka_exporter/releases/download/v1.7.0/kafka_exporter-1.7.0.linux-amd64.tar.gz
mkdir -p /opt/prometheus/
cp kafka_exporter-1.7.0.linux-amd64.tar.gz /opt/prometheus
cd /opt/prometheus
tar -xvf kafka_exporter-1.7.0.linux-amd64.tar.gz
cd kafka_exporter-1.7.0.linux-amd64
nohup ./kafka_exporter --kafka.server=127.0.0.1:9092
