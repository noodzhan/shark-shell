#!/bin/sh

# 添加MySQL驱动
cp /drivers/mysql-connector-java-8.0.25.jar /opt/atlassian/jira/lib
cp /drivers/atlassian-agent.jar /opt/atlassian/jira/
# 设置权限，没必要，jar包默认root权限即可
# chown -R jira:jira /opt/atlassian/jira/lib/mysql-connector-java-8.0.25.jar
echo "copy mysql driver finished"

# start jira
/entrypoint.py
