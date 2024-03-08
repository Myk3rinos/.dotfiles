#!bin/bash

# ----------------- Mounting and unmounting encrypted drives -----------------
mountSecret () {
  echo " ----------------- Mounting encrypted drives -----------------"
  runMountSecret () {
    # str="$(basename $1)"
    str=$1
    echo "Mounting directory: $str"
    if [ -e tmp/mnt/"$str" ]
      then
        fusermount -u /tmp/mnt/"$str"
        rm -d /tmp/mnt/"$str"
        mkdir -p /tmp/mnt/"$str"
    #     # gocryptfs "$(pwd)/$str" /tmp/mnt/"$str"
        gocryptfs /run/media/$USER/"$str" /tmp/mnt/"$str"
        echo "Remove and create mnt done"
        cd /tmp/mnt/"$str"
      else
        mkdir -p /tmp/mnt/"$str"
        gocryptfs /run/media/$USER/"$str" /tmp/mnt/"$str"
    #     # gocryptfs "$(pwd)/$str" /tmp/mnt/"$str"
    #     gocryptfs "$1" /tmp/mnt/"$str"
        echo "-- Mount done --"
        cd /tmp/mnt/"$str"
    fi
  }

    echo "Argument directory missing"
    ls -al /run/media/$USER/
    printf "%s" "Enter drive name: "
    read drivename
    if [ -e  /run/media/$USER/"$drivename" ]
    then
      echo "Drive exists"
      ls -al /run/media/$USER/"$drivename"
      printf "%s" "Enter directory name: "
      read subdirname
      if [ -e /run/media/$USER/"$drivename"/"$subdirname" ]
      then
        runMountSecret "${drivename}/${subdirname}"
      else
        echo "Directory does not exist"
      fi
    else
      echo "Drive does not exist"
    fi
}

unmountSecret () {
  echo " ----------------- Unmounting encrypted drives -----------------"
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
        echo " -- Unmount done --"
      else
        echo "No Directory to unmount"
    fi
}

createSecret () {
  echo " ----------------- Create encrypted directory -----------------"
  printf "%s" "Enter directory name: "
  read dirname
  echo "Creating directory: $dirname"
  mkdir "${dirname}"
  gocryptfs -init $dirname
}

