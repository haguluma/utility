app_log=$(ls -1t /opt/spark/work/ | head -n 1)
#log_list=$(find /opt/spark/work/$app_log -name 'stdout')

cp -r /opt/spark/work/$app_log ~/utility/GClogs

#for logfile in list; do
#    cp $logfile ~/utility/logfile
#done
