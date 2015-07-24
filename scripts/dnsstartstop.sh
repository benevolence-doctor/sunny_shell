#!/bin/bash

prog="dnsReflector"
RETVAL=0

start() {
        echo -n $"Starting $prog: "      
        nohup ./$prog -i eth1 -o eth0 >/dev/null 2>&1 &
        nohup ./$prog -i eth2 -o eth0 >/dev/null 2>&1 &
        RETVAL=$?
        echo
        return $RETVAL
}

stop() {
       echo "dnsReflector is stop ........................."
       killall $prog
       RETVAL=$?
       echo
       return $RETVAL
}
status() {
       pid=`ps aux |grep dnsReflector|grep -v grep|awk '{print $2}'`

       if [ -n "$pid" ];then
          echo $"${prog} (pid "$pid") is running..."
       else
          echo $"${prog} is stop..."
       fi
}
       
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  status)
        status
        ;;
  *)
        echo $"Usage: $0 {start|stop|status}"
        RETVAL=1
esac

exit $RETVAL
