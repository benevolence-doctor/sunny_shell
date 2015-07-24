#!/bin/bash

for dm in `cat $1`
do

ip=`dig @211.137.130.3 $dm +short |sed -ne "/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/p" |awk 'NR==1'`
ip138=`./ip138.sh -i $ip`
echo $dm $ip138
done
