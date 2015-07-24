#!/bin/bash
############################
#2013-12-26 by fengchuanfei#
############################
LOG="-o /dev/null"
TIMEOUT=30
HTTP_JD=http://www.jd.com/
HTTP_BAIDU=http://www.baidu.com/
HTTP_QQ=http://www.qq.com/
wget -t 1 --timeout=$TIMEOUT --proxy --execute=http_proxy=192.168.1.101:80 -O  /tmp/jd.html $HTTP_JD  $LOG
wget -t 1 --timeout=$TIMEOUT --proxy --execute=http_proxy=192.168.1.101:80 -O  /tmp/baidu.html $HTTP_BAIDU  $LOG
wget -t 1 --timeout=$TIMEOUT --proxy --execute=http_proxy=192.168.1.101:80 -O  /tmp/qq.html $HTTP_QQ  $LOG
if [ ! -s /tmp/jd.html -a ! -s /tmp/baidu.html -a ! -s /tmp/qq.html ]
   then
       if [ ! -e /root/fengchuanfei/mysql-out.sql ]
          then
            /usr/bin/mysqldump -h127.0.0.1 -uroot -pchinatt_1347 powerdns > /root/fengchuanfei/mysql-out.sql
            /usr/bin/mysql  -uroot -pchinatt_1347 -e "use powerdns;delete from records;"
       fi
   else
      if [ -e /root/fengchuanfei/mysql-out.sql ]
         then
           /usr/bin/mysql -h127.0.0.1 -uroot -pchinatt_1347 powerdns < /root/fengchuanfei/mysql-out.sql
           /bin/rm -f /root/fengchuanfei/mysql-out.sql
      fi
fi
