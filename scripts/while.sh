#!/bin/bash
read -p 'printing number 1 through 20 (but not 3 and 11):' number
while [ $number -gt 19 ] 
do
  let '$number += 1'  
 if [ $number -eq 3 ] || [ $number -eq 11 ] ;then
    break
 fi
 echo $number
done
