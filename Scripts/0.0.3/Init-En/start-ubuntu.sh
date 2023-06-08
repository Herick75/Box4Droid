#!/data/data/com.termux/files/usr/bin/bash
cd $(dirname $0)
pulseaudio --start
## For rooted user: pulseaudio --start --system
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r ubuntu-fs"
if [ -n "$(ls -A ubuntu-binds)" ]; then
    for f in ubuntu-binds/* ;do
      . $f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b /sys"
command+=" -b ubuntu-fs/root:/dev/shm"
## uncomment the following line to have access to the home directory of termux
command+=" -b /data/data/com.termux/files/usr/tmp/.virgl_test:/tmp/.virgl_test"
command+=" -b /data/data/com.termux/files/usr/tmp/.X11-unix/:/tmp/.X11-unix/"
command+=" -b /data/data/com.termux/files/usr/tmp/.X1-lock:/tmp/.X1-lock"
## uncomment the following line to mount /sdcard directly to / 
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="$@"
if [ -z "$1" ];then
    exec $command
else
    $command -c "$com"
fi
