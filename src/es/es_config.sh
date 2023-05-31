#!/usr/bin/env bash
cd /usr/local/elasticsearch
sudo sysctl -w vm.max_map_count=262144
./bin/elasticsearch > es.log 2>&1 &