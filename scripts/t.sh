#!/bin/bash
while read d ;do
grep $d 3

if [ $? != 0 ];
  then 
     echo $d >> bunengjiexi.txt
fi
