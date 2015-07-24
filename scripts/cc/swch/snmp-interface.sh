#!/bin/bash

for ip in `cat $1`
do
##get interface
intger=`snmpwalk -v 2c -c public $ip 1.3.6.1.2.1.4.20.1.2|grep -Po "\d+.*"|egrep -v '^10|^192|^127'|awk '{print $4}'`
##get ip and interface
interface=`snmpwalk -v 2c -c public $ip   1.3.6.1.2.1.31.1.1.1.1|grep -Po "\d+.*"|awk '$1=="'"${intger}"'"  {print $4}'`
echo $ip $interface
done
