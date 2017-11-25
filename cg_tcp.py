import commands
import time
while True:
    time.sleep(1)
    f = open("/sys/fs/cgroup/memory/memory_ctl/tasks",'r')
    line = f.readline()
    while line:
        command = "echo "+line.replace('\n','').replace('\r','')+" > /sys/fs/cgroup/cpu/cpu_ctl/tasks"
        commands.getoutput(command) 
        line = f.readline()
    f.close
