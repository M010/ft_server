#SQL config

service mysql start
mysql -u 	root --skip-password -e "CREATE DATABASE wordpress;"
mysql -u 	root --skip-password -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" &2>/dev/null
mysql -u 	root --skip-password -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root');FLUSH PRIVILEGES;" &2> /dev/null 

service		nginx		start
service 	php7.3-fpm	start

bash
