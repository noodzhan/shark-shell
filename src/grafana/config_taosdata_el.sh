#!/usr/bin/env bash
sudo systemctl start taosadapter
sudo iptables -A INPUT -p tcp --dport 6041 -j ACCEPT

