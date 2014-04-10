#!/bin/sh
#PHPRC=$HOME/wordpress
#export PHPRC
PHP_FCGI_CHILDREN=4
export PHP_FCGI_CHILDREN
exec /home/me/bin/php-cgi
