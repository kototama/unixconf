#!/bin/sh

if [ `id -u` -ne "0" ]; then
    echo "Not root. Exiting";
    exit 0;
fi

if [ ! -f /mnt/net/backups/backups.ext4fs ]; then
    echo "Backup disk-image file missing. Exiting.";
    exit 0;
fi

MAX=20B

ETC_DST=/mnt/backups/leibnitz/rdiff/etc
HOME_DST=/mnt/backups/leibnitz/rdiff/pal

mount /mnt/net/backups/backups.ext4fs -t ext4 -o,sync,loop,rw,noatime /mnt/backups
mkdir -p $ETC_DST  &> /dev/null
mkdir -p $HOME_DST &> /dev/null

rdiff-backup --exclude-globbing-filelist /home/pal/.excluded  /home/pal $HOME_DST
rdiff-backup --exclude-globbing-filelist /home/pal/.excluded  /etc $ETC_DST

rdiff-backup --remove-older-than $MAX $HOME_DST
rdiff-backup --remove-older-than $MAX $ETC_DST

