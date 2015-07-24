#!/bin/bash
for a in `cat $1'
do
N=`nmap sS -host_timeout 5000 $a`

if [[ $N =~ https ]];then
echo $a https/443

else
echo $a no

fi
done

