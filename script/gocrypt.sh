#!bin/bash

# ----------------- Mounting and unmounting encrypted drives -----------------
mountSecret () {
  echo " ----------------- Mounting encrypted drives -----------------"
  if [ -z "$1" ]
  then
    echo "Argument directory missing"
  else
    if [ -e tmp/"$1" ]
      then
        fusermount -u /tmp/"$1"
        rm -d /tmp/"$1"
        mkdir /tmp/"$1"
        gocryptfs "$(pwd)/$1" /tmp/"$1"
        echo "Remove and create mnt done"
      else
        mkdir /tmp/"$1"
        gocryptfs "$(pwd)/$1" /tmp/"$1"
        echo "-- Mount done --"
        cd /tmp/"$1"
    fi
  fi
}

unmountSecret () {
  echo " ----------------- Unmounting encrypted drives -----------------"
  if [ -z "$1" ]
  then
    echo "Argument directory missing"
  else
    if [ -e /tmp/"$1" ]
      then
        fusermount -u /tmp/"$1"
        rm -d /tmp/"$1"
        echo " -- Unmount done --"
      else
        echo "No Directory to unmount"
    fi
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

