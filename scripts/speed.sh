#!/bin/bash
for i in  `cat $1`;do
 a=`curl -w "%{http_code} %{size_download} %{speed_download}" -so /dev/null -x 183.221.252.138:80 $i  |awk '{print $1,$2/1000/1000"MB",$3/1000/1000"MB/s"}'`
  echo $i $a
done
#cat $1 |while read dm url
#do
#echo $dm `curl -w "%{http_code} %{size_download} %{speed_download}" -so /dev/null $url |awk '{print $1,$2/1000/1000"MB",$3/1000/1000"MB/s"}'`
#done
