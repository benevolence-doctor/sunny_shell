#!/bin/bash

for D in `cat $1`
do
tmp=`nmap -sS --host_timeout 5000ms $D|grep -v closed |grep tcp|awk -F/ '{print $1}'`
#if [[ $tmp =~ "open  https" ]];then

#echo $D https/443/tcp

#else

#echo $D Noknow

#fi
echo $D $tmp
done
