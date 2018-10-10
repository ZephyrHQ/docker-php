# Building environnement
FROM alpine:3.8

# ensure www-data user exists
RUN apk add --update --no-cache php7 \
    # fpm
    php7-fpm \
    # Base
    php7-dom \
    php7-opcache \
    php7-phar \
    php7-openssl \
    php7-curl \
    php7-ctype \
    php7-xml \
    php7-tokenizer \
    php7-iconv \
    php7-json \
    php7-mbstring \
    && echo "Fin des installation php"

WORKDIR /app

COPY www.conf /etc/php7/php-fpm.d/www.conf
EXPOSE 9000

COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

ENV APP_ENV=prod
ENV APP_SECRET=6f6602bcbac5846fcf2a3f245148ef3e

ENTRYPOINT ["entrypoint"]

CMD ["/usr/sbin/php-fpm7", "-F"]
