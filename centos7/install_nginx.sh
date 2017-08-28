#!/bin/bash
NGINX_VERSION="1.12.1"
PREFIX_PATH="/usr/local/services"
CPUS=`cat /proc/cpuinfo |grep "processor"|wc -l`
yum -y install gcc gcc-c++ make zlib-devel pcre-devel openssl-devel
groupadd www-data
useradd -s /sbin/nologin -g www-data www-data
#mkdir -p /root/op && cd /root/op
#curl -o /root/op/nginx-$NGINX_VERSION.tar.gz http:///nginx-$NGINX_VERSION.tar.gz
tar zxf nginx-$NGINX_VERSION.tar.gz
cd nginx-$NGINX_VERSION
# 注意解压后openssl 和php 解压后的目录同层
./configure \
      --prefix=$PREFIX_PATH/nginx\
      --user=www-data \
      --group=www-data \
      --pid-path=/var/run/nginx.pid \
      --with-http_stub_status_module \
      --with-http_ssl_module \
      --with-openssl=../openssl-1.0.2l \
      --with-http_gzip_static_module \
      --with-ipv6

make -j$CPUS && make install

if [ -f "/usr/bin/nginx" ]
then
    rm -f /usr/bin/nginx
    ln -s $PREFIX_PATH/nginx/sbin/nginx /usr/bin/nginx
else
    ln -s $PREFIX_PATH/nginx/sbin/nginx /usr/bin/nginx
fi
