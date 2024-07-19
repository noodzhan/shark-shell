#!/bin/bash

KAFKA_LOG_DIR="/opt/apexapp/kafka-logs"
KAFKA_LOG_BAK_DIR="/opt/kafka_log_bak"

function backup_kafka_logs() {
  local log_dir="$1"
  local bak_dir="$2/$(date "+%Y%m%d%H%M%S")"

   mkdir -p "$bak_dir" || { echo "无法创建备份目录: $bak_dir"; exit 1; }
   cp -r "$log_dir" "$bak_dir" || { echo "备份Kafka日志文件失败"; exit 1; }
   rm -rf "$log_dir" || { echo "删除Kafka日志文件失败"; exit 1; }
}

function restart_zookeeper_service() {
  if  systemctl restart zookeeper; then
    echo "成功启动zookeeper服务"
  else
    echo "启动zookeeper服务失败"
    exit 1
  fi
}

function start_kafka_service() {
  if  systemctl start kafka; then
    echo "成功启动Kafka服务"
  else
    echo "启动Kafka服务失败"
    backup_kafka_logs "$KAFKA_LOG_DIR" "$KAFKA_LOG_BAK_DIR"
    exit 1
  fi
}

# 检查Kafka是否正在监听9092端口
kafka_alive=$(netstat -tunlp | grep 9092 | wc -l)

zookeeper_alive=$(netstat -tunlp | grep 2181 | wc -l)



if [ "$kafka_alive" -eq 0 ]; then

  restart_zookeeper_service
  sleep 30
  if [ "$zookeeper_alive" -eq 0 ]; then

    start_kafka_service
  fi
fi
