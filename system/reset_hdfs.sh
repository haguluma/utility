sudo service hadoop-hdfs-datanode stop

sudo -u hdfs hdfs namenode -format
sudo rm -rf /hadoop/hdfs/data
