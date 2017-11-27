/home/general/utility/r_monitor/track_resource.sh &> track_r.log &
ssh worker00 trap '/home/general/utility/r_monitor/track_resource.sh &> track_r.log &' 15

sleep 10

ssh worker00 killall bash
killall bash




#./log.sh
#ssh worker00 utility/log.sh
#ssh worker01 utility/log.sh
