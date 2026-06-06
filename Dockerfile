FROM richarvey/nginx-php-fpm:php83

ENV SKIP_COMPOSER=true

COPY . /var/www/html

RUN rm -f /etc/nginx/sites-enabled/default.conf && \
    rm -f /var/www/html/.env && \
    composer install --no-dev --optimize-autoloader && \
    php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache && \
    chown -R nginx:nginx /var/www/html/storage /var/www/html/bootstrap/cache
