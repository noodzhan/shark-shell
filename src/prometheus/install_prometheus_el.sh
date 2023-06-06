#!/usr/bin/env bash

# version: prometheus2-2.20.0-3.oe2303.x86_64

sudo yum -y install prometheus2-2.20.0-3.oe2303.x86_64
sudo systemctl start prometheus
sudo iptables -A INPUT -p tcp --dport 9090 -j ACCEPT
#http://192.168.1.131:9090/graph

