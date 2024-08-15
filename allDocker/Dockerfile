# 阶段一：构建MySQL镜像
FROM centos:8 AS mysql-builder

# 安装MySQL依赖
RUN dnf -y module enable mysql:8.0 && \
    dnf -y install mysql-server

# 设置MySQL配置文件
COPY mysql/my.cnf /etc/my.cnf

# 初始化MySQL数据库
RUN mysqld --initialize-insecure --user=mysql

# 启动MySQL服务
CMD ["mysqld"]


# 阶段二：构建PostgreSQL镜像
FROM centos:8 AS postgres-builder

# 安装PostgreSQL依赖
RUN dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm && \
    dnf -y install postgresql13-server

# 初始化PostgreSQL数据库
RUN /usr/pgsql-13/bin/postgresql-13-setup initdb

# 启动PostgreSQL服务
CMD ["/usr/pgsql-13/bin/postgres", "-D", "/var/lib/pgsql/13/data", "-c", "config_file=/var/lib/pgsql/13/data/postgresql.conf"]


# 阶段三：构建Kafka镜像
FROM centos:8 AS kafka-builder

# 安装Java运行时环境和其他依赖
RUN dnf -y install java-11-openjdk-devel wget

# 下载并解压Kafka
RUN wget -q https://downloads.apache.org/kafka/2.8.1/kafka_2.13-2.8.1.tgz && \
    tar xf kafka_2.13-2.8.1.tgz

# 配置Kafka
COPY kafka/server.properties /kafka_2.13-2.8.1/config/server.properties

# 启动Kafka服务
CMD ["/kafka_2.13-2.8.1/bin/kafka-server-start.sh", "/kafka_2.13-2.8.1/config/server.properties"]


# 阶段四：运行时镜像
FROM centos:8

# 安装MySQL客户端
RUN dnf -y module enable mysql:8.0 && \
    dnf -y install mysql

# 安装PostgreSQL客户端
RUN dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm && \
    dnf -y install postgresql13

# 安装Java运行时环境
RUN dnf -y install java-11-openjdk

# 从构建MySQL阶段复制MySQL数据库文件
COPY --from=mysql-builder /var/lib/mysql /var/lib/mysql

# 从构建PostgreSQL阶段复制PostgreSQL数据库文件
COPY --from=postgres-builder /var/lib/pgsql /var/lib/pgsql

# 从构建Kafka阶段复制Kafka安装目录
COPY --from=kafka-builder /kafka_2.13-2.8.1 /kafka

# 配置环境变量和其他设置（如端口号等）

# 启动所需的服务（MySQL、PostgreSQL、Kafka等）
CMD ["mysqld", "--user=mysql"]  # 这里可以根据需要启动其他服务
