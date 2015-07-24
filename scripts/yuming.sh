#!/bin/bash
###域名是否可缓存判断脚本

shell_path=$(cd "$(dirname "$0")"; pwd)
time=`date +"%Y%m%d_%H%M"`
dm_history=${2}

for dm in `cat $1`
do
dm_name=`echo $dm|grep -E "akadns.net|akamai.net|akamaiedge.net|edgekey.net|edgesuite.net|ytcdn.net|ccgslb.net|ccgslb.com.cn|chinacache.net|cdn20.com|chinanetcenter.com|wscdns.com|lxdns.com|tl88.net|51cdn.com|dnion.com|fastcdn.com|globalcdn.cn|tlgslb.com|cachecn.com|cachecn.net|cloudcdn.cn|cloudcdn.net|fastweb.com|fastwebcdn.com|fwcdn.com.cn|fwcdn.net|fwdns.net|hacdn.com|hacdn.net|hadns.net|sz-dns.net"`
dm_name1=`echo $dm|grep -E "login|log|api|push|cloud|pass|port|weibo|weather|account|mail|www|:443|:8080"`

if [ -n "$dm_history" ] &&[ -f "$dm_history" ];then
   dm_name2=`cat ${dm_history}|awk '{print $1}'|grep ^${dm}$`
else
   dm_name2="hello"
fi
   

if [[ "$dm" =~ "ntp" ]];then
   echo "$dm 否 NTP时钟同步域名"
   continue
   elif
   [[ "$dm" =~ "https" ]];then
   echo "$dm 否 HTTS域名"
   continue
   elif
   [[ "$dm" =~ "in-addr.arpa" ]];then
   echo "$dm 否 域名反向解析"
   continue
   elif
   [[ -n "${dm_name}" || -n "${dm_name1}" ]];then
   echo "$dm 否 含有不可缓存内容"
   continue
   elif
   [[ "$dm" == "${dm_name2}" ]];then
   echo `awk '$1=="'"${dm}"'"' $dm_history`
   continue
   else
   :
fi

dm_dig=`dig @114.114.114.114 $dm +short|grep -E "ccgslb.net|chinacache.net|cdn20.com|lxdns.com|51cdn.com|dnion.com|fastcdn.com|tlgslb.com|cachecn.com|fastweb.com|fastwebcdn.com|fwcdn.com.cn|fwcdn.net"`
if [ -n "${dm_dig}" ];then
   echo "$dm 是"
else 
   echo "$dm 未知" 
fi
done
