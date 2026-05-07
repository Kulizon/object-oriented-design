FROM kprzystalski/projobj-php:latest

USER root

WORKDIR /app

COPY composer.json composer.lock ./

RUN a2enmod rewrite && composer install --no-scripts --optimize-autoloader --no-interaction

COPY . .

RUN composer run-script post-install-cmd --no-interaction 2>/dev/null || true \
    && mkdir -p var/data var/cache var/log && chmod -R 777 var \
    && php bin/console doctrine:database:create --no-interaction 2>/dev/null || true \
    && php bin/console doctrine:schema:update --force --no-interaction 2>/dev/null || true \
    && php bin/console app:create-admin admin admin123 2>/dev/null || true \
    && echo '<VirtualHost *:8000>\n\
    DocumentRoot /app/public\n\
    <Directory /app/public>\n\
        AllowOverride All\n\
        Require all granted\n\
        FallbackResource /index.php\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf \
    && sed -i 's/Listen 80/Listen 8000/' /etc/apache2/ports.conf \
    && chmod -R 777 var

EXPOSE 8000

CMD ["apachectl", "-D", "FOREGROUND"]
