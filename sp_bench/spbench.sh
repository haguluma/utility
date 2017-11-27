conf_file=$1

echo $conf_file

/opt/spark-bench/bin/spark-bench.sh $conf_file

./sp_bench/getlog.sh




