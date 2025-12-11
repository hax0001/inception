FROM debian:stable-slim

RUN apt update && \
    apt upgrade -y && \
    apt install -y php-fpm php-mysqli curl

COPY www.conf /etc/php/8.4/fpm/pool.d/www.conf
COPY script.sh .

RUN chmod +x script.sh
    
EXPOSE 9000

CMD ["./script.sh"]