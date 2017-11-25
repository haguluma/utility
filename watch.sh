while true; do
    
    echo memory:$(cat /sys/fs/cgroup/memory/memory_ctl/tasks)
    echo cpu:$(cat /sys/fs/cgroup/cpu/cpu_ctl/tasks)
    echo ===========

    sleep 1
done
