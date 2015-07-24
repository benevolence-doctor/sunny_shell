#!/bin/bash
useradd nagios
groupadd nagcmd
usermod -G nagcmd nagios
mkdir -p server_init/pkgs && cd /root/server_init/pkgs/
killall nrpe
sleep 1
newmd5="b4adafc4190facbfed2bca3987a06499"
curmd5=`md5sum /root/server_init/pkgs/nagios-client-with-nrpe.tgz | awk '{print $1}'`
test $newmd5 == $curmd5 ||  (rm -rf /root/server_init/pkgs/nagios-client-with-nrpe.tgz ; 
wget -c http://122.72.0.178:8090/data/pub/source/nagios-client-with-nrpe.tgz)
rm -rf /usr/local/nagios/etc/nrpe.cfg && tar zxf nagios-client-with-nrpe.tgz -C /usr/local/
sh /usr/local/nagios/install.sh
/usr/local/nagios/bin/nrpe -c /usr/local/nagios/etc/nrpe.cfg -d
ps auxf | grep nrpe | grep -v grep
