#!/bin/bash
j=0
for ((i=1;i<=100;i++))
do
  j=$((i+j))
done
 echo $j
