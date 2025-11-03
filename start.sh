#!/bin/bash
cd /home/container

# Erstelle beschreibbare Verzeichnisse
mkdir -p logs run nginx web

echo "Starting PHP 8.4-FPM..."
/usr/sbin/php-fpm8.4 -y /etc/pteroconf/php-fpm.conf -D

echo "Starting Nginx..."
nginx -c /etc/pteroconf/nginx.conf -g 'daemon off;'
