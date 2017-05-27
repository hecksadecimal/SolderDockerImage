FROM webhippie/php-caddy:latest
MAINTAINER Thomas Boerger <thomas@webhippie.de>

VOLUME ["/storage", "/srv/www/vendor"]

CMD ["/bin/s6-svscan", "/etc/s6"]
EXPOSE 8080
WORKDIR /srv/www

ENV SOLDER_VERSION 0.7.3.3
ENV SOLDER_TARBALL https://github.com/hecksadecimal/TechnicSolder/archive/v${SOLDER_VERSION}.tar.gz

RUN apk update && \
    apk add --force --update \
    php5 \
    php5-common \
    php5-cli \
    php5-fpm \
    php5-opcache \
    php5-xml \
    php5-ctype \
    php5-ftp \
    php5-gd \
    php5-json \
    php5-posix \
    php5-curl \
    php5-dom \
    php5-pdo \
    php5-pdo_mysql \
    php5-sockets \
    php5-zlib \
    php5-mcrypt \
    php5-pcntl \
    php5-mysql \
    php5-mysqli \
    php5-sqlite3 \
    php5-bz2 \
    php5-pear \
    php5-exif \
    php5-phar \
    php5-openssl \
    php5-posix \
    php5-zip \
    php5-calendar \
    php5-iconv \
    php5-imap \
    php5-soap \
    php5-xsl \
    php5-ldap \
    php5-bcmath \
    && \
  apk add \
    sqlite && \
  rm -rf \
    /var/cache/apk/*

RUN curl -sLo - \
  ${SOLDER_TARBALL} | tar -xzf - --strip 1 -C /srv/www

ADD rootfs /
