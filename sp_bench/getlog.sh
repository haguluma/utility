exelog=$(hdfs dfs -ls -t /var/log/spark | head -n 2 | gawk '{print $8}')
filename=$(basename $exelog)

hdfs dfs -get $exelog ~/utility/EXElogs
cp -r /opt/spark/work/$filename ~/utility/GClogs

echo $filename
