FROM php:7.1-fpm
MAINTAINER Kevin Smith <kevin@kevinsmith.io>

#
# Install and configure nginx
#

ENV NGINX_VERSION 1.11.9-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
    && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
    && apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
        ca-certificates \
        nginx=${NGINX_VERSION} \
        nginx-module-xslt \
        nginx-module-geoip \
        nginx-module-image-filter \
        nginx-module-perl \
        nginx-module-njs \
        gettext-base \

    # Cleanup
    && rm -rf /var/lib/apt/lists/*

# Send logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir /etc/nginx/ssl/ \
    && openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048

EXPOSE 80 443

# Install j2cli for nginx config file templates
RUN apt-get update && apt-get install -y --no-install-recommends \
    python-dev \
    python-setuptools \

    && easy_install j2cli \

    # Cleanup
    && apt-get purge -y \
        python-dev \
        python-setuptools \
    && rm -rf /var/lib/apt/lists/*

# Custom nginx config
COPY nginx /etc/nginx/imported
RUN cp /etc/nginx/imported/nginx.conf /etc/nginx/nginx.conf \
    && cp /etc/nginx/imported/certs/self-signed.crt /etc/nginx/ssl/self-signed.crt \
    && cp /etc/nginx/imported/certs/self-signed.key /etc/nginx/ssl/self-signed.key

# Copy entrypoint script
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]
