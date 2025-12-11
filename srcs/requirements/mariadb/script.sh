#!/bin/bash

# 1. Install the database if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    # 2. CREATE THE SQL FILE TEMPORARILY
    # We create a temp file with the SQL commands using the .env variables
    cat << EOF > /tmp/init_db.sql
USE mysql;
FLUSH PRIVILEGES;

-- 1. Create the Database
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

-- 2. Create the User (using .env variables)
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';

-- 3. Alter Root (Optional but recommended)
-- ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

FLUSH PRIVILEGES;
EOF

    # 3. RUN IN BOOTSTRAP MODE
    # This runs the SQL commands directly on the files without starting the server network.
    # No sleep or loops needed!
    echo "Running Bootstrap..."
    mysqld --user=mysql --bootstrap < /tmp/init_db.sql

    # Clean up
    rm -f /tmp/init_db.sql
    echo "Database initialized."
fi

# 4. START THE SERVER (PID 1)
# This is the final command that keeps the container alive.
# It replaces the shell script with the actual database process.
exec mysqld_safe --datadir=/var/lib/mysql