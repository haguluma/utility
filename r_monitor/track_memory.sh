while true; do
   echo 0 > /sys/fs/cgroup/memory/memory_ctl/memory.max_usage_in_bytes
   sleep 1
   echo "$(date +%M.%S.%N | sed -e 's/\./ /g' | gawk '{print $1*60000000000+$2*1000000000+$3}'):$(cat /sys/fs/cgroup/memory/memory_ctl/memory.usage_in_bytes)"
done

