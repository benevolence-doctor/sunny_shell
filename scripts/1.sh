#!/bin/bash
while read domain;do
dig @"$domain" www.baidu.com +short
if [ $? = 0 ];then
echo "$domain" >>dns.log
fi
done <1
