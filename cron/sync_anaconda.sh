#!/bin/bash

judge=`ps aux|grep /usr/local/bin/sync_anaconda_script|wc -l`

if [[ judge -gt 1 ]]; then
    echo "Running" > ${log_file}
    exit 0
fi

source /data/PKUMirror/cron/mon.sh

mon anaconda python3 /data/PKUMirror/scripts/sync_anaconda_script.py
