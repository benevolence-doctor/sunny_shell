#!/bin/bash
#Purpose
ipp (){
exec < $1
while read a
do
sring=`curl -s http://icp.aizhan.com/${a}|grep box_17|awk -F '</td>' '{print $8}'|awk -F '<td>' '{print $2}'`
echo $a $sring
done
}
case $1 in
-f)
shift
ipp $1
;;
-i)
shift
sring=`curl -s http://icp.aizhan.com/${1}|grep box_17|awk -F '</td>' '{print $8}'|awk -F '<td>' '{print $2}'`
echo $1 $sring
;;
*)
echo "[Help]
$0 need -f or -i
-f ------- argument is a file
-i ------- argument is a IP
[For example]:
$0 -f filename
$0 -i ipadress
"
;;
esac

