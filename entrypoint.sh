#!/bin/bash
# Ensure logs directory exists
mkdir -p /home/container/logs

# Start supervisor with your config
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
