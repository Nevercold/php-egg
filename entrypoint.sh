#!/bin/bash
# Ensure logs directory exists
mkdir -p /home/container/logs
mkdir -p /home/container/run/php
mkdir -p /home/container/run/nginx

sed -i 's|/run/php/php8.4-fpm.sock|/home/container/run/php/php8.4-fpm.sock|g' /etc/php/8.4/fpm/pool.d/www.conf


# Start supervisor with your config
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
