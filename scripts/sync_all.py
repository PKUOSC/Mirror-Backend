def get_sync_script(up_urls, file_out, local_dir, log_dir):
    # print("bandersnatch mirror")
    f = open(file_out, "w")
    for up_url in up_urls:
        if len(up_url)==1:
            out = up_url[0]
        elif len(up_url)==2:
            url, dir_name = up_url
            out = "rsync -avHh --delete --delete-after --delay-updates --safe-links --stats --no-o --no-g {} {}/{} > {}/{}.`date +%Y-%m-%d-%H-%M-%S`.log 2>&1 ".format(url, local_dir, dir_name, log_dir, dir_name)
        elif len(up_url)==3:
            url, dir_name, exl = up_url
            out = "rsync -avHh --delete --delete-after --delay-updates --safe-links --exclude={}  --stats --no-o --no-g {} {}/{} > {}/{}.`date +%Y-%m-%d-%H-%M-%S`.log 2>&1 ".format(exl, url, local_dir, dir_name, log_dir, dir_name)
        print(out)
        # print()
        f.write(out+"\n")
    f.close()

if __name__=="__main__":
    up_urls = [
            # ["bandersnatch mirror"],
            ["rsync://rsync.releases.ubuntu.com/releases/", "ubuntu-releases"],
            ["rsync://cdimage.ubuntu.com/cdimage/", "ubuntu-cdimages", "{daily-live,daily-preinstalled,daily}"],
            ["rsync://archive.ubuntu.com/ubuntu/", "ubuntu"],
            ["rsync://download-ib01.fedoraproject.org/fedora-epel/", "epel"],
            ["rsync://rsync.mirrors.ustc.edu.cn/centos/", "centos"],
            # ["rsync://rsync.archlinux.org/ftp_tier1/", "archlinux"],
            ["rsync://mirrors.tuna.tsinghua.edu.cn/archlinux/", "archlinux"],
            ["rsync://ftp.halifax.rwth-aachen.de/archlinux-arm/", "archlinuxarm"],
            # ["rsync://repo@sync.repo.archlinuxcn.org/repo/", "archlinuxcn"],
            ["rsync://mirrors.kernel.org/linuxmint-packages/", "linuxmint"],
            ["rsync://mirrors.kernel.org/linuxmint/", "linuxmint-cdimages"],
            ]
    get_sync_script(up_urls, "sync_all.sh", "/data/repos", "/data/PKUMirror/log")
