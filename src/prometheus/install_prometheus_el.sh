#!/usr/bin/env bash

# version: prometheus2-2.20.0-3.oe2303.x86_64

sudo yum -y install prometheus2-2.20.0-3.oe2303.x86_64
sudo systemctl start prometheus
#http://192.168.1.131:9090/graph

