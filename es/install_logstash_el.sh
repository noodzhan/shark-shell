#!/usr/bin/env bash
wget https://www.noodb.com/resource/software/logstash-7.6.2.rpm
sudo rpm -ivh logstash-7.6.2.rpm
sudp cp ./logstash_pipeline.conf /etc/logstash/conf.d/
sudo systemctl restart logstash