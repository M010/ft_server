#SQL_config
ITE=the_site
SITE_DIR=/var/www/$SITE

cd /tmp
mkdir $SITE_DIR
touch $SITE_DIR/index.php && echo "<?php phpinfo(); ?>" >> $SITE_DIR/index.php

#Accses
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# SSL
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/the_site.pem -keyout /etc/nginx/ssl/the_site.key -subj "/C=RF/ST=Msk/L=Moscow/O=21sch/OU=sbashir/CN=the_site"

#SQL config
service mysql start
mysql -u root --skip-password -e "CREATE DATABASE wordpress;"
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"
mysql -u root --skip-password -e "update mysql.user set plugin='mysql_native_password' where user='root';"
mysql -u root --skip-password -e "FLUSH PRIVILEGES;"
#echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
#echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
#echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
#echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#nginx config
mv /cnf/nginx_conf /etc/nginx/sites-available/$SITE
ln -s /etc/nginx/sites-available/$SITE /etc/nginx/sites-enabled/$SITE
rm -rf /etc/nginx/sites-enabled/default

#phpmyadmin
mkdir /var/www/thesite/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin*es $SITE_DIR/phpmyadmin
#start servise


#wordpress
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress $SITE_DIR 
mv /cnf/wp-config.php $SITE_DIR/wordpress/

service nginx start
bash
