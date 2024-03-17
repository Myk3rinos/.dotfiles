#!/usr/bin/env bash

source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/checkCopy.sh


echo -e "-------------${color2} ¤${colorEnd} ${color1}| Update Start |${colorEnd}---"

nameConfigDir="config_${HOSTNAME}_${USER}_$(date +%Y-%m-%d)"
lsblk
printf "%s" "Enter the drive mountpoints destination to save: "
read drive

cpKeybinding() {
  echo -e "${color4}- Copying custom keybindings to custom.txt ${colorEnd}"
  dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > /run/media/$USER/${drive}/${nameConfigDir}/custom.txt
}

cpFirefoxUser() {
  echo -e "${color4}- Copying Firefox user ${colorEnd}"
  cp -r ~/.mozilla /run/media/$USER/${drive}/${nameConfigDir}/
  checkIfCopyOk /run/media/$USER/${drive}/${nameConfigDir}/.mozilla ~/.mozilla
}

cpDocument() {
  echo -e "${color4}- Copying Documents ${colorEnd}"
  cp -r ~/Documents /run/media/$USER/${drive}/${nameConfigDir}/
  checkIfCopyOk /run/media/$USER/${drive}/${nameConfigDir}/Documents ~/Documents
  cp -r ~/Images /run/media/$USER/${drive}/${nameConfigDir}/
  checkIfCopyOk /run/media/$USER/${drive}/${nameConfigDir}/Images ~/Images
  cp -r ~/Musique /run/media/$USER/${drive}/${nameConfigDir}/
  checkIfCopyOk /run/media/$USER/${drive}/${nameConfigDir}/Musique ~/Musique
  cp -r ~/Vidéos /run/media/$USER/${drive}/${nameConfigDir}/
  checkIfCopyOk /run/media/$USER/${drive}/${nameConfigDir}/Vidéos ~/Vidéos
  cp -r ~/.config/autostart /run/media/$USER/${drive}/${nameConfigDir}/
  checkIfCopyOk /run/media/$USER/${drive}/${nameConfigDir}/autostart ~/.config/autostart
  cp -r ~/.dotfiles /run/media/$USER/${drive}/${nameConfigDir}/
  checkIfCopyOk /run/media/$USER/${drive}/${nameConfigDir}/.dotfiles ~/.dotfiles
}

# sudo rm -r /run/media/$USER/${drive}/${nameConfigDir}
mkdir /run/media/$USER/${drive}/${nameConfigDir}
cpKeybinding
cpFirefoxUser
cpDocument

echo -e "-------------${color2} ¤${colorEnd} ${color1}| Update Done |${colorEnd}---"



