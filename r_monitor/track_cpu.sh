while true; do
   echo 0 | sudo tee /sys/fs/cgroup/cpu,cpuacct/testcg/cpuacct.usage >/dev/null
   sleep 1
   echo "$(date): $(($(cat /sys/fs/cgroup/cpu,cpuacct/testcg/cpuacct.usage) / 1000000 ))" # ミリ秒に直す
 done 
