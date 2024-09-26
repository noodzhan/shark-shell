#!/bin/bash

KAFKA_LOG_DIR="/opt/kafka/kafka-logs"
KAFKA_LOG_BAK_DIR="/opt/kafka_log_bak"
current_time=$(date +"%Y-%m-%d %H:%M:%S")

function backup_kafka_logs() {
  local log_dir="$1"
  local bak_dir="$2/$(date "+%Y%m%d%H%M%S")"

  sudo mkdir -p "$bak_dir" || {
    echo "${current_time} 无法创建备份目录: $bak_dir"
    exit 1
  }
  sudo cp -r "$log_dir" "$bak_dir" || {
    echo "${current_time} 备份Kafka日志文件失败"
    exit 1
  }
  sudo rm -rf "$log_dir" || {
    echo "${current_time} 删除Kafka日志文件失败"
    exit 1
  }
}

function restart_zookeeper_service() {
  if sudo systemctl restart zookeeper; then
    echo "${current_time} 成功启动zookeeper服务"
  else
    echo "${current_time} 启动zookeeper服务失败"
    exit 1
  fi
}

function restart_kafka_service() {
  if sudo systemctl restart kafka; then
    echo "${current_time} 成功启动Kafka服务"
  else
    echo "${current_time} 启动Kafka服务失败"
    backup_kafka_logs "$KAFKA_LOG_DIR" "$KAFKA_LOG_BAK_DIR"
    exit 1
  fi
}

function print_log() {
  if [ "$kafka_alive" -eq 0 ]; then
    echo "${current_time} kafka服务的9092端口不存在"
  else
    echo "${current_time} zookeeper服务的2181端口不存在"
  fi
}

# 检查Kafka是否正在监听9092端口
kafka_alive=$(netstat -tunlp | grep 9092 | wc -l)

zookeeper_alive=$(netstat -tunlp | grep 2181 | wc -l)

## 只要zookeeper或者kafka有一个挂了，就重启。
if [ "$kafka_alive" -eq 0 ] || [ "$zookeeper_alive" -eq 0 ]; then

  print_log
  restart_zookeeper_service
  sleep 30
  restart_kafka_service

fi
