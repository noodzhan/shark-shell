#!/usr/bin/env bash
cd /usr/local/elasticsearch
sudo sysctl -w vm.max_map_count=262144
export ES_HEAP_SIZE=10g
# /usr/local/elasticsearch/config
# 修改堆内存的大小
./bin/elasticsearch > es.log 2>&1 &