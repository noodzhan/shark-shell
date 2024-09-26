## linux 看门狗使用方法

## 安装方法

crontab -e

*/5 * * * * bash /opt/watchdog/nacos_watchdog.sh
*/5 * * * * bash /opt/watchdog/kafka_watchdog.sh


## 监控nacos


1、判断nacos监听的端口是否存在

2、是否能登录成功。

每个5分钟判断这两个条件，都满足表示存活，否则就重启nacos


## 监控kafka

只要zookeeper或者是kafka监听的端口不存在，就重启kafka。


