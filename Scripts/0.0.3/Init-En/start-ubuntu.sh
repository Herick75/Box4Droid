#!/data/data/com.termux/files/usr/bin/bash
cd $(dirname $0)
pulseaudio --start
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $HOME/Box4Droid/ubuntu"
if [ -n "$(ls -A ubuntu-binds)" ]; then
    for f in ubuntu-binds/* ;do
      . $f
    done
fi
command+=" -b /dev"
command+=" -b /proc:/proc"
command+=" -b /sys"
command+=" -b ubuntu-fs/root:/dev/shm"
command+=" -b /data/data/com.termux/files/usr/tmp:/tmp"
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games:/data/data/com.termux/files/bin/"
command+=" TERM=$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="$@"
if [ -z "$1" ];then
    exec $command
else
    $command -c "$com"
fi

