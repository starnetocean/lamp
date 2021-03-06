#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#===============================================================================================
#   SYSTEM REQUIRED:  CentOS-5 (32bit/64bit) or CentOS-6 (32bit/64bit)
#   DESCRIPTION:  xcache for LAMP
#===============================================================================================
cur_dir=`pwd`
cd $cur_dir
#download xcache-1.3.2
if [ -s xcache-1.3.2.tar.gz ]; then
  echo "xcache-1.3.2.tar.gz [found]"
  else
  echo "xcache-1.3.2.tar.gz not found!!!download now......"
  if ! wget http://teddysun.googlecode.com/files/xcache-1.3.2.tar.gz;then
    echo "Failed to download xcache-1.3.2.tar.gz,please download it to $cur_dir directory manually and rerun the install script."
 exit 1
 fi
fi

#install xcache
echo "============================xcache install================================================"
mkdir -p $cur_dir/untar/
rm -rf $cur_dir/untar/*
tar xzf xcache-1.3.2.tar.gz -C $cur_dir/untar/
cd $cur_dir/untar/xcache-1.3.2
export PHP_PREFIX="/usr/local/php"
$PHP_PREFIX/bin/phpize
./configure --enable-xcache -with-php-config=$PHP_PREFIX/bin/php-config
make install
rm -rf /data/www/default/xcache
cp -r admin/ /data/www/default/xcache
chmod -R 755 /data/www/default/xcache
rm -rf /tmp/{pcov,phpcore}
mkdir /tmp/{pcov,phpcore}
chown apache:apache /tmp/{pcov,phpcore}
chmod 700 /tmp/{pcov,phpcore}
cat >>/usr/local/php/etc/php.ini<<-EOF

[xcache-common]
extension = /usr/local/php/lib/php/extensions/no-debug-non-zts-20090626/xcache.so

[xcache.admin]
xcache.admin.user = "admin"
xcache.admin.pass = "e10adc3949ba59abbe56e057f20f883e"
xcache.admin.enable_auth = On
xcache.test = Off
xcache.coredump_directory = "/tmp/phpcore"
xcache.disable_on_crash = ""

[xcache]
xcache.cacher = On
xcache.size = 64M
xcache.count = 1
xcache.slots = 8K
xcache.ttl = 3600
xcache.gc_interval = 60
xcache.var_size = 1M
xcache.var_count = 1
xcache.var_slots = 8K
xcache.var_ttl = 3600
xcache.var_maxttl = 0
xcache.var_gc_interval = 60
xcache.readonly_protection = Off
xcache.mmap_path = "/dev/zero"

[xcache.optimizer]
xcache.optimizer = On

[xcache.coverager]
xcache.coverager = Off
xcache.coverager_autostart =  On
xcache.coveragedump_directory = "/tmp/pcov"
EOF
service httpd restart
echo "============================xcache install completed======================================"
exit
