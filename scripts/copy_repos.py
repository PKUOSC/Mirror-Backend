#!/usr/bin/env bash
S=/data/repos
D=/datahdd/repos


for i in `ls /data/repos`;
do
    if [[ "$i" != "pypi" ]];
    then
        echo $i
	rsync -avHh --delete --delete-after --stats $S/$i/ $D/$i/
    fi;
done;

rsync -avHh --delete --delete-after --stats --exclude={packages,pypi,simple} $S/pypi/ $D/pypi/
rsync -avHh --delete --delete-after --stats $S/pypi/web/packages/ $D/pypi/web/packages/
rsync -avHh --delete --delete-after --stats $S/pypi/web/pypi/ $D/pypi/web/pypi/
rsync -avHh --delete --delete-after --stats $S/pypi/web/simple/ $D/pypi/web/simple/

# ssh cn100 "find /data/repos/pypi/web/packages -maxdepth 1 -mindepth 1" | cut -c 31-40 | xargs -I {} rsync  -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g  rsync://162.105.120.100:/data/pypi/web/packages/{}/  /data/repos/pypi/web/packages/{}/

