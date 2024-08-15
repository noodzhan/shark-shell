CREATE USER 'grafana'@'%' IDENTIFIED BY 'ypkj@1234';
GRANT ALL PRIVILEGES ON *.* TO 'grafana'@'%';
flush privileges;