# docker私有化部署jira
1. 进入docker/jira目录
```
cd docker/jira
```
2. 执行下面命令
```shell
docker-compose up -d
```
3. 暴露8080端口
阿里云服务器或者是腾讯云防火墙暴露8080端口
4. 访问服务
1.15.231.74:8080
5. 设置jira

## 使用mysql
1、安装mysql客户端
```shell
sudo apt-get install mysql-server
```
2、连接数据库服务器
```shell
mysql -u root -p
```
3、执行下面sql
```sql
CREATE USER jira IDENTIFIED BY '123456';
CREATE DATABASE jira CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,REFERENCES,ALTER,INDEX on jira.* TO 'jira'@'%';
flush privileges;
```
4. 然后进入jira的配置界面，使用上面创建的用户和数据库即可
## 私有化部署连接不上mysql服务器
看看mysql容器和jira容器是否是统一个网络
### 如果mysql容器先于jira创建，且使用默认的bridge网桥。
1、查看docker网络设备
```shell
docker network ls
```
2. 看看是否含有jira-default网络设备
3. 查看mysql容器的网络设置
```shell
docker inpsect mysql
```
发现使用的bridge网桥。
4. 先取消连接该默认bridge网桥
```shell
docker network disconnect birdge mysql
```
5. 然后加入jira的默认网络jira_default
```shell
docker network connect jira_defalut mysql
```
6. 重启mysql容器
```shell
docker restart mysql
```
7. 查看mysql容器的ip地址
```shell
docker network inspect jira_defalut
```
8. 然后jira配置页面使用mysql容器的ip地址。

## 破解使用
在atlassian-agent.jar 目录下，执行。
```shell
java -jar atlassian-agent.jar \
    -d -m noodzhan@163.com -n DEV -p jira \
    -o http://192.168.0.200:8080/ -s BP7C-8LMS-P95T-QDEG
```
返回
```
====================================================
=======     Atlassian Crack Agent v1.3.1     =======
=======           https://zhile.io           =======
=======          QQ Group: 30347511          =======
====================================================

Your license code(Don't copy this line!!!): 

AAAB8w0ODAoPeJyNU12PojAUfedXkOzjBGzrKGhCsi4wOzigOKi7rxWv0lksWIozzq9fEGbnQ2M26
Uube84959zbb79grToQqwSr2Bj2yJAYqh3NVYIIUbYCgCdZnoPQfRYDL2B+zGFCd2DZ0yBwH21v5
Cu2ACpZxh0qwaqBGiYawcoViANFLFheo6wFT9mOyUpI2gDU1VFNpMyLYafzmrAUdJYpAWVcAqc8B
vclZ+LYdjMHGjKqozwxQd9UumvWUE98L/DmrqNMyt0KxHSzKEAUlvZP3BWuXGTrMpZ6fdGKbCOfq
QD9jOhKLY0lO4AlRQmfsvz4fgVeqaI2VK5FU9rGs6wa1+aIEpWr9xhPJe6BpuVpGNaGpkVL/5VoK
raUs6Kpq5OugsYDouO+qSOdIDQ0kYk6ip1xWWl1q+xTi2fZ+jWh/Dvud/U42zXUZ3G0Iu9pkViBj
ey7+/E4Xfy+DcnYmLnc6D73Zttt+RCHe3OULEYsAPJk3jzs0eLwyCZB5663onG4Xe49q2nxn2lFk
oraYeO7Ha/nWL7nRO5E83HfwP1K+62Bce/Ttlxa0AjEAUQF/xEatmb6QaSFg95cmznuT+UPHN+Gg
PsIGcjsdvGl33K+h2Ep4oQW8PWvfASfJpULVrSmK/nWBQvtdE7KHXf5F2EuRxswLAIUfCPKaP1Oh
HSknb27nHKDbo8UHQwCFFTZAw2/q8qr35F7sEj/+S8CQQsqX02nj
```

## Reusing a mysql database user on a new database caused Jira setup to fail with Database is not empty message
https://jira.atlassian.com/browse/JRASERVER-72389