: > /home/general/utility/Cglog/memory/$HOSTNAME/memory_log
: > /home/general/utility/Cglog/cpu/$HOSTNAME/cpu_log

while true; do
   echo 0 > /sys/fs/cgroup/memory/memory_ctl/memory.max_usage_in_bytes 
   echo 0 > /sys/fs/cgroup/cpu/cpu_ctl/cpuacct.usage
   sleep 1
   echo "$(date +%M.%S.%N | sed -e 's/\./ /g' | gawk '{print $1*60000000000+$2*1000000000+$3}'):$(cat /sys/fs/cgroup/memory/memory_ctl/memory.usage_in_bytes)" | tee -a /home/general/utility/Cglog/memory/$HOSTNAME/memory_log #> /dev/null
   echo "$(date +%M.%S.%N | sed -e 's/\./ /g' | gawk '{print $1*60000000000+$2*1000000000+$3}'):$(cat /sys/fs/cgroup/cpu/cpu_ctl/cpuacct.usage)" | tee -a /home/general/utility/Cglog/cpu/$HOSTNAME/cpu_log #> /dev/null
#   echo "----------------"
done 



