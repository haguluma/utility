while true
do 
    date
    echo '--------'
    echo 0 > /sys/fs/cgroup/cpu,cpuacct/testcg/cpuacct.stat
    cat /sys/fs/cgroup/cpu,cpuacct/testcg/cpuacct.stat
    echo
    sleep 1 
done
