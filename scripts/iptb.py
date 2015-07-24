#!/usr/bin/python
#coding=utf-8
import sys
import commands
import simplejson
reload(sys)
sys.setdefaultencoding( "utf-8" )
cmd='curl -s http://ip.taobao.com/service/getIpInfo.php?ip='+sys.argv[1]
temp=commands.getstatusoutput(cmd)
all=simplejson.loads(temp[1])
ipinfo=all['data']
print ipinfo.get('ip'),ipinfo.get('country'),ipinfo.get('region'),ipinfo.get('city'),ipinfo.get('isp')
