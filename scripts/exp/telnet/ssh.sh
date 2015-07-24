#!/bin/bash  
for i in `awk '{print $1}' passwd.txt`  
do  
#j=`awk -v I="$i" '{if(I==$1)print $2}' passwd.txt`  
#k=`awk -v I="$i" '{if(I==$1)print $3}' passwd.txt`  
expect telnet.exp $i 
done  
