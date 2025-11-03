#!/bin/bash
cd /home/container

# Erstelle beschreibbare Verzeichnisse
mkdir -p /home/container/logs /run/php /var/tmp/nginx

# Passe Nginx runtime dirs an (damit keine Schreibversuche in /var/lib passieren)
rm -rf /var/lib/nginx
ln -s /var/tmp/nginx /var/lib/nginx

echo "Starting PHP 8.4-FPM..."
/usr/sbin/php-fpm8.4 -y /etc/php/8.4/fpm/php-fpm.conf -D

echo "Starting Nginx..."
nginx -g 'daemon off;'
