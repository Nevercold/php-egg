# Dockerfile
FROM debian:bookworm

# PHP-Version 8.4
RUN apt update && apt install -y \
    nginx \
    php8.4-fpm php8.4-cli php8.4-mbstring php8.4-xml php8.4-curl php8.4-zip php8.4-mysql php8.4-gd php8.4-bcmath php8.4-intl \
    curl unzip git composer supervisor \
 && rm -rf /var/lib/apt/lists/*

# Pterodactyl erwartet /home/container als Arbeitsverzeichnis
WORKDIR /home/container

# Nginx-Konfiguration
RUN mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled
COPY nginx.conf /etc/nginx/nginx.conf
COPY site.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Supervisor zum Starten von nginx + php-fpm
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080
CMD ["/usr/bin/supervisord", "-n"]
