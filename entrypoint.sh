#!/bin/bash
# Ensure logs directory exists
mkdir -p /home/container/logs
mkdir -p /run/php
mkdir -p /run/nginx

chown -R www-data:www-data /home/container

# Start supervisor with your config
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
