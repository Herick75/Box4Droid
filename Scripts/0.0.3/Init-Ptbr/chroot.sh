#!/bin/sh

unset LD_PRELOAD
export PATH=/sbin:/usr/bin:/usr/sbin:/system/bin:/system/xbin:$PATH
export USER=root
export HOME=/root
export LANGUAGE=C
export LANG=C
folder=/data/data/com.termux/files/home/Box4Droid/ubuntu-fs

if [ -e $folder/sdcard ]; then
echo ""
else
mkdir $folder/sdcard
fi

echo -e "\033[0;93m Montando particões ..."
echo " Montando /dev ... "
sudo mount --bind /dev $folder/dev
echo " Montando /sys ... "
sudo mount --bind /sys $folder/sys
echo " Montando /proc ..."
sudo mount --bind /proc $folder/proc
echo " Montando /dev/pts ... "
sudo mount --bind /dev/pts $folder/dev/pts
echo " Montando /tmp ..."
sudo mount --bind /data/data/com.termux/files/usr/tmp $folder/tmp
echo " Montando /sdcard ... "
sudo mount --bind /storage/emulated/0/ $folder/sdcard
echo -e "\033[0;92m Montagem concluída ! \033[0m"

touch /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/box4droid/opt

echo -e "\033[0;92m Chrooting ... \033[0m"
sudo chroot $folder /bin/su - root
echo -e "\033[0;93m Desmontando particões ..."
echo ""
echo -e " Desmontando dev/pts ... "
sudo umount $folder/dev/pts
echo -e " Desmontando /dev ... "
sudo umount $folder/dev
echo -e " Desmontando /proc ... "
sudo umount $folder/proc
echo -e " Desmontando /tmp ..."
sudo umount $folder/tmp
echo -e " Desmontando sdcard ... "
sudo umount $folder/sdcard
echo -e " Desmontando /sys ... "
sudo umount $folder/sys
echo -e " \033[0;92m Desmontagem concluída !! \033[0m"

