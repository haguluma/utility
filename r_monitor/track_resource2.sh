cgroup=$1
p_id=$2
exe_no=$3

cg_temp=(`echo $cgroup | tr -s '/' ' '`)
subgroup=${cg_temp[0]}

: > $PWD/Cglog/$HOSTNAME/$exe_no/memory_log
: > $PWD/Cglog/$HOSTNAME/$exe_no/cpu_log
while true; do
    
    if [ $subgroup = memory ]; then
# 	echo /sys/fs/cgroup/$cgroup/$p_id/memory.usage_in_bytes
#       echo 0 > /sys/fs/cgroup/$cgroup/$p_id/memory.usage_in_bytes
        sleep 1
        echo "$(date +%s%N | cut -c 1-13):$(cat /sys/fs/cgroup/$cgroup/$p_id/memory.usage_in_bytes)" | tee -a $PWD/Cglog/$HOSTNAME/$exe_no/memory_log
    elif [ $subgroup = cpu  ]; then
        echo 0 > /sys/fs/cgroup/$cgroup/$p_id/cpuacct.usage
        sleep 1
        echo "$(date +%s%N | cut -c 1-13):$(cat /sys/fs/cgroup/$cgroup/$p_id/cpuacct.usage)" | tee -a $PWD/Cglog/$HOSTNAME/$exe_no/cpu_log
    fi
done
