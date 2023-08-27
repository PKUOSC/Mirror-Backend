#!/usr/bin/env bash

files=`ls /data/repos`
cf='/etc/rsyncd.conf'

cat rsyncd.conf.raw > $cf

for i in $files;
do
    if [[ "$i" != "pypi" ]];
    then
        echo "[$i]" >> $cf
	echo comment = Peking University Mirror for $i >> $cf
	echo path = /data/repos/$i >> $cf
	echo "" >> $cf
    fi;
done;

kill `cat /var/run/rsyncd.pid`
rsync --daemon

