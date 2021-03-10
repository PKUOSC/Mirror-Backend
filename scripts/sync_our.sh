#!/bin/bash

# rsync  -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g --exclude pypi /data/ cn102:/data/
# find /data/repos/pypi -maxdepth 3 -mindepth 3 | xargs -I {} rsync  -avHh --delete --delete-after --stats --no-o --no-g  {}/ {}/ 
rsync -avHh --delete --delete-after --stats --no-o --no-g --exclude={packages,pypi,simple}  rsync://162.105.120.100:/data/pypi/ /data/repos/pypi/
rsync -avHh --delete --delete-after --stats --no-o --no-g rsync://162.105.120.100:/data/pypi/web/simple/ /data/repos/pypi/web/simple/
rsync -avHh --delete --delete-after --stats --no-o --no-g rsync://162.105.120.100:/data/pypi/web/pypi/ /data/repos/pypi/web/pypi/
ssh cn100 "find /data/repos/pypi/web/packages -maxdepth 1 -mindepth 1" | cut -c 31-40 | xargs -I {} rsync  -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g  rsync://162.105.120.100:/data/pypi/web/packages/{}/  /data/repos/pypi/web/packages/{}/
