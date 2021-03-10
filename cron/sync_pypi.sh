#!/bin/bash

judge=`ps aux|grep /usr/local/bin/bandersnatch|wc -l`

if [[ judge -gt 1 ]]; then
    echo "Running" > ${log_file}
    exit 0
fi

source /data/PKUMirror/cron/mon.sh

cd /data/repos/pypi
mon pypi /usr/local/bin/bandersnatch mirror
