FROM debian:buster

#INSTALL UTILS
ARG 		SITE=the_site
ARG		SITE_DIR=/var/www/$SITE


COPY		./srcs/*.sh /cnf/
RUN		chmod 777 /cnf/*.sh

RUN		apt-get -y update  && apt-get -y upgrade
RUN		apt-get -y install nginx mariadb-server
#RUN		apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring
RUN 		apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN		apt-get -y install wget
RUN		apt-get -y install vim

#Accses
RUN		chown -R www-data /var/www/*
RUN		chmod -R 755 /var/www/*
RUN		mkdir	$SITE_DIR/

# SSL
RUN		mkdir /etc/nginx/ssl
RUN		openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
			-out /etc/nginx/ssl/the_site.pem -keyout /etc/nginx/ssl/the_site.key \
			-subj "/C=RF/ST=Msk/L=Moscow/O=21sch/OU=sbashir/CN=the_site"

#nginx config
COPY		./srcs/nginx_conf /etc/nginx/sites-available/$SITE
RUN		ln -s /etc/nginx/sites-available/$SITE /etc/nginx/sites-enabled/$SITE
RUN		rm -rf /etc/nginx/sites-enabled/default

WORKDIR		/tmp

#phpmyadmin
RUN		wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN		tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN		mkdir $SITE_DIR/phpmyadmin
RUN		mv phpMyAdmin*es/* $SITE_DIR/phpmyadmin/

#wordpress
RUN		wget https://wordpress.org/latest.tar.gz
RUN		tar -xzf latest.tar.gz
RUN		mv wordpress $SITE_DIR 
COPY 		./srcs/wp-config.php $SITE_DIR/wordpress/

RUN		mv wordpress $SITE_DIR 
CMD		bash /cnf/set_up.sh 
EXPOSE 80 443
