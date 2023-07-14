# 二台机器高可用方案

1台机器，使用物理安装taos服务。
1台机器，使用docker安装两个taos服务。

docker 版本：`Docker version 18.09.0, build dc32e88`
docker compose 版本：`Docker Compose version v2.2.2`

## 执行

0、修改docker-compose文件，把主库taos的地址换成现场地址，两个容器都要改。

```shell
      extra_hosts:
        - "taosnode1:192.168.1.118"
```

1、启动容器
```shell
docker-compose up -d
```
2、执行网络命令

将宿主机的网络和容器内的网络打通

`<桥接网络>`就是docker创建的网络地址


```shell
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -s 172.23.0.1 -j MASQUERADE
```

3、在本机上 vim /etc/hosts 添加下面

taosnode1 就是主库taos的地址。
```shell
127.0.0.1  taosnode2 taosnode3
192.168.1.118 taosnode1
```


## 在主库上修改hosts文件 

1、把地址改为装docker的那台机器上。
```shell
192.168.1.80  taosnode2 taosnode3
```

2、输入taos,执行下面命令

```shell
create dnode "taosnode2:7030";
create dnode "taosnode3:8030";
```

3、看看集群状态

```shell
show dnodes;
show mnodes; 
```