#!/bin/bash
TIME=$(date -d "1 days ago" +%Y-%m-%d)
#TIME="2014-07-31"
for dir in `cat /opt/dir.txt`
   do
      /bin/mkdir "$dir"/"$TIME"/test
      /bin/tar -zxvf "$dir"/"$TIME"/*"$TIME".tar.gz -C "$dir"/"$TIME"/test
      /bin/ls "$dir"/"$TIME"/test >/opt/file.log

           for num2 in `cat /opt/file.log`
           do
             python /opt/t.py "$dir"/"$TIME"/test/$num2
             /bin/awk -F/ '{print $4}' "$dir"/"$TIME"/test/$num2 >> /opt/check_2.txt
           done

       /bin/cat /opt/check_2.txt |sort |uniq -c|sort -nr |head -n 40 >> /opt/log/"$TIME".log
       /bin/rm -rf "$dir"/"$TIME"/test
       /bin/rm -f  /opt/check_2.txt
   done
wc -l /opt/iphone.txt  >> /opt/ua-"$TIME".txt ;wc -l /opt/ipad.txt >> /opt/ua-"$TIME".txt;wc -l /opt/other.txt >> /opt/ua-"$TIME".txt;wc -l /opt/android.txt >> /opt/ua-"$TIME".txt
echo -n "ipad: " >> /opt/ua-"$TIME".txt;awk '{sum+=$NF}END{print sum/1024/1024}' /opt/ipad.txt >> /opt/ua-"$TIME".txt
echo -n "iphone: " >> /opt/ua-"$TIME".txt ;awk '{sum+=$NF}END{print sum/1024/1024}' /opt/iphone.txt >> /opt/ua-"$TIME".txt
echo -n "pc: " >> /opt/ua-"$TIME".txt;awk '{sum+=$NF}END{print sum}' /opt/other.txt >> /opt/ua-"$TIME".txt
echo -n "android: " >> /opt/ua-"$TIME".txt; awk '{sum+=$NF}END{print sum/1024/1024}' /opt/android.txt >> /opt/ua-"$TIME".txt
rm -f /opt/android.txt /opt/ipad.txt /opt/iphone.txt /opt/other.txt /opt/android.txt
