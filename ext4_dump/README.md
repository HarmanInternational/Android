A script to dump ext4 filesystem image without root permissions or the need of mount

--------
####Usage:
    # simg2img system.img system.ext4.img
    # DEBUGFS_PAGER=$PWD/dump_system_img.sh debugfs -R "ls -l /" system.ext4.img 2>/dev/null

