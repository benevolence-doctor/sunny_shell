#!/bin/sh
touch c.txt
for string1 in `cat $1`
do
for string2 in `cat $2`
do
  if [ "$string1" -eq "$string2" ]
  then
    echo $string1 >> c.txt
  fi
done
done
