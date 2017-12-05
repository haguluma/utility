: > /home/general/utility/Cglog/$HOSTNAME/memory_log
: > /home/general/utility/Cglog/$HOSTNAME/cpu_log

while true; do
   echo 0 > /sys/fs/cgroup/memory/memory_ctl/memory.max_usage_in_bytes 
   echo 0 > /sys/fs/cgroup/cpu/cpu_ctl/cpuacct.usage
   sleep 1
   echo "$(date +%s%N | cut -c 1-13):$(cat /sys/fs/cgroup/memory/memory_ctl/memory.usage_in_bytes)" | tee -a /home/general/utility/Cglog/$HOSTNAME/memory_log
   echo "$(date +%s%N | cut -c 1-13):$(cat /sys/fs/cgroup/cpu/cpu_ctl/cpuacct.usage)" | tee -a /home/general/utility/Cglog/$HOSTNAME/cpu_log
done 



