#!/bin/bash

log_dir="/var/log/nginx/"
date_dir=`date +%Y-%m-%d`

/bin/mkdir -p ${log_dir}${date_dir} > /dev/null 2>&1
for i in `ls -F ${log_dir}|grep -v /
do
/bin/mv ${log_dir}$i ${log_dir}${date_dir}/$i
done
kill -USR1 `cat /var/run/nginx/nginx.pid`
