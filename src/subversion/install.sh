#!/bin/bash

#https://blog.csdn.net/zengsange/article/details/80618301

apt-get update

apt-get install subversion


nohup java -jar -Dfile.encoding=UTF-8 svnWebUI.jar --server.port=6060 > /dev/null &


