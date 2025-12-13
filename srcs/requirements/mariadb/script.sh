#!/bin/bash


if [ ! -d "/var/lib/mysql/mysql" ]; then
    
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null


    cat << EOF > /tmp/init_db.sql
USE mysql;
FLUSH PRIVILEGES;

-- A. SECURITY: Remove anonymous users
DELETE FROM mysql.user WHERE User='';

-- B. SECURITY: Disallow remote root login (Root can only login locally)
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- C. SECURITY: Force Root Password (Uncommented and fixed)
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- D. SETUP: Create the Project Database
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

-- E. SETUP: Create the Secondary User
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';

FLUSH PRIVILEGES;
EOF


    echo "Running Bootstrap..."
    mysqld --user=mysql --bootstrap < /tmp/init_db.sql


    rm -f /tmp/init_db.sql
    echo "Database initialized and Secured."
fi


exec mysqld_safe --datadir=/var/lib/mysql