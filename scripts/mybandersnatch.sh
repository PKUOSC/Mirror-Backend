#!/usr/bin/zsh

judge=`ps aux|grep /usr/local/bin/bandersnatch|wc -l`
log_file=/data/PKUMirror/log/pypi.`date +%Y-%m-%d-%H-%M-%S`.log
echo ${log_file}

if [[ judge -gt 1 ]]; then
    echo "Running" > ${log_file}
    exit 0
fi

/usr/local/bin/bandersnatch mirror > ${log_file} 2>&1

all_urls=`cat ${log_file} | grep -o -E "https://(.*?)" | tail -n +2 | sort -u ` #| xargs -I {} wget {}
for i in `cat ${log_file} | grep -o -E "https://(.*?)" | tail -n +2 | sort -u `
do
    echo ${i} >> ${log_file}
    echo 
    a=${i#*packages}
    b=${a:1:10000}
    if [ ! -f "/data/repos/pypi/web/packages/$b" ]; then
	echo  /data/repos/pypi/web/packages/$b not Exists
	wget $i -O /data/repos/pypi/web/packages/$b
    else
	echo  /data/repos/pypi/web/packages/$b Exists
    fi
    echo ${i}
done

log_file=/data/PKUMirror/log/pypi.`date +%Y-%m-%d-%H-%M-%S`.log
echo ${log_file}
/usr/local/bin/bandersnatch mirror > ${log_file} 2>&1
