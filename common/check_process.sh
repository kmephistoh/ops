#!/bin/sh

LOGFILE=/var/log/$(basename $0 .sh).log
PATTERN="xxxx"
RECOVERY="xxxx start"

while true
do
    TIMEPOINT=$(date -d "today" +"%Y-%m-%d_%H:%M:%S")
    PROC=$(pgrep -o -f ${PATTERN})
    #echo ${PROC}
    if [ -z "${PROC}" ]; then
            ${RECOVERY} >> $LOGFILE
            echo "[${TIMEPOINT}] ${PATTERN} ${RECOVERY}" >> $LOGFILE

    #else
            #echo "[${TIMEPOINT}] ${PATTERN} ${PROC}" >> $LOGFILE
    fi
sleep 60
done &
