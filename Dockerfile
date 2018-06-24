FROM php:7.2-cli-alpine

LABEL maintainer="Nicolas de Marqué <ndm@zephyr-web.fr>"
LABEL maintainer="Thomas Talbot <thomas.talbot@zephyr-web.fr>"

ENV PS1 '\u@\h:\w\$ '
RUN apk --no-cache add icu-dev \
    && docker-php-ext-install intl \
    && apk --no-cache add --upgrade icu-libs
#
COPY docker/entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

# Environment variables
ENV WKHTMLTOX_VERSION 0.12.4
RUN  mkdir -p /tmp/patches
COPY docker/wkhtmltopdf/conf/* /tmp/patches/
COPY docker/wkhtmltopdf/wkhtmltopdf.install.sh /usr/local/bin/wkhtmltopdf.install
RUN chmod +x /usr/local/bin/wkhtmltopdf.install \
    && sh /usr/local/bin/wkhtmltopdf.install
    
WORKDIR /app
#
EXPOSE 80

ENTRYPOINT ["entrypoint"]

CMD ["watch", "ls"]    
