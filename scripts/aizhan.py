#!/usr/bin/python
# coding: utf-8
import re
import sys
import os
 
list_file = sys.argv[1]

def Get_Com_Name():
    fd = open(list_file, 'r')
        for line in fd.readlines():
            line = ''.join(line.split())
        cmd = 'curl -s http://icp.aizhan.com/%s  > /dev/shm/site' % line 
        os.system(cmd)

        fd1 = open('/dev/shm/site')
        string = fd1.read()    
        if re.search(r'主办单位名称</td><td>', string):
            words = re.search(r'主办单位名称</td><td>\W+<', string)
            cmd = line + '\t\t\t\t\t\t\t' +  words.group()[27:][:-1]
        print cmd
        else:
            cmd = line + '\t\t\t\t\t\t\t' + 'unknown' 
           print cmd
        pass 
            fd1.close()
        fd.close()

print(Get_Com_Name())
