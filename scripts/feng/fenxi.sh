#!/bin/bash
while read d;do
    num=$(echo $d |egrep -o 'log|google|baidu|qq.com|^www|chinamobile|root|push|itunes|api|qzone'|head -n 1)
    if [[ $num == "baidu" ]] || [[ $num == "google" ]] || [[ $num == "qq.com" ]] || [[ $num == "push" ]] || [[ $num == "www" ]] || [[ $num == "chinamobile" ]] || [[ $num == "root" ]] || [[ $num == "push" ]] || [[ $num == "itunes" ]]|| [[ $num == "api" ]] || [[ $num == "qzone" ]]
     then
      echo "$d,域名含有不可缓存内容" >>e.txt 
    elif [[ $num == "ntp" ]];then
      echo "$d,时钟同步服务器" >>e.txt
    elif [[ $num == "clock" ]];then
      echo "$d,时钟同步服务器" >>e.txt
    elif  [[ $num == "dns" ]];then
      echo "$d,DNS服务器" >>e.txt
    elif  [[ $num == "login" ]];then
      echo "$d,HTTPS加密类域名" >>e.txt
     else 
      echo "$d"  >>e.txt
    fi
done <zj.txt
