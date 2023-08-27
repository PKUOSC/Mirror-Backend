#!/usr/bin/env bash

source /data/backend/cron/mon.sh

# pypi sync takes too long. moved to a separate file.
# mon pypi /usr/local/bin/bandersnatch mirror

mon ubuntu-releases rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g rsync://rsync.releases.ubuntu.com/releases/ /data/repos/ubuntu-releases

mon ubuntu-cdimages rsync -avHh --delete --delete-after --delay-updates --safe-links --exclude={daily-live,daily-preinstalled,daily}  --stats --no-o --no-g rsync://cdimage.ubuntu.com/cdimage/ /data/repos/ubuntu-cdimage

mon ubuntu rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g rsync://archive.ubuntu.com/ubuntu/ /data/repos/ubuntu

mon epel rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g rsync://download-ib01.fedoraproject.org/fedora-epel/ /data/repos/epel

mon centos rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g rsync://rsync.mirrors.ustc.edu.cn/centos/ /data/repos/centos

mon archlinux rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g rsync://mirrors.tuna.tsinghua.edu.cn/archlinux/ /data/repos/archlinux

mon archlinuxarm rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g rsync://ftp.halifax.rwth-aachen.de/archlinux-arm/ /data/repos/archlinuxarm

mon linuxmint rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g rsync://mirrors.kernel.org/linuxmint-packages/ /data/repos/linuxmint

mon linuxmint-cdimages rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g rsync://mirrors.kernel.org/linuxmint/ /data/repos/linuxmint-cd

mon opensuse rsync -avHh --delete --delete-after --delay-updates --safe-links --exclude={history,ports,source} --stats --no-o --no-g rsync://fr2.rpmfind.net/linux/opensuse/  /data/repos/opensuse

mon debian-cd rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g rsync://mirrors.kernel.org/debian-cd/ /data/repos/debian-cd

mon gentoo rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g rsync://mirror.us.leaseweb.net/gentoo/ /data/repos/gentoo/

mon debian rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g rsync://mirrors.tuna.tsinghua.edu.cn/debian/ /data/repos/debian

mon huggingface /usr/local/bin/aws --no-sign-request s3 sync s3://models.huggingface.co/bert /data/repos/huggingface

mon anaconda python3 /data/backend/scripts/sync_anaconda_script.py
