#!/bin/sh
squidcache_path="/usr/local/squid/var/cache/"
squidclient_path="/usr/local/squid/bin/squidclient"
ip=`netstat -tlnp|grep ":80"|awk '{print $4}'|awk -F: '{print $1}'`
grep -a -r $1 $squidcache_path/* | strings | grep "http:" | awk -F'http:' '{print "http:"$2;}' > cache_list.txt
for url in `cat cache_list.txt`; do
$squidclient_path -h $ip -p 80 -m  PURGE $url
done
