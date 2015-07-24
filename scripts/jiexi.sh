#!/bin/bash
for a in `cat $1`; 
 do
ip=`dig @183.221.253.100 $a +short|egrep -v '[a-z]'`
for b in $ip
do 

   #echo  $a  `sh ip138.sh -i $b`
   echo  $a `python iptb.py $b`
done
done
