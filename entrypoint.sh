#!/bin/bash
set -e

j2 /etc/nginx/imported/default.conf.j2 > /etc/nginx/conf.d/default.conf

nginx

exec "$@"
