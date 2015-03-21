#!/bin/bash
set -u

bin=`dirname "$0"`
bin=`cd "$bin"; pwd`

# configure
DIR=`cd $bin/../; pwd`
. "${DIR}/conf/configure.sh"

echo "========= stopping tachyon =========="
bash $TACHYON_BIN_DIR/tachyon-stop.sh
echo "========= stopping spark  ==========="
bash $SPARK_BIN_DIR/stop-all.sh
echo "========= stop end =================="

