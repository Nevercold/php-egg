#!/bin/bash
cd /home/container

# Starte PHP-FPM im Hintergrund
echo "Starting PHP 8.4-FPM..."
/usr/sbin/php-fpm8.4 -D

# Starte Nginx im Vordergrund (damit Container aktiv bleibt)
echo "Starting Nginx..."
nginx -g 'daemon off;'
