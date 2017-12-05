/home/general/utility/r_monitor/track_resource.sh &#> /dev/null &
ssh0=$!
ssh worker00 /home/general/utility/r_monitor/track_resource.sh &#> /dev/null &
ssh1=$!
ssh worker01 /home/general/utility/r_monitor/track_resource.sh &#> /dev/null &
ssh2=$!

./sp_bench/spbench.sh ./sp_bench/test_kmeans.conf

kill $ssh0
kill $ssh1
kill $ssh2


#pid009=$(echo $(ssh worker00 ps aux | grep bash | grep /home/general/utility/r_monitor/track_resource.sh) | gawk '{print $2}')
#command=$(echo "kill $pid009")
ssh worker00 'killall bash'

#pid010=$(echo $(ssh worker00 ps aux | grep bash | grep /home/general/utility/r_monitor/track_resource.sh) | gawk '{print $2}')
#command=$(echo "kill $pid010")
ssh worker01 'killall bash'

killall bash


