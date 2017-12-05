while true; do
   echo 0 > /sys/fs/cgroup/cpu/cpu_ctl/cpuacct.usage
   sleep 1
   echo "$(date +%M.%S.%N | sed -e 's/\./ /g' | gawk '{print $1*60000000000+$2*1000000000+$3}'):$(cat /sys/fs/cgroup/cpu/cpu_ctl/cpuacct.usage)"
done

