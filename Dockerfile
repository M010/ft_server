FROM debian:buster

#INSTALL UTILS
COPY	./srcs /cnf
RUN		apt-get -y update  && apt-get -y upgrade
RUN		apt-get -y install nginx mariadb-server
RUN		apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring
RUN		apt-get -y install wget
RUN		apt-get -y install vim
RUN		chmod 777 /cnf/*.sh
RUN		/cnf/set_up.sh

EXPOSE 80 443
