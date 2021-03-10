#!/bin/bash
# @file mon.sh
# @author Zizheng Guo
# @brief Ultra simple synchronization monitor in bash

logdir=/data/log

mkdir -p $logdir/running
mkdir -p $logdir/done
mkdir -p $logdir/error

# usage: mon <release-name> <sync-command...>
function mon {
    mkdir -p $logdir/done/$1
    rm -f $logdir/error/$1
    rm -f $logdir/running/$1
    touch $logdir/running/$1
    "${@:2}" > $logdir/done/$1/`date +%Y-%m-%d-%H-%M-%S`.log 2>&1
    if [ $? -ne 0 ]; then
        touch $logdir/error/$1
    fi
    rm -f $logdir/running/$1
}
