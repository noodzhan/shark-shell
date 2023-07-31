#!/bin/bash
set -e
nacos_alive=$(netstat -tunlp | grep 8848 | wc -l)
install_dir=/usr/local
check_url=http://localhost:8726/check
nacos_user=nacos
nacos_passwd=nacos@haici5
function start_nacos() {
         sudo su <<EOF
         source /etc/profile
         echo "JAVA_HOME: ${JAVA_HOME}"
         ${install_dir}/nacos/bin/startup.sh -m standalone
EOF
}

if [ $nacos_alive -eq 0 ]; then
  # 启动
  start_nacos
else
  # 远程调用
  res=$(curl -X POST '127.0.0.1:8848/nacos/v1/auth/login' -d "username=${nacos_user}&password=${nacos_passwd}")
  sleep 5
  if [ $(echo $res | grep accessToken | wc -l) -ne 1 ]; then
    start_nacos
  fi
fi
