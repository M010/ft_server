#!/bin/bash

cp /etc/nginx/sites-available/the_site /cnf/tmp
mv /cnf/nginx_conf_2  /etc/nginx/sites-available/the_site
mv /cnf/tmp /cnf/nginx_conf_2
nginx -s reload 
