#!/usr/bin/env bash

color1="\e[38;5;147m"
color2="\e[38;5;225m"
colorG="\e[38;5;119m"
colorB="\e[38;5;124m"
colorEnd="\e[0m"

echo -e "-------------${color2}  ${colorEnd}   ${color1} Update Start ${colorEnd} ------"

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
  echo "Copying .config"
  cp -r ~/.config/autostart /run/media/$USER/dd3/config/
  echo "Copying .dotfiles"
  cp -r ~/.dotfiles /run/media/$USER/dd3/config/
  echo "------- Done -------"
}

sudo rm -r /run/media/$USER/dd3/config
mkdir /run/media/$USER/dd3/config
cpKeybinding
cpFirefoxUser
cpDocument


echo -e "-------------${color2}  ${colorEnd}   ${color1} Update Done ${colorEnd} ------"

checkIfOk() {
  cI=$(du -hs /run/media/$USER/dd3/config/Images)
  cIcut="${cI:0:2}"
  oI=$(du -hs ~/Images)
  oIcut="${oI:0:2}"

  if [ "$((cIcut))" != "$((oIcut))" ]; then
    echo -e "$colorB Images: Not the same $colorEnd"
  else
    echo -e "$colorG $cIcut $colorEnd" 
  fi
}


checkIfOk

echo -e "-------------${color2}  ${colorEnd}   ${color1} Verification Done ${colorEnd} ------"
