#!/bin/bash
dir="/var/log/bind"
TIME=$(date +%Y%m%d)
#rename
mv $dir/query.log $dir/"$TIME"-query.log
#restart named
/usr/bin/killall named;/usr/bin/killall named
#
/sbin/named -c /etc/named.conf
