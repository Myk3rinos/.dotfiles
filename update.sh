#!/usr/bin/env bash
#
#
cpKeybinding() {
  echo "Copying custom keybindings to custom.txt"
  dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > custom.txt
}

cpFirefoxUser() {
  echo "Copying Firefox user.js"
  cp ~/.mozilla/firefox/ ~/Documents/firefox/
}

echo "------------- Update Done -------------"
