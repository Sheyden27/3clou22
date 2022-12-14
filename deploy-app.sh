#!/usr/bin/env bash

php_ini="/etc/php/7.4/apache2/php.ini"

apt -y install php php-common php-mysql php-gmp php-curl php-intl php-mbstring php-xmlrpc php-gd php-xml php-cli php-zip

mv index.php /var/www/html/

sed -i \
    -e 's/max_execution_time = .*/max_execution_time = 300/' \
    -e 's/upload_max_filesize = .*/upload_max_filesize = 100M/' \
    -e 's/post_max_size = .*/post_max_size = 128M/' $php_ini

mysql_secure_installation <<EOF

y
secret
secret
y
y
y
y
EOF

sudo mysql -u root -p <<EOF
CREATE DATABASE wordpress;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'root';
GRANT ALL ON wordpress.* TO 'wp_user'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT
EOF

cd /var/www/html/
rm index.html

nano /etc/apache2/sites-available/wordpress.conf <<EOF

<VirtualHost *:80>
   ServerName wordpress.example.com
   ServerAlias www.wordpress.example.com
   ServerAdmin admin@computingforgeeks.com
   DocumentRoot /var/www/html/

   ErrorLog ${APACHE_LOG_DIR}/wordpress_error.log
   CustomLog ${APACHE_LOG_DIR}/wordpress_access.log combined


   <Directory /var/www/html>
      Options FollowSymlinks
      AllowOverride All
      Require all granted
   </Directory>

</VirtualHost>
EOF

sudo a2ensite wordpress
sudo a2enmod rewrite ssl

sudo systemctl restart apache2