#!/bin/sh
#chkconfig: 2345 99 10
#description: firewall_rules.sh is a script to set iptables

self_ip_list=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
self_ip_array=(${self_ip_list//$'\n'/ })
self_ip=${self_ip_array[0]}
if [ -z "${self_ip}" ]; then
	echo "failed to get own ip address"
	exit 1
fi

echo "self ip is ${self_ip}"

iptables -t filter -F
#iptables -t nat -F
#iptables -t nat -X

#self_ip=xx.xx.xx.xx
allowed_tcp_port=22,80,443,1883,3306,5432,8700,8743,8080,8848,18080,8999
allowed_tcp_port2=6379
allowed_tcp_port3=
restrict_tcp_port=
admin_ip=
###########################INPUT键###################################

iptables -P INPUT DROP
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

if [ -n "${allowed_tcp_port}" ]; then
	iptables -A INPUT -p tcp -m multiport --dports ${allowed_tcp_port} -j ACCEPT
fi

if [ -n "${allowed_tcp_port2}" ]; then
	iptables -A INPUT -p tcp -m multiport --dports ${allowed_tcp_port2} -j ACCEPT
fi

if [ -n "${allowed_tcp_port3}" ]; then
        iptables -A INPUT -p tcp -m multiport --dports ${allowed_tcp_port3} -j ACCEPT
fi

if [ -n "${restrict_tcp_port}" ]; then
	iptables -A INPUT -p tcp -m multiport --dports ${restrict_tcp_port} -s ${self_ip} -j ACCEPT
fi

if [ -n "${allowed_udp_port}" ]; then
	iptables -A INPUT -p udp -m multiport --dports ${allowed_udp_port} -j ACCEPT
fi

if [ -n "${restrict_udp_port}" ]; then
	iptables -A INPUT -p udp -m multiport --dports ${restrict_udp_port} -s ${self_ip} -j ACCEPT
fi

#禁止icmp通信-ping 不通
#iptables -A INPUT -p icmp -m limit --limit 3/s -j LOG --log-level INFO --log-prefix "ICMP packet IN: "
#iptables -A INPUT -p icmp -j DROP

#iptables -N syn-flood
#iptables -A INPUT -p tcp --syn -j syn-flood
#iptables -I syn-flood -p tcp -m limit --limit 30/s --limit-burst 60 -j RETURN
#iptables -A syn-flood -j REJECT

iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
iptables -A INPUT -s ${self_ip} -d ${self_ip} -j ACCEPT


if [ -n "${admin_ip}" ]; then
	iptables -I INPUT -s ${admin_ip} -j ACCEPT
fi
