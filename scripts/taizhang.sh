#!/bin/bash
name=`dmidecode -t system|grep "Product Name"|awk '{print $4}'`
ip=`ip r|grep 'scope link  src'|awk '{print $NF}'`
gateway=`ip r|grep 'default'|awk '{print $3}'`
mask=`ip r|grep 'scope link  src'|awk '{print $1}'`
host=`hostname`
cpu=`cat /proc/cpuinfo |grep 'model name'|uniq|awk -F: '{print $2}'|awk '{print $1" "$2" "$3" "$4$5$6}'`
omem=`free -g|grep Mem|awk '{print $2}'`
mem=`expr $omem + 1`
odisk=`fdisk -l|grep GB|awk '{print $3}'|uniq -c|awk '{print $1"*"$2}'`
disk=`echo $odisk`
cpu1=`cat /proc/cpuinfo |grep "physical id"|sort |uniq|wc -l`
cpu2=`cat /proc/cpuinfo |grep "processor"|wc -l`
cpu3=`cat /proc/cpuinfo |grep "cores"|uniq`

#echo -e "$ip\t$mask\t$gateway\t$host\t$cpu/$mem/$disk"
echo -e "$ip\t$host\t$cpu\t$cpu1\t$cpu2\t$cpu3\t/$mem/$disk"
