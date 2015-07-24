#!/bin/bash
for ip in `cat $1`
do
sn=`snmpwalk -v 2c -c  public $ip 1.3.6.1.2.1.47.1.1.1.1.11|awk '$3~/STRING/ {print $4}'|tr -s '"' ' '`
echo $ip $sn >>snmpsn.log
done
