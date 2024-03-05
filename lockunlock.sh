#!/bin/bash



echo " ---------- mount and crypt ----------"

crypt() {
  # mkdir user-secret-stuff
  # gocryptfs -init user-secret-stuff
}

uncrypt() {
  mkdir /tmp/files
  gocryptfs user-secret-stuff /tmp/files
}

unmount() {
  fusermount -u /tmp/files
  rm -d /tmp/files
}

