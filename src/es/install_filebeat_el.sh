#!/usr/bin/env bash

# https://www.elastic.co/guide/en/beats/filebeat/7.6/multiline-examples.html
#http://172.16.1.41:5601/app/kibana#/home/tutorial/nginxLogs
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.2-x86_64.rpm
sudo rpm -vi filebeat-7.6.2-x86_64.rpm
sudo cp ./filebeat.yml /etc/filebeat
sudo systemctl start filebeat