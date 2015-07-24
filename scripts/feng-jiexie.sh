#!/bin/bash
while read ip;do
name=$(dig @"$1" "$ip" +short |egrep -v '[a-z]') 
for i in  $name;do
echo  "$ip $i" >> "$1".txt
done
done<guonei-apk
