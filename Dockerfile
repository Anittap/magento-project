From php:8.2-apache
WORKDIR /var/www/html/
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libxml2-dev \
    git \
    unzip
RUN apt-get update && apt-get install -y \
    libonig-dev \
    build-essential \
    libgd-dev \
    libzip-dev 
RUN apt-get update && apt-get install -y  libxslt-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd
RUN docker-php-ext-install xsl sockets zip
RUN docker-php-ext-install intl  pdo_mysql opcache  bcmath soap
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY ./apache2.conf /etc/apache2/apache2.conf
COPY ./php.ini /usr/local/etc/php/php.ini
COPY ./magento.anitta.cloud.conf /etc/apache2/sites-available/
RUN apt install systemctl -y
RUN a2enmod rewrite mpm_prefork && \
    a2ensite magento.anitta.cloud.conf
RUN git config --global --add safe.directory /var/www/html
RUN git clone https://github.com/magento/magento2.git . && \
    git checkout 2.4 && \
    composer install
EXPOSE 80
CMD ["apache2-foreground"]
