#!/usr/bin/env bash

source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/checkCopy.sh
source ~/.dotfiles/script/choiseFunction.sh

echo -e "-------------${color2} ¤${colorEnd} ${color1}| Update Start |${colorEnd}---"

configName="config_${HOSTNAME}_${USER}_$(date +%Y-%m-%d_%H%M%S)"
DISTRO=$(hostnamectl | grep "Operating System" | cut -c19-)

pushd /run/media/$USER/ > /dev/null
if [[ $(ls -A) ]]; then
    list_all_drive+=($(ls -d *))
    choose_from_menu "Select destination drive to save configuration:" selected_drive "${list_all_drive[@]}"
else
    echo "no drive found" ; exit 
fi
popd > /dev/null


cpKeybinding() {
  echo -e "${color4}- Copying custom keybindings to custom.txt ${colorEnd}"
  dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > /run/media/$USER/${selected_drive}/${DISTRO}/custom.txt
}

cpFirefoxUser() {
  echo -e "${color4}- Copying Firefox user ${colorEnd}"
  cp -r ~/.mozilla /run/media/$USER/${selected_drive}/${DISTRO}/
  checkIfCopyOk /run/media/$USER/${selected_drive}/${DISTRO}/.mozilla ~/.mozilla
}

cpDocument() {
  echo -e "${color4}- Copying Documents ${colorEnd}"
  cp -r ~/Documents /run/media/$USER/${selected_drive}/${DISTRO}/
  checkIfCopyOk /run/media/$USER/${selected_drive}/${DISTRO}/Documents ~/Documents
  cp -r ~/Images /run/media/$USER/${selected_drive}/${DISTRO}/
  checkIfCopyOk /run/media/$USER/${selected_drive}/${DISTRO}/Images ~/Images
  cp -r ~/Musique /run/media/$USER/${selected_drive}/${DISTRO}/
  checkIfCopyOk /run/media/$USER/${selected_drive}/${DISTRO}/Musique ~/Musique
  cp -r ~/Vidéos /run/media/$USER/${selected_drive}/${DISTRO}/
  checkIfCopyOk /run/media/$USER/${selected_drive}/${DISTRO}/Vidéos ~/Vidéos
  cp -r ~/.config/autostart /run/media/$USER/${selected_drive}/${DISTRO}/
  checkIfCopyOk /run/media/$USER/${selected_drive}/${DISTRO}/autostart ~/.config/autostart
  cp -r ~/.dotfiles /run/media/$USER/${selected_drive}/
  checkIfCopyOk /run/media/$USER/${selected_drive}/.dotfiles ~/.dotfiles
}

mkdir /run/media/$USER/${selected_drive}/${DISTRO}
cpKeybinding
# cpFirefoxUser
cpDocument

echo -e "-------------${color2} ¤${colorEnd} ${color1}| Update Done |${colorEnd}---"



