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
  # cp -r ~/.mozilla/firefox/ ~/Documents/firefox/
  cp -r ~/.mozilla/firefox/ /run/media/$(user)/dd3/
  cp ~/Documents/bookmarks.html /run/media/$(user)/dd3/bookmarks.html
}

cpDocument() {
  echo "Copying Documents"
  cp -r ~/Images/ /run/media/$(user)/dd3/
  cp -r ~/Musique/ /run/media/$(user)/dd3/
  cp -r ~/Vidéos/ /run/media/$(user)/dd3/
  cp -r ~/.config/autostart/ /run/media/$(user)/dd3/
  cp -r ~/.config/gtk-4.0/ /run/media/$(user)/dd3/
  cp -r ~/.config/gh/ /run/media/$(user)/dd3/
  cp -r ~/.config/github-copilot/ /run/media/$(user)/dd3/
}

cpKeybinding
# cpFirefoxUser
cpDocument

echo "------------- Update Done -------------"
