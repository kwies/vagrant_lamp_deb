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

#TODO: customize it

echo "init and configure app .."

# create dirs
rm -rf /home/vagrant/public_html

# copy app into vm
cp -R /vagrant_data/examples/php/ /home/vagrant/public_html
chown -R vagrant:vagrant /home/vagrant/public_html

# copy vhost into vm
cp /vagrant_config/files/apache/phpapp.conf  /etc/apache2/sites-available/appvhost.conf
a2ensite appvhost.conf

# disable default site
a2dissite 000-default

echo "create database .."
mysql -u root -p"vagrant" -e ";CREATE DATABASE dev_local; GRANT ALL ON dev_local.* TO dev_local@localhost IDENTIFIED BY 'dev_local';FLUSH PRIVILEGES;"


echo "restart services .."
systemctl restart mysql
systemctl restart php5-fpm
systemctl restart php7.0-fpm
systemctl restart apache2
