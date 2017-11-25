: > ./resource_log/memory_log
while true; do
   echo 0 | sudo tee /sys/fs/cgroup/memory/test_control/memory.max_usage_in_bytes >/dev/null
   sleep 1
#   echo $(cat /sys/fs/cgroup/memory/test_control/memory.max_usage_in_bytes)
   echo "$(date +%M.%S.%N | sed -e 's/\./ /g' | gawk '{print $1*60000000000+$2*1000000000+$3}'):$(cat /sys/fs/cgroup/memory/test_control/memory.max_usage_in_bytes)" >> ./resource_log/memory_log >&2
# : $(cat /sys/fs/cgroup/memory/test_control/memory.max_usage_in_bytes)  ←　そのうち見直さないと
done 
