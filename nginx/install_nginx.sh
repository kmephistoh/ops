#! /bin/bash
groupadd nginx
useradd -s /sbin/nologin -g nginx nginx
wget http://nginx.org/download/nginx-1.7.12.tar.gz
tar zxf nginx-1.7.12.tar.gz
cd nginx-1.7.12
./configure --user=nginx --group=nginx --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6
make && make install
ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
