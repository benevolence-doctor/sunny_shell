#!/bin/bash
for ip in `cat $1`
do
counts=`snmpwalk -v 2c -c public $ip  1.3.6.1.2.1.2.2.1.8|sed -n '5,52p'|awk '$4~/2/  {print $0}'|wc -l`
echo $ip $counts >>sw.log
  if [ $counts = 0 ];then
     echo $ip is faild >>faild.log
  fi
done
