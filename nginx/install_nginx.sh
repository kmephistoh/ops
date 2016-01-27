#!/bin/bash
NGINX_VERSION="1.8.1"

#src directory(option)
mkdir -p /root/op && cd /root/op
apt-get install -y make gcc libpcre3-dev libssl-dev
groupadd nginx && useradd -s /sbin/nologin -g nginx nginx
wget http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz
tar zxf nginx-$NGINX_VERSION.tar.gz
cd nginx-$NGINX_VERSION
./configure \
--user=nginx \
--group=nginx \
--prefix=/usr/local/nginx \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_gzip_static_module \
--with-ipv6
make -j24 && make install

#create /usr/bin/nginx
if [ -f "/usr/bin/nginx" ]
then
    rm -f /usr/bin/nginx
    ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
else
    ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
fi
