# Requirements

* General requirements: see  [GettingStarted.md](GettingStarted.md) 
* vagrant plugins
    * vagrant-vbguest

# Available Templates

* see folder [BASEFOLDER/bin/vagrant](/bin/vagrant)
* oldstable
    * folder: [BASEFOLDER/bin/vagrant/oldstable](/bin/vagrant/oldstable)
    * currently not available
* stable
    * folder: [BASEFOLDER/bin/vagrant/stable](/bin/vagrant/stable)
    * Debian 8.x "jessie"
* testing
    * folder: [BASEFOLDER/bin/vagrant/testing](/bin/vagrant/testing)
    * Debian 9.x "stretch"

# Run Steps

* Install above requirements
* open a commandline programm on your OS
* change to directory: BASEFOLDER/bin/vagrant/TEMPLATE
* install plugin with following command: "vagrant plugin install vagrant-vbguest"
* start VM with command "vagrant up"
* more information (commands). see http://vagrantup.com

# Customization

* Currently there are examples for php (usage of mod_php or php-fpm).
* see also
    * BASEFOLDER/bin/vagrant/TEMPLATE/Vagrantfile (part "provision", custom_php.sh ist default)
    * BASEFOLDER/src/examples
