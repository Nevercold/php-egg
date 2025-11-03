FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y \
    nginx \
    php8.4-fpm php8.4-cli php8.4-mysql php8.4-xml php8.4-gd php8.4-curl php8.4-zip php8.4-mbstring php8.4-intl php8.4-bcmath \
    curl \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Setup working dir
WORKDIR /home/container

# Copy configs
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose port
EXPOSE 8080

# Entry point
CMD ["/bin/bash", "/start.sh"]
