conf_file=$1

echo $conf_file

/opt/spark-bench/bin/spark-bench.sh $conf_file

bash getlog.sh




