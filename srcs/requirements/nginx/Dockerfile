FROM debian:stable-slim

RUN apt update && \
    apt upgrade -y && \
    apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/ssl/server.crt -keyout /etc/ssl/server.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=nait-bou.42.fr/UID=nait-bou"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]