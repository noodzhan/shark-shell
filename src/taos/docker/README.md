# 二台机器高可用方案

1台机器，使用物理安装taos服务。
1台机器，使用docker安装两个taos服务。

## 执行

1、启动容器
```shell
docker-compose up -d
```
2、执行网络命令

将宿主机的网络和容器内的网络打通

`<桥接网络>`就是docker创建的网络地址


```shell
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -s <桥接子网> -j MASQUERADE
```

举列子：

```shell
sudo iptables -t nat -A POSTROUTING -s 172.23.0.0 -j MASQUERADE
```
