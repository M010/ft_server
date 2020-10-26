#SQL_config
SITE=the_site
SITE_DIR=/var/www/$SITE

cd /tmp
mkdir $SITE_DIR
touch $SITE_DIR/index.php && echo "<?php phpinfo(); ?>" >> $SITE_DIR/index.php

#Accses
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

#SQL config
service mysql start
echo -e "n\ny\ny\ny\n" | mysql_secure_installation
mysql -u root --skip-password -e "CREATE DATABASE wordpress;"
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"
mysql -u root --skip-password -e "update mysql.user set plugin='mysql_native_password' where user='root';"
mysql -u root --skip-password -e "FLUSH PRIVILEGES;"

#nginx config
mv /cnf/nginx_conf /etc/nginx/sites-available/$SITE
ln -s /etc/nginx/sites-available/$SITE /etc/nginx/sites-enabled/$SITE
rm -rf /etc/nginx/sites-enabled/default

#phpmyadmin
mkdir /var/www/thesite/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin*es $SITE_DIR/phpmyadmin

#wordpress
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress $SITE_DIR 
mv /cnf/wp-config.php $SITE_DIR/wordpress/

service nginx start
bash
