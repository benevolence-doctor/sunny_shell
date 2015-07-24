#!/bin/bash
var1=$1
var2=$2
####################################3
file(){
n=$1
m=$2
arr=($(awk '{print $1}' $m))
var=0
while true
do
if [ -f "$n" ]
then
	if [[ $var -lt ${#arr[@]} ]]
	then
		for i in `cat $n`
		do
			echo -e "${arr["$var"]}\t$i" >> $var.tmp 
		done
	else
		break
	fi
	let var+=1
else
           count=$(cat $m|wc -l)
           if [[ $var -lt $count ]]
           then
               echo -e "${arr["$var"]}\t$n" >> $var.tmp
           else
               break 
           fi
           let var+=1
fi
done
cat *.tmp >> domain.txt
rm -f *.tmp
}
use(){
echo -e "DOMAIN\t\t\tTIME\t\t\tIP"
echo "##################################################"
####check domain.txt####################################
if [ -e domain.txt ]
     then
         rm -f domain.txt
fi
########################################################
file $var1 $var2
while read dns domain;do
##########TIME##############
time=$(dig @"$dns" "$domain" +nocmd +noadditional +noauthority +noquestion +nocomments|sed -n '/global/,/Query/p'|sed -e '/global/d' -e '/Query/d' |awk 'END{print $2}')
##########DOMAIN##############
name=$(dig @"$dns" "$domain" +short )
##########LOOP##############
for ip in $name;do
echo -e ""$dns"\t$domain\t$time\t$ip"
done
done<domain.txt
rm -f domain.txt
}
#dig www.sohu.com  +nocmd +noadditional +noauthority +noquestion +nocomments|sed -n '/global/,/Query/p'|sed -e '/global/d' -e '/Query/d' |awk 'END{print $2}'
#case $1 in 
#file $var1 $var2
if [ -z "$1" ] || [ $1 == "help" -o $1 = "--help" ]
then
    echo -e "\033[32;1m########################WARNING####################\033[0m"
    echo -e "\033[32;1mPlease ues --dig parameter.\033[0m"
    echo -e "\033[32;1mPlease give it to two files.one domain.log and one dns.log.NOTE:please put it in the current directory.\033[0m"
    echo -e "\033[32;1m##########################END######################\033[0m"
else 
    use
fi
