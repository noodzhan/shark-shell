#!/bin/bash

kafka_alive=${netstat -tunlp | grep 9092|wc -l}

if [ $kafka_alive -eq 0 ]; then
  # 启动
  systemctl start kafka
fi
