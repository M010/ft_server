FROM debian:buster

#INSTALL UTILS
COPY	./srcs /cnf
RUN		apt-get -y update  && apt-get -y upgrade
RUN		apt-get -y install nginx mariadb-server
#RUN	apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring
RUN 	apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN		apt-get -y install wget
RUN		apt-get -y install vim
#RUN		chmod 777 /cnf/*.sh
RUN 	SITE=the_site
RUN		SITE_DIR=/var/www/$SITE
RUN		mkdir	$SITE_DIR
RUN		touch	$SITE_DIR/index.php && echo "<?php phpinfo(); ?>" >> $SITE_DIR/index.php

#Accses
RUN		chown -R www-data /var/www/*
RUN		chmod -R 755 /var/www/*

# SSL
RUN		mkdir /etc/nginx/ssl
RUN		openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/the_site.pem -keyout /etc/nginx/ssl/the_site.key -subj "/C=RF/ST=Msk/L=Moscow/O=21sch/OU=sbashir/CN=the_site"

#SQL config
RUN 	service mysql start
RUN 	mysql -u root --skip-password -e "CREATE DATABASE wordpress;"
RUN 	mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"
RUN 	mysql -u root --skip-password -e "update mysql.user set plugin='mysql_native_password' where user='root';"
RUN 	mysql -u root --skip-password -e "FLUSH PRIVILEGES;"
#echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
#echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
#echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
#echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#nginx config
COPY	./srcs/nginx_conf /etc/nginx/sites-available/$SITE
RUN		ln -s /etc/nginx/sites-available/$SITE /etc/nginx/sites-enabled/$SITE
RUN		rm -rf /etc/nginx/sites-enabled/default

WORKDIR /tmp
RUN		mkdir /var/www/thesite/phpmyadmin

#phpmyadmin
RUN		wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN		tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN		mv phpMyAdmin*es $SITE_DIR/phpmyadmin
#start servise


#wordpress
RUN		wget https://wordpress.org/latest.tar.gz
RUN		tar -xzf latest.tar.gz
RUN		mv wordpress $SITE_DIR 
COPY 	./srcs/wp-config.php $SITE_DIR/wordpress/

EXPOSE 80 443
CMD		bash 
#/cnf/set_up.sh
