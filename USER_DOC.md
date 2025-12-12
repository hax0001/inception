# User Documentation

## 1. Services Provided
This stack provides a complete, self-hosted WordPress website:
* **Web Server (NGINX):** Secures your connection using HTTPS.
* **CMS (WordPress):** Allows you to create and manage website content.
* **Database (MariaDB):** Securely stores your users, posts, and settings.

## 2. Start and Stop the Project
All controls are managed via the `Makefile` at the project root.

* **Start:** `make`
    (Builds images, creates volumes, and starts the system).
* **Stop:** `make down`
    (Stops containers but keeps data).
* **Clean:** `make clean`
    (Removes containers and networks).

## 3. Accessing the Website
* **Front End:** Open your browser to `https://nait-bou.42.fr`.
    *Note: You must accept the self-signed certificate warning.*
* **Admin Dashboard:** Go to `https://nait-bou.42.fr/wp-admin`.

## 4. Managing Credentials
Credentials are not hardcoded. They are managed in the configuration file:
* **File Location:** `srcs/.env`
* **To View/Change:** Open the file in a text editor.
    * Database Passwords: `MYSQL_PASSWORD`
    * Admin Login: `WP_ADMIN_USER` / `WP_ADMIN_PASS`

## 5. Checking Service Status
To ensure everything is running:
1.  Run `docker ps` in the terminal. You should see 3 containers (nginx, wordpress, mariadb) with status **Up**.
2.  Run `make logs` to view real-time activity and ensure no errors are occurring.

## 6. Checking Service volumes
1.  Run 'docker inspect -f '{{ .Name }}: {{ range .Mounts }}{{ .Source }} -> {{ .Destination }}{{ end }}' nginx wordpress mariadb'

docker exec -it mariadb mariadb -u wpuser -p

SHOW DATABASES;

USE wordpress;

SHOW TABLES;

SELECT comment_author, comment_content FROM wp_comments;