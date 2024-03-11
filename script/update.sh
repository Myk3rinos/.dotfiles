#!/usr/bin/env bash

source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/checkCopy.sh


echo -e "-------------${color2} ¤ ${colorEnd}   ${color1} Update Start ${colorEnd} ------"

cpKeybinding() {
  echo "Copying custom keybindings to custom.txt"
  dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > /run/media/$USER/dd3/config/custom.txt
}

cpFirefoxUser() {
  echo "Copying Firefox user"
  cp -r ~/.mozilla/firefox /run/media/$USER/dd3/config/
}

cpDocument() {
  echo "Copying Documents..."
  cp -r ~/Documents /run/media/$USER/dd3/config/
  echo "Copying Images..."
  cp -r ~/Images /run/media/$USER/dd3/config/
  echo "Copying Musique"
  cp -r ~/Musique /run/media/$USER/dd3/config/
  echo "Copying Vidéos"
  cp -r ~/Vidéos /run/media/$USER/dd3/config/
  echo "Copying autostart"
  cp -r ~/.config/autostart /run/media/$USER/dd3/config/
  echo "Copying .dotfiles"
  cp -r ~/.dotfiles /run/media/$USER/dd3/config/
}

sudo rm -r /run/media/$USER/dd3/config
mkdir /run/media/$USER/dd3/config
cpKeybinding
cpFirefoxUser
cpDocument

echo -e "-------------${color2} ¤${colorEnd}   ${color1} Update Done ${colorEnd} ------"

checkIfCopyOk /run/media/$USER/dd3/config/firefox ~/.mozilla/firefox
checkIfCopyOk /run/media/$USER/dd3/config/Documents ~/Documents
checkIfCopyOk /run/media/$USER/dd3/config/Images ~/Images
checkIfCopyOk /run/media/$USER/dd3/config/Musique ~/Musique
checkIfCopyOk /run/media/$USER/dd3/config/Vidéos ~/Vidéos
checkIfCopyOk /run/media/$USER/dd3/config/autostart ~/.config/autostart
checkIfCopyOk /run/media/$USER/dd3/config/.dotfiles ~/.dotfiles


echo -e "-------------${color2} ¤ ${colorEnd}  ${color1} Verification Done ${colorEnd} ------"
