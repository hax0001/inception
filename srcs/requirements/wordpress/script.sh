#!/bin/bash

cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

if [ ! -f wp-config.php ]; then

    ./wp-cli.phar core download --allow-root

    # USE VARIABLES HERE ($MYSQL_DATABASE, etc)
    ./wp-cli.phar config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb \
        --allow-root

    # USE VARIABLES HERE ($WP_ADMIN_USER, etc)
    ./wp-cli.phar core install \
        --url=https://$DOMAIN_NAME \
        --title=Inception \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASS \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    # USE VARIABLES HERE
    ./wp-cli.phar user create \
        $WP_USER \
        $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASS \
        --allow-root
fi

exec php-fpm8.4 -F