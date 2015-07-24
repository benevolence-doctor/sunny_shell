#!/bin/bash
echo "squid configuration start. . ."
#mod&&user&&group
cache="/memcache"
ip=$(ifconfig eth0 |egrep -o "inet addr:[^ ]*"|awk -F: '{print $2}')
chmod -R 755 /data/*
chown -R squid.squid /data/*
#chmod -R 755 /memcache/
#chown -R squid.squid /memcache/
if [ -e $cache ];then
echo "the dir exist&&continue...."
else
echo "not exist...."
mkdir $cache
fi
#link-set up
ln -s /usr/local/squid/etc/squid.conf /etc/squid.conf
#hostname-set up
name=$(hostname)
echo $name
sed -i '/visible_hostname/ s/^/#/' /usr/local/squid/etc/squid.conf
sed -i '/visible_hostname/ s/$/\nvisible_hostname\t'$name'/' /usr/local/squid/etc/squid.conf
sed -i '/115.181.128.6/ s/115.181.128.6/'$ip'/' /usr/local/squid/etc/squid.conf
#add-key
read -p "please input your key:" KEY
echo "the key is $KEY"
echo "key  $KEY" >>/usr/local/squid/etc/squid.conf
#end
#DNSMASQ-START
sed -i '/conf-dir/ s/^/#/' /etc/dnsmasq.conf
echo "resolv-file=/etc/resolv.dnsmasq.conf" >>/etc/dnsmasq.conf
echo "addn-hosts=/etc/dnsmasq.hosts" >>/etc/dnsmasq.conf
sed -i '/cache-size/ s/#/ /' /etc/dnsmasq.conf
sed -i '/cache-size/ s/150/10000/' /etc/dnsmasq.conf
################################################################
#file-mkdir
touch /etc/resolv.dnsmasq.conf
touch /etc/dnsmasq.hosts
echo "nameserver 127.0.0.1" > /etc/resolv.conf
#############################start##############################
/etc/init.d/dnsmasq start
/sbin/chkconfig dnsmasq on
/sbin/chkconfig xCache on
/sbin/chkconfig --add xCache 
/sbin/chkconfig --add dnsmasq
echo "/sbin/chkconfig dnsmasq on" >> /etc/rc.local
echo "/sbin/chkconfig xCache on" >> /etc/rc.local
echo "mount -a" >> /etc/rc.local
#change-bytes
echo "store_avg_object_size 50MB" >>/usr/local/squid/etc/squid.conf
