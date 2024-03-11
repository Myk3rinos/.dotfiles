#!bin/bash
source ~/.dotfiles/script/colors.sh

mountSecret () {
  echo " -----------------${color2} ¤${colorEnd} ${color1}| Mounting encrypted drives |${colorEnd}---"
  runMountSecret () {
    str=$1
    echo "${color2}- Mounting directory: $str ${colorEnd}"
    if [ -e tmp/mnt/"$str" ]
      then
        fusermount -u /tmp/mnt/"$str"
        rm -d /tmp/mnt/"$str"
        mkdir -p /tmp/mnt/"$str"
        gocryptfs /run/media/$USER/"$str" /tmp/mnt/"$str"
        echo "${color2}- Remove and create mnt done${colorEnd}"
        cd /tmp/mnt/"$str"
      else
        mkdir -p /tmp/mnt/"$str"
        gocryptfs /run/media/$USER/"$str" /tmp/mnt/"$str"
        echo "${color2}- Mount done ${colorEnd}"
        cd /tmp/mnt/"$str"
    fi
  }

    echo "${colorB}- Argument directory missing${colorEnd}"
    ls -al /run/media/$USER/
    printf "%s" "Enter drive name: "
    read drivename
    if [ -e  /run/media/$USER/"$drivename" ]
    then
      echo "${colorG}- Drive exists${colorEnd}"
      ls -al /run/media/$USER/"$drivename"
      printf "%s" "Enter directory name: "
      read subdirname
      if [ -e /run/media/$USER/"$drivename"/"$subdirname" ]
      then
        runMountSecret "${drivename}/${subdirname}"
      else
        echo "${colorB}- Directory does not exist${colorEnd}"
      fi
    else
      echo "${colorB}- Drive does not exist${colorEnd}"
    fi
}

unmountSecret () {
  echo " -----------------${color2} ¤${colorEnd} ${color1}| Unmounting encrypted drives |${colorEnd}---"
  ls -al /tmp/mnt
  printf "%s" "Enter drive name: "
  read drivename
  ls -al /tmp/mnt/"$drivename"
  printf "%s" "Enter directory name: "
  read dirname

    if [ -e /tmp/mnt/"$drivename"/"$dirname" ]
      then
        cd ~
        fusermount -u /tmp/mnt/"$drivename"/"$dirname"
        rm -d /tmp/mnt/"$drivename"/"$dirname"
      echo "${colorG}- Unmount done${colorEnd}"
      else
        echo "${colorB}- No Directory to unmount${colorEnd}"
    fi
}

createSecret () {
  echo " -----------------${color2} ¤${colorEnd} ${color1}| Create encrypted directory |${colorEnd}---"
  printf "%s" "Enter directory name: "
  read dirname
  echo "${color2}- Creating directory: $str ${colorEnd} $dirname"
  mkdir "${dirname}"
  gocryptfs -init $dirname
}

