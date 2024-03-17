#!/usr/bin/env bash

source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/checkCopy.sh


echo -e "-------------${color2} ¤${colorEnd} ${color1}| Update Start |${colorEnd}---"

cpKeybinding() {
  echo -e "${color4}- Copying custom keybindings to custom.txt ${colorEnd}"
  dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > /run/media/$USER/dd3/config/custom.txt
}

cpFirefoxUser() {
  echo -e "${color4}- Copying Firefox user ${colorEnd}"
  cp -r ~/.mozilla /run/media/$USER/dd3/config/
  checkIfCopyOk /run/media/$USER/dd3/config/.mozilla ~/.mozilla
}

cpDocument() {
  echo -e "${color4}- Copying Documents ${colorEnd}"
  cp -r ~/Documents /run/media/$USER/dd3/config/
  checkIfCopyOk /run/media/$USER/dd3/config/Documents ~/Documents
  cp -r ~/Images /run/media/$USER/dd3/config/
  checkIfCopyOk /run/media/$USER/dd3/config/Images ~/Images
  cp -r ~/Musique /run/media/$USER/dd3/config/
  checkIfCopyOk /run/media/$USER/dd3/config/Musique ~/Musique
  cp -r ~/Vidéos /run/media/$USER/dd3/config/
  checkIfCopyOk /run/media/$USER/dd3/config/Vidéos ~/Vidéos
  cp -r ~/.config/autostart /run/media/$USER/dd3/config/
  checkIfCopyOk /run/media/$USER/dd3/config/autostart ~/.config/autostart
  cp -r ~/.dotfiles /run/media/$USER/dd3/config/
  checkIfCopyOk /run/media/$USER/dd3/config/.dotfiles ~/.dotfiles
}
sudo rm -r /run/media/$USER/dd3/config
mkdir /run/media/$USER/dd3/config
cpKeybinding
cpFirefoxUser
cpDocument

echo -e "-------------${color2} ¤${colorEnd} ${color1}| Update Done |${colorEnd}---"



