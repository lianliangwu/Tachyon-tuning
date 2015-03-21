#!/bin/bash
set -u

bin=`dirname "$0"`
bin=`cd "$bin"; pwd`

echo "========== running sort bench =========="
# configure
DIR=`cd $bin/../; pwd`
. "${DIR}/conf/configure.sh"

# clear slaves cache
echo "====sr447 clean cache=="
ssh sr447 sudo /home/Lianliang/setdropcache.sh
echo "====sr448 clean cache=="
ssh sr448 sudo /home/Lianliang/setdropcache.sh
echo "====sr449 clean cache=="
ssh sr449 sudo /home/Lianliang/setdropcache.sh
echo "====sr450 clean cache=="
ssh sr450 sudo /home/Lianliang/setdropcache.sh

# start hadoop
# bash $HADOOP_BIN_DIR/stop-all.sh
# bash $HADOOP_BIN_DIR/start-all.sh
# sleep 60s

# start tachyon
bash $TACHYON_BIN_DIR/tachyon format
bash $TACHYON_BIN_DIR/tachyon-stop.sh 
bash $TACHYON_BIN_DIR/tachyon-start.sh master
bash $TACHYON_BIN_DIR/tachyon-start.sh workers SudoMount

# sleep 10s
#bash $TACHYON_BIN_DIR/tachyon tfs rm /youku/case1/input/data-source 
#bash $TACHYON_BIN_DIR/tachyon tfs copyFromLocal ~/data-source/  /youku/case1/input/data-source
sleep 6s

# start spark
bash $SPARK_BIN_DIR/stop-all.sh 
bash $SPARK_BIN_DIR/start-all.sh
sleep 6s

echo "========= prepare end, start run ==========="
cd /home/Lianliang/spark/powermeter
bash ./start-web.sh
# stop hadoop
# bash $HADOOP_BIN_DIR/stop-all.sh
# stop tachyon
# bash $TACHYON_BIN_DIR/tachyon-stop.sh

# start cdh
#bash $CDH_BIN_DIR/stop-all.sh
#bash $CDH_BIN_DIR/start-all.sh

echo "========== running  workload  end =========="

#echo "========== start cdh3u3           =========="

# turn off safe mode
#$HADOOP_BIN_DIR/hadoop dfsadmin -safemode leave
#bash $CDH_BIN_DIR/hadoop dfsadmin -safemode get
#cd $CDH_BIN_DIR
# start hitune- collector data
#bash $CHUKWA_BIN_DIR/start-collectors.sh
#bash $CHUKWA_BIN_DIR/start-agents.sh
#bash $CHUKWA_BIN_DIR/start-data-processors.sh

# wait for 3 minute
#sleep 1m
#echo "========== end start end cdh3u3, next step is start hitune to collect data  =========="

#bash $CHUKWA_BIN_DIR/stop-collectors.sh 
#bash $CHUKWA_BIN_DIR/stop-agents.sh
#bash $CHUKWA_BIN_DIR/stop-data-processors.sh
#bash $CDH_BIN_DIR/stop-all.sh

#echo "========= hitune and hadoop closed ====================================================="
 
