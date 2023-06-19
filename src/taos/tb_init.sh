#!/bin/bash

HOSTNAME="127.0.0.1"
USERNAME="root"
PASSWORD="20230322_hsz_db"

CURRENT_DIR=$(cd $(dirname $0); pwd)
# taos
TB_SQLLIST=`ls $CURRENT_DIR/init`
for sql in ${TB_SQLLIST[@]}
do
  # 主要换行符号
  taos -h ${HOSTNAME} -u ${USERNAME} -p${PASSWORD} -s "source $CURRENT_DIR/init/${sql}"
done

