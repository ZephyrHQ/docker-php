FROM alpine:3.7

# ensure www-data user exists
RUN apk add --update --no-cache php7 \
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
    php7-redis \
    # Serveur
    lighttpd \
    php7-cgi \
    fcgi \
    && echo "Fin des installation php"

WORKDIR /app

EXPOSE 80

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
RUN mkdir /run/lighttpd/ \
    && chown lighttpd:lighttpd /run/lighttpd/

COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

ENV APP_ENV=prod
ENV APP_SECRET=6f6602bcbac5846fcf2a3f245148ef3e

ENTRYPOINT ["entrypoint"]

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
