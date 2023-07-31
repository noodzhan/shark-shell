#!/bin/bash

nacos_alive=${netstat -tunlp | grep 8848|wc -l}
install_dir=/usr/local
check_url=http://localhost:8726/check
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
  res=$(curl $check_url)
  if [res -ne 0]
    start_nacos
  fi
fi
