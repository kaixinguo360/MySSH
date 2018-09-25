#!/bin/bash

[ $(id -u) != "0" ] && { echo "Error: You must be root to run this script"; exit 1; }

cd $(dirname $0)

DATE=$(date '+%Y-%m-%d')
LOG_PATH='../log/sshd-pw.log'
ARCH_PATH="../archive"
TMP_PATH="$LOG_PATH.tmp"

if [ ! -f "$LOG_PATH" ];then
    exit
fi

mkdir -p $ARCH_PATH
mv $LOG_PATH $TMP_PATH

awk -f to-mysql.awk -v table=passwords $TMP_PATH | mysql --defaults-extra-file=mysql.conf myssh

cat $TMP_PATH >> $ARCH_PATH/$DATE.log

./update-ips.sh
