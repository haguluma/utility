/home/general/utility/r_monitor/track_resource.sh &> ~/utility/cglog.log &
pid008=$!
ssh worker00 '/home/general/utility/r_monitor/track_resource.sh &> ~/utility/cglog.log' &
ssh worker01 '/home/general/utility/r_monitor/track_resource.sh &> ~/utility/cglog.log' &

./sp_bench/spbench.sh ./sp_bench/test_kmeans.conf
sleep 5

kill $pid008

pid009=$(echo $(ssh worker00 ps aux | grep bash | grep /home/general/utility/r_monitor/track_resource.sh) | gawk '{print $2}')
ssh worker00 kill $pid009

pid010=$(echo $(ssh worker00 ps aux | grep bash | grep /home/general/utility/r_monitor/track_resource.sh) | gawk '{print $2}')
ssh worker01 kill $pid010



