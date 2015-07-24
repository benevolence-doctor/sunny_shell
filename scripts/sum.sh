#!/bin/bash
for i in `cat /root/list`
do
sum=`zcat /data/proclog/log/backup/access/2014-09-18/xCache-S-A-SC-CM-WEBCACHE-01-2014-09-18.tar.gz|grep -a $i|awk  '{sum+=$4} END  {print  sum/1024/1024}'`
echo -e "$i $sum" >>a.log
done
