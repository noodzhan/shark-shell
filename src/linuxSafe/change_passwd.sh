#!/bin/bash

# 提示用户输入要修改密码的用户名
read -p "Enter the username for password change: " username

# 使用 passwd 命令更改用户密码
passwd $username

# 检查 passwd 命令的退出状态来确定密码是否成功更改
if [ $? -eq 0 ]; then
  echo "Password for user $username has been successfully changed."
else
  echo "Failed to change password for user $username."
fi