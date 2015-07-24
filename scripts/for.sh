#!/bin/bash
for name in $(awk -F: '{print $1}' /etc/passwd)
#for name in `awk -F: '{print $1}' /etc/passwd`
do
   echo "USER #$n = $name"
   let 'n += 1'
done
