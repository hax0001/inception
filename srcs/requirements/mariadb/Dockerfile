FROM debian:stable-slim

RUN apt update && \
    apt upgrade -y && \
    apt install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf
COPY script.sh .

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
RUN mkdir -p /var/log/mysql && chown -R mysql:mysql /var/log/mysql

RUN chmod +x script.sh
EXPOSE 3306

CMD ["./script.sh"]