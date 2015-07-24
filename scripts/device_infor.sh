#!/bin/bash
#This is a get system info scripts
ip=`ifconfig |grep -v "127.0.0.1" |grep "inet addr:" |awk '{print $2,$4}' `
gw=`netstat -r |grep default |awk '{print $1,$2}'`
cpu_name=`grep "model name" /proc/cpuinfo |sed -n "1p" |awk -F[":"] '{print $2}'`
cpu_num=`grep "model name" /proc/cpuinfo |wc -l`
mem_num=`free -g |sed -n "2p" |awk '{print $2}'`
n_disk=`fdisk -l |grep GB |awk '{print $3}' |uniq -c |awk '{print$1,"x",$2,"GB"}'`
disk=$n_disk
echo $ip
echo $gw
echo $cpu_name"*"$cpu_num"/"$mem_num"GB""/"$disk
echo "_________________________________________________________________________________________________"
