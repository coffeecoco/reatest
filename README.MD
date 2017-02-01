Simple Sinatra + Unicorn + Nginx Deployment


All my testing was done using macos + vagrant + parallels

Supported/Supplied
Vagrantfile-aws           Vagrantfile-digitalocean  Vagrantfile-gce           Vagrantfile-linode        Vagrantfile-local         Vagrantfile-rackspace     Vagrantfile-softlayer     


To Install/Provison this:

vagrant plugin install vagrant-parallels
vagrant up --provider=parallels

Documentation
Firewall policy is set for allowall  env=development
Nginx will listen on Port 80, No Virtualhost, just *:80


Improvement
Create facter/libs for unicorn/nginx
use facters to enable monitoring splunk/nrpe/nagios/newrelic/etc/etc
Proccess management for unicorn such as supervisord, or service scripts
Enable HA clustering
Enable iptables/OS hardening
Enhanced roles/profiles for user account management depending on ENV_ID
Hello world to be imported into highly secure environment, so enable SAML/etc authentication ( shiboleth )
Hello world intergrations with Banks so it requires MutualAuth tlsonly authentication, via secure truststores
Hello world is a high performing server, so needs socket/tread/filedescriptor tunning



