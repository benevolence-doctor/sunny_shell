#!/bin/bash
TIME=$(date -d "1 days ago" +%Y-%m-%d)
#TIME="2014-07-31"
#
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.1::data/"$TIME" /data/cache1/w1
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.2::data/"$TIME" /data/cache1/w2
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.3::data/"$TIME" /data/cache2/w3
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.4::data/"$TIME" /data/cache2/w4
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.5::data/"$TIME" /data/cache3/w5
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.6::data/"$TIME" /data/cache3/w6
#
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.22::data/"$TIME" /data/cache4/w7
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.23::data/"$TIME" /data/cache4/w8
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.9::data/"$TIME" /data/cache5/w9
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.10::data/"$TIME" /data/cache5/w10
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.13::data/"$TIME" /data/cache7/w13
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.14::data/"$TIME" /data/cache7/w14
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.15::data/"$TIME" /data/cache8/w15
rsync -azP --password-file=/etc/rsyncd.pass --port=8733 loger@192.168.110.16::data/"$TIME" /data/cache8/w16

df -h |awk '/data/ {print $5}' |awk '{gsub(/\%/,"");print}'|grep 90 > /opt/df.log
if [[ ! -z /opt/df.log ]]
 then
df -h |grep "90%" |awk '{print $6}' > /opt/list.log
 while read dir
    do
    for n in `ls $dir`
      do
       for m  in `ls $dir/$n |head -n 5`
         do 
             rm -rf $dir/$n/$m 
         done
      done
   done</opt/list.log    
fi
