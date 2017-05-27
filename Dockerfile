FROM webhippie/php-caddy:latest
MAINTAINER Thomas Boerger <thomas@webhippie.de>

VOLUME ["/storage", "/srv/www/vendor"]

CMD ["/bin/s6-svscan", "/etc/s6"]
EXPOSE 8080
WORKDIR /srv/www

ENV SOLDER_VERSION 0.7.3.3
ENV SOLDER_TARBALL https://github.com/hecksadecimal/TechnicSolder/archive/v${SOLDER_VERSION}.tar.gz

RUN apk update && \
  apk add \
    sqlite && \
  rm -rf \
    /var/cache/apk/*

RUN curl -sLo - \
  ${SOLDER_TARBALL} | tar -xzf - --strip 1 -C /srv/www

RUN sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL ^ E_DEPRECATED/g' /etc/php7/php.ini

ADD rootfs /
