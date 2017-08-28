#/bin/sh
#基本设定
#PHP_VERSION="5.6.31"
PHP_VERSION="7.1.8"
PREFIX_PATH="/usr/local/services"
SOFT_URL="http://ip:port"

#系统依赖
groupadd www-data
useradd -s /sbin/nologin -g www-data www-data
yum -y install gcc gcc-c++ make automake autoconf
yum -y install libxml2-devel  openssl-devel pcre-devel sqlite-devel bzip2-devel \
libcurl-devel freetype-devel gd-devel readline-devel libmcrypt-devel libicu-devel

# 下载编译安装,注意opensll目录（opensll 默认安装后的目录的prefix）
tar -xvf php-$PHP_VERSION.tar.xz
cd php-$PHP_VERSION
./configure \
   --prefix=$PREFIX_PATH/php-$PHP_VERSION \
   --with-pdo-mysql=mysqlnd \
   --with-mcrypt \
   --with-bz2 \
   --with-gd \
   --with-freetype-dir \
   --with-jpeg-dir \
   --with-png-dir \
   --with-zlib-dir \
   --with-libxml-dir \
   --with-readline \
   --with-curl \
   --with-pear \
   --with-openssl=/usr/local/ssl \
   --with-fpm-user=www-data \
   --with-fpm-group=www-data \
   --enable-fpm \
   --enable-xml \
   --enable-bcmath \
   --enable-shmop \
   --enable-sysvsem \
   --enable-inline-optimization \
   --enable-mbregex \
   --enable-mbstring \
   --enable-gd-native-ttf \
   --enable-pcntl \
   --enable-sockets \
   --enable-soap \
   --enable-session \
   --enable-zip
make -j2 && make install

#下载配置
#curl -o $PREFIX_PATH/php-$PHP_VERSION/lib/php.ini $SOFT_URL/php/php.ini
#curl -o $PREFIX_PATH/php-$PHP_VERSION/etc/php-fpm.conf $SOFT_URL/php/php-fpm.conf

#启动项设置
#curl -o /etc/init.d/php-fpm $SOFT_URL/php/php-fpm

#软连接设置
#rm -f /usr/bin/php /usr/bin/phpize /usr/bin/pecl /usr/bin/php-config

ln -s $PREFIX_PATH/php-$PHP_VERSION/bin/php /usr/bin/php
ln -s $PREFIX_PATH/php-$PHP_VERSION/bin/phpize /usr/bin/phpize
ln -s $PREFIX_PATH/php-$PHP_VERSION/bin/pecl /usr/bin/pecl
ln -s $PREFIX_PATH/php-$PHP_VERSION/bin/php-config /usr/bin/php-config
echo 'ok'
