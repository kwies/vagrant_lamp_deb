#!/bin/sh
if cd "`dirname \"$0\"`"; then
    absdirpath=`pwd`
    cd "$OLDPWD" || exit 1
else
    exit 1
fi
SCRIPTDIR=$absdirpath
BASEDIR=$(dirname $SCRIPTDIR)
SCRIPTNAME=$(basename $0 .sh)

echo ""
echo "===== $SCRIPTNAME ====="
echo ""

echo "install misc dependencies .."
apt-get install -y ntp lynx finger zip bzip2 vim curl git subversion git-svn

echo "install 'http' .."
apt-get install -y apache2

echo "install and configure 'mysql' .."
echo mysql-server mysql-server/root_password select "vagrant" | debconf-set-selections
echo mysql-server mysql-server/root_password_again select "vagrant" | debconf-set-selections
apt-get install -y mysql-server

echo "install 'php' and 'php-fpm' .."
apt-get install -y php5
apt-get install -y php5-fpm
#modules
apt-get install -y php5-cli php5-mysql php5-gd php5-curl php5-ldap php-soap php-pear php5-imap

echo "configure 'php-fpm' .."
mkdir -p /var/lib/php-fpm/session
groupadd phpsession
chown root:phpsession /var/lib/php-fpm/session/
chmod 770 /var/lib/php-fpm/session/
usermod -a -G phpsession vagrant
cp /vagrant_config/files/php-fpm/vagrant.conf /etc/php5/fpm/pool.d/vagrant.conf
sed -i '/^listen = /clisten = 0.0.0.0:9000' /etc/php5/fpm/pool.d/www.conf

echo "install php 70 optional .."
echo 'deb http://packages.dotdeb.org jessie all' > /etc/apt/sources.list.d/dotdeb.list
curl http://www.dotdeb.org/dotdeb.gpg | apt-key add -
apt-get update
apt-get install -y php7.0-fpm php7.0-cli php7.0-mysql php7.0-gd php7.0-curl php7.0-ldap php7.0-imap
cp /vagrant_config/files/php-fpm/vagrant_php7.conf /etc/php/7.0/fpm/pool.d/vagrant.conf
echo "" > /etc/php/7.0/fpm/pool.d/www.conf

echo "install phpmyadmin .."
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean false' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password vagrant' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password vagrant' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/password-confirm password vagrant' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/setup-password password vagrant' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/database-type select mysql' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password vagrant' | debconf-set-selections
echo 'dbconfig-common dbconfig-common/mysql/app-pass password vagrant' | debconf-set-selections
echo 'dbconfig-common dbconfig-common/mysql/app-pass password' | debconf-set-selections
echo 'dbconfig-common dbconfig-common/password-confirm password vagrant' | debconf-set-selections
echo 'dbconfig-common dbconfig-common/app-password-confirm password vagrant' | debconf-set-selections
echo 'dbconfig-common dbconfig-common/app-password-confirm password vagrant' | debconf-set-selections
echo 'dbconfig-common dbconfig-common/password-confirm password vagrant' | debconf-set-selections
apt-get install -y phpmyadmin

echo "configure 'http' .."

# modules
a2enmod rewrite
a2enmod headers
a2enmod proxy
a2enmod proxy_fcgi

# root index for document root
cp /vagrant_config/files/apache/docroot.php /var/www/html/index.php

echo "init dirs .."
mkdir -p /home/vagrant/logs
chown -R vagrant:vagrant /home/vagrant/logs

chmod 750 /home/vagrant
chown vagrant:www-data /home/vagrant

echo "restart services .."
systemctl restart php5-fpm
systemctl restart php7.0-fpm
systemctl restart apache2
systemctl restart mysql

echo "various settings..."
# note: only in local vagrant box
usermod -a -G adm vagrant

