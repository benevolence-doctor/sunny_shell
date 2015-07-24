#!/bin/bash
echo '
#history   
export HISTTIMEFORMAT="%F %T `whoami` "
USER_IP=`who -u am i |cut -d "(" -f 2|tr ")" " " `
HISTDIR=/usr/local/bin/.history
if [ -z $USER_IP ]
then
USER_IP=`hostname`
fi
if [ ! -d $HISTDIR ] 
then 
mkdir -p $HISTDIR
chmod 777 $HISTDIR
fi
if [ ! -d $HISTDIR/${LOGNAME} ]
then
mkdir -p $HISTDIR/${LOGNAME}
chmod 300 $HISTDIR/${LOGNAME}
fi   
export HISTSIZE=4000
DT=`date +%Y%m%d_%H%M%S`
export HISTFILE="$HISTDIR/${LOGNAME}/${USER_IP}.history.$DT"
chmod 600 $HISTDIR/${LOGNAME}/*.history* 2>/dev/null '   >>48

