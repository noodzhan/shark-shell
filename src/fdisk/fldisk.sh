#!/usr/bin/env bash

# JIRA YAP-6

# 查看硬盘
fdisk -l

# 选中某块硬盘,分区
fdisk /dev/vdb

# 输入n

# 输入分区信息

# 格式化分区
mkfs.ext4 /dev/vdb1

mkdir -p /home/taosdata

# 挂载

mount /dev/vdb1 /home/taosdata


