#!/bin/bash
chattr -sia /usr/sbin/ttyload
chattr -sia /sbin/tty*
chattr -sia /usr/include/proc.h
chattr -sia /usr/include/file.h
chattr -sia /usr/include/hosts.h
chattr -sia /usr/include/log.h
chattr -sia /lib/libsh.so/

chattr -sia /usr/bin/dir
chattr -sia /usr/bin/find
chattr -sia /sbin/ifconfig
chattr -sia /bin/ls
chattr -sia /usr/sbin/lsof
chattr -sia /usr/bin/md5sum
chattr -sia /bin/netstat
chattr -sia /bin/ps
chattr -sia /usr/bin/pstree
chattr -sia /usr/bin/top
rm -rf /usr/sbin/ttyload  /sbin/tty*  /usr/include/proc.h  /usr/include/file.h /usr/include/hosts.h  /usr/include/log.h /lib/libsh.so
\cp -rf /usr/lib/libsh/.backup/lsof /usr/sbin/lsof
\cp -rf /usr/lib/libsh/.backup/ls /bin/ls
\cp -rf /usr/lib/libsh/.backup/top /usr/bin/top
\cp -rf /usr/lib/libsh/.backup/dir /usr/bin/dir
\cp -rf /usr/lib/libsh/.backup/find /usr/bin/find
\cp -rf /usr/lib/libsh/.backup/ps /bin/ps
\cp -rf /usr/lib/libsh/.backup/pstree /usr/bin/pstree
\cp -rf /usr/lib/libsh/.backup/netstat /bin/netstat
\cp -rf /usr/lib/libsh/.backup/ifconfig /sbin/ifconfig
\cp -rf /usr/lib/libsh/.backup/md5sum /usr/bin/md5sum
killall -9 Microsoft sshi  ttymon
kill -9 `ps aux|awk '/ttyload/{if ($0!~/grep/) print $2}'`
sed -i '/0\:2345\:once\:\/usr\/sbin\/ttyload/d' /etc/inittab
