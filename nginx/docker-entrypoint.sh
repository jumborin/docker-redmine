#!/bin/sh
set -e

# 環境変数のデフォルト値設定
export NGINX_WORKERS=${NGINX_WORKERS:-1}
export NGINX_MAX_UPLOAD_SIZE=${NGINX_MAX_UPLOAD_SIZE:-20m}

# 環境変数を設定ファイルに展開
envsubst '${NGINX_WORKERS}' < /etc/nginx/nginx.conf > /tmp/nginx.conf
mv /tmp/nginx.conf /etc/nginx/nginx.conf

envsubst '${NGINX_MAX_UPLOAD_SIZE}' < /etc/nginx/conf.d/default.conf > /tmp/default.conf
mv /tmp/default.conf /etc/nginx/conf.d/default.conf

# Nginxを起動
exec nginx -g 'daemon off;'
