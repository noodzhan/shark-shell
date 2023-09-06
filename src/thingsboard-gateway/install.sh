#!/bin/bash
wget https://github.com/thingsboard/thingsboard-gateway/releases/latest/download/python3-thingsboard-gateway.deb

sudo apt install ./python3-thingsboard-gateway.deb -y

systemctl status thingsboard-gateway
