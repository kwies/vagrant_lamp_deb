# Getting started with 'vagrant'

## What is 'vagrant'

* cite from http://vagrantup.com: "Development environments made easy. Create and configure lightweight, reproducible, and portable development environments."
* 'vagrant' can be used for _local_ development without providing a server infrastructure (but: local ressources are needed).
* With 'vagrant' you can achieve 'infrastructure as code' (for development purposes): The 'Vagrantfile' (config file for the virtual machine) and the provisioning scripts (scripts to set up the virtual machine) can be stored in source code management systems (git, svn, ...).
* further information: https://www.vagrantup.com/docs/

## Requirements

* [virtualbox] (http://virtualbox.org)
* [vagrant] (http://vagrantup.com)
* under Windows: [git-scm] (http://git-scm.com/), with the git-bash the vagrant function 'vagrant ssh' can be used without problems

Currently tested with

* Linux (Debian 8)
* Windows 7/8
* Mac OS X
* virtualbox 5.1.22
* vagrant 1.9.5

## First steps

Note: This is just one example to become familiar with vagrant.

* Create a temp folder
* Open a terminal, switch to the created folder and type:
```
vagrant init ubuntu/xenial64
vagrant up
```
* Now the base box for Ubuntu 16.04 "Xenial" (64bit) will be downloaded. The second command 'vagrant up' will start and setup (synced folder etc) the virtual machine and run provisioning scripts if available. Provisonising scripts are e.g. shell scripts or special scripts like [puppet] (https://puppetlabs.com/) or [chef] (https://www.chef.io). This may take some time. In the example above no provisonising scripts are executed.
* Use following command to connect to the virtual machine via SSH. You will be normally logged in as user 'vagrant' and can run root commands with 'sudo'.
```
vagrant ssh
```
* Use the command 'exit' to get back to the host.
* Use following command to shutdown the virtual machine:
```
vagrant halt
```

## Next steps and further information

* read the docs: https://www.vagrantup.com/docs/
* The provisioning scripts run only once (the first time when 'vagrant up' is called). With the command 'vagrant provision' you can execute the provisioning scripts again.
* Use the following command to run ssh commands directly from the host
```
vagrant ssh -c "/path/in/vagrantbox/to/shellscript.sh"
```
* With vagrant builtin feature 'vagrant share' it is possible to give other people access to your local virtual machine. More information: https://www.vagrantup.com/docs/share/.
