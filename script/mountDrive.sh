




mountDrive () {
  echo " ------------------- Mounting Drive -------------------"
  # sudo fdisk -l
  lsblk
  printf "%s" "Enter the drive to mount: "
  read drive
  sudo cryptsetup luksOpen /dev/"${drive}" "${drive}"
  sudo mkdir -p /run/media/"$USER"/"${drive}"
  sudo mount /dev/mapper/"${drive}" /run/media/"$USER"/"${drive}"
}

unmountDrive () {
  echo " ------------------- Unmounting Drive -------------------"
  lsblk
  printf "%s" "Enter the drive to unmount: "
  read drive
  sudo umount /run/media/"$USER"/"${drive}"
  sudo cryptsetup luksClose "${drive}"
}
