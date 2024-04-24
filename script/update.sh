#!/usr/bin/env bash

source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/checkCopy.sh


echo -e "-------------${color2} ¤${colorEnd} ${color1}| Update Start |${colorEnd}---"
  lsblk
  printf "%s" "Enter the drive to mount: "
  read drive

cpKeybinding() {
  echo -e "${color4}- Copying custom keybindings to custom.txt ${colorEnd}"
  dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > /run/media/$USER/${drive}/config/custom.txt
}

cpFirefoxUser() {
  echo -e "${color4}- Copying Firefox user ${colorEnd}"
  cp -r ~/.mozilla /run/media/$USER/${drive}/config/
  checkIfCopyOk /run/media/$USER/${drive}/config/.mozilla ~/.mozilla
}

cpDocument() {
  echo -e "${color4}- Copying Documents ${colorEnd}"
  cp -r ~/Documents /run/media/$USER/${drive}/config/
  checkIfCopyOk /run/media/$USER/${drive}/config/Documents ~/Documents
  cp -r ~/Images /run/media/$USER/${drive}/config/
  checkIfCopyOk /run/media/$USER/${drive}/config/Images ~/Images
  cp -r ~/Musique /run/media/$USER/${drive}/config/
  checkIfCopyOk /run/media/$USER/${drive}/config/Musique ~/Musique
  cp -r ~/Vidéos /run/media/$USER/${drive}/config/
  checkIfCopyOk /run/media/$USER/${drive}/config/Vidéos ~/Vidéos
  cp -r ~/.config/autostart /run/media/$USER/${drive}/config/
  checkIfCopyOk /run/media/$USER/${drive}/config/autostart ~/.config/autostart
  cp -r ~/.dotfiles /run/media/$USER/${drive}/config/
  checkIfCopyOk /run/media/$USER/${drive}/config/.dotfiles ~/.dotfiles
}
sudo rm -r /run/media/$USER/${drive}/config
mkdir /run/media/$USER/${drive}/config
cpKeybinding
cpFirefoxUser
cpDocument

echo -e "-------------${color2} ¤${colorEnd} ${color1}| Update Done |${colorEnd}---"



