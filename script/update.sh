#!/usr/bin/env bash

echo "------------- Update Start -------------"
sudo rm -r /run/media/$USER/dd3/config
mkdir /run/media/$USER/dd3/config


cpKeybinding() {
  echo "Copying custom keybindings to custom.txt"
  dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > /run/media/$USER/dd3/config/custom.txt
}

cpFirefoxUser() {
  echo "Copying Firefox user"
  cp -r ~/.mozilla/firefox /run/media/$USER/dd3/config/
}

cpDocument() {
  echo "Copying Documents"
  cp -r ~/Documents /run/media/$USER/dd3/config/
  cp -r ~/Images /run/media/$USER/dd3/config/
  cp -r ~/Musique /run/media/$USER/dd3/config/
  cp -r ~/Vidéos /run/media/$USER/dd3/config/
  cp -r ~/.config/autostart /run/media/$USER/dd3/config/
  cp -r ~/.dotfiles /run/media/$USER/dd3/config/
}

cpKeybinding
cpFirefoxUser
cpDocument

echo "------------- Update Done -------------"
