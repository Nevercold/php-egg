# Dockerfile
FROM debian:bookworm

# PHP-Version 8.4
RUN apt update
RUN apt upgrade
RUN apt install ca-certificates apt-transport-https lsb-release gnupg curl nano unzip -y
RUN curl -fsSL https://packages.sury.org/php/apt.gpg -o /usr/share/keyrings/php-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/php-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
RUN apt update
RUN apt install -y \
    nginx \
    php8.4-fpm php8.4-redis php8.4-cli php8.4-mbstring php8.4-xml php8.4-curl php8.4-zip php8.4-mysql php8.4-gd php8.4-bcmath php8.4-intl \
    curl unzip git supervisor

# PHP-Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Pterodactyl erwartet /home/container als Arbeitsverzeichnis
WORKDIR /home/container

# Nginx-Konfiguration
RUN mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled
COPY nginx.conf /etc/nginx/nginx.conf
COPY site.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Supervisor zum Starten von nginx + php-fpm
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /home/container/logs

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
CMD ["/entrypoint.sh"]


