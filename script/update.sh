#!/usr/bin/env bash
#

echo "------------- Update Start -------------"

cpKeybinding() {
  echo "Copying custom keybindings to custom.txt"
  # rm -f ~/.dotfiles/custom.txt
  dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > ~/.dotfiles/custom.txt
}

cpFirefoxUser() {
  echo "Copying Firefox user"
  cp -r ~/.mozilla/firefox/ ~/Documents/firefox/
}

cpDocument() {
  echo "Copying Documents"
  cp -r ~/Images/ run/media/will/dd3/
  cp -r ~/Musique/ run/media/will/dd3/
}

cpKeybinding
cpFirefoxUser
cpDocument

echo "------------- Update Done -------------"
