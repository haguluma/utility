mkdir -p Cglog/memory/$HOSTNAME
touch Cglog/memory/$HOSTNAME/memory_log
mkdir -p Cglog/cpu/$HOSTNAME
touch Cglog/cpu/$HOSTNAME/cpu_log
sudo chmod 777 -R Cglog/memory/$HOSTNAME/memory_log
sudo chmod 777 -R Cglog/cpu/$HOSTNAME/cpu_log
