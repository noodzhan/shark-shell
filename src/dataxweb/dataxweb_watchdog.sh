#!/usr/bin/env bash

datax_admin_install="/usr/local/datax-admin"
datax_executor_install="/usr/local/datax-executor"
jps="/usr/local/java/bin/jps"
davinci_install="/usr/local/model/davinci"

function start_datax_admin() {
    "${datax_admin_install}/bin/datax-admin.sh" start
}

function start_datax_executor() {
    "${datax_executor_install}/bin/datax-executor.sh" start
}

function start_davinci_db() {
   bash "${davinci_install}/bin/start-server.sh"
}



jps_result=$("${jps}")

datax_admin_count=$(echo $jps_result | grep "DataXAdminApplication" | wc -l)

if [ "${datax_admin_count}" -eq 0 ]; then
    start_datax_admin
fi

datax_executor_count=$(echo $jps_result | grep "DataXExecutorApplication" | wc -l)

if [ "${datax_executor_count}" -eq 0 ]; then
    start_datax_executor
fi

davinci_count=$(echo $jps_result | grep "DavinciServerApplication" | wc -l)

if [ "${davinci_count}" -eq 0 ]; then
    start_davinci_db
fi


