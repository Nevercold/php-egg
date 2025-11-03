#!/bin/bash
cd /home/container

# Erstelle beschreibbare Verzeichnisse
mkdir -p /home/container/{logs,run,nginx,web}

echo "Starting PHP 8.4-FPM..."
/usr/sbin/php-fpm8.4 -y /home/container/php-fpm.conf -D

echo "Starting Nginx..."
nginx -c /home/container/nginx.conf -g 'daemon off;'
