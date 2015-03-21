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

# prepare clipboard input data
bash $CLIPBOARD_HOME/prepare.sh
bash $CLIPBOARD_HOME/datagen.sh

echo "========= prepare end, start run ==========="
cd /home/Lianliang/spark/powermeter
bash ./start-web.sh

echo "========== running  workload  end =========="
