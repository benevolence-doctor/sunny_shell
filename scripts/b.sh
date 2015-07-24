#!/bin/bash

for D in `cat $1`
do
tmp=`nmap -sS --host_timeout 5000 $D|grep tcp`
if [[ $tmp =~ "443/tcp" ]];then

echo $D 443/tcp

else

echo $D Noknow

fi
done
#cat $1|awk '{print $1,$2}' |while read dm ip
#do
#tmp=`nmap $ip|grep tcp|grep -v closed|awk -F/ '{print $1}'`
#echo $dm $tmp
#done
