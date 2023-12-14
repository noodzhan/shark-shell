# 依赖的镜像
FROM atlassian/jira-software:8.22.3-ubuntu-jdk11

#镜像创建者的信息
LABEL maintainer="noodzhan noodzhan@163.com"

# 设置编码
ENV LANG C.UTF-8

# 设置时区
# ENV TZ Asia/Shanghai
ENV TZ CST-8

# 容器入口
COPY ./entrypoint.sh /entrypoint.sh
# 注意：这个CMD会覆盖原来image的命令
# CMD ["/entrypoint.py"]
# 因此，需要再次执行entrypoint.py
CMD ["bash", "/entrypoint.sh"]
