import re
import sys
import json
import commands

argvs = sys.argv
argc = len(argvs)

if (argc != 2):
    print('Usage: # python %s text' % argvs[0])
    quit()

f = open(argvs[1])                                                                                                                                                                                                               
line = f.readline()
                                                                                                                                                                                           
while line:
    p_id = line.replace('\n','').replace('\r','');
    command = "cat /proc/"+p_id+"/cmdline"
    print(p_id+": "+ commands.getoutput(command)  )
    line = f.readline()

#check = commands.getoutput("")
