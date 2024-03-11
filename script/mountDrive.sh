
source ~/.dotfiles/script/colors.sh



mountDrive () {
  echo -e " -------------------${color2} ¤ ${colorEnd} ${color1}Mounting Drive ${colorEnd} -----------"
  # sudo fdisk -l
  lsblk
  printf "%s" "Enter the drive to mount: "
  read drive
  sudo cryptsetup luksOpen /dev/"${drive}" "${drive}"
  sudo mkdir -p /run/media/"$USER"/"${drive}"
  sudo mount /dev/mapper/"${drive}" /run/media/"$USER"/"${drive}"
}

unmountDrive () {
  echo -e " -------------------${color2} ¤ ${colorEnd} ${color1}Unmounting Drive ${colorEnd} -----------"
  lsblk
  printf "%s" "Enter the drive to unmount: "
  read drive
  sudo umount /run/media/"$USER"/"${drive}"
  sudo cryptsetup luksClose "${drive}"
}
