FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

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
    curl unzip git

# PHP-Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Erstelle beschreibbare Verzeichnisse
RUN mkdir -p /home/container/{web,logs,run,nginx} /etc/pteroconf

# Kopiere statische Konfigurationen außerhalb von /home/container
COPY nginx.conf /etc/pteroconf/nginx.conf
COPY php-fpm.conf /etc/pteroconf/php-fpm.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080
WORKDIR /home/container

CMD ["/bin/bash", "/start.sh"]