#!/bin/sh

unset LD_PRELOAD
export PATH=/sbin:/usr/bin:/usr/sbin:/system/bin:/system/xbin:$PATH
export USER=root
export HOME=/root
export LANGUAGE=C
export LANG=C
folder=/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/box4droid

if [ -e $folder/sdcard ]; then
echo ""
else
mkdir $folder/sdcard
fi

echo -e "\033[0;93m Mounting partitions ..."
echo " Mounting /dev ... "
sudo mount --bind /dev $folder/dev
echo " Mounting /sys ... "
sudo mount --bind /sys $folder/sys
echo " Mounting /proc ..."
sudo mount --bind /proc $folder/proc
echo " Mounting /dev/pts ... "
sudo mount --bind /dev/pts $folder/dev/pts
echo " Mounting /tmp ..."
sudo mount --bind /data/data/com.termux/files/usr/tmp $folder/tmp
echo " Mounting /sdcard ... "
sudo mount --bind /storage/emulated/0/ $folder/sdcard
echo -e "\033[0;92m Mounting Done ! \033[0m"

touch /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/box4droid/opt/chroot

echo -e "\033[0;92m Chrooting ... \033[0m"
sudo chroot $folder /bin/su - root
echo -e "\033[0;93m Unmounting Partitions ..."
echo -e " Unmounting dev/pts ... "
sudo umount $folder/dev/pts
echo -e " Unmounting /dev ... "
sudo umount $folder/dev
echo -e " Unmounting /proc ... "
sudo umount $folder/proc
echo -e " Unmounting /tmp ..."
sudo umount $folder/tmp
echo -e " Unmounting sdcard ... "
sudo umount $folder/sdcard
echo -e " Unmounting /sys ... "
sudo umount $folder/sys
echo -e " \033[0;92m Unmounted \033[0m"

