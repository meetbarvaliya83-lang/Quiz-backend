#!/bin/sh
set -e

echo "Running migrations..."
php /var/www/html/artisan migrate --force --no-interaction 2>&1

echo "Caching config..."
php /var/www/html/artisan config:cache 2>&1 || echo "Warning: config:cache failed"

echo "Caching routes..."
php /var/www/html/artisan route:cache 2>&1 || echo "Warning: route:cache failed"

echo "Caching views..."
php /var/www/html/artisan view:cache 2>&1 || echo "Warning: view:cache failed"

echo "Starting supervisor..."
/usr/bin/supervisord -c /etc/supervisord.conf
