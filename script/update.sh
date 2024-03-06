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

cpKeybinding
cpFirefoxUser

echo "------------- Update Done -------------"
