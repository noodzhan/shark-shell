#!/bin/bash

## 查看存在什么硬盘
fdisk

## 创建raid1

mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc

## 在磁盘阵列上创建文件系统

mkfs.ext4 /dev/md0

## 挂载
mkdir -p /mnt/raid

mount /dev/md0 /mnt/raid
