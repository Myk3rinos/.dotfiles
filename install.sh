
filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty conky btop nvim neofetch starship.toml)

echo "------------------ starting ------------------"

copieNixosConfig() {
    if [ -f $1 ]; then
      # rm /etc/nixos/configuration.nix
      sudo cp configuration.nix /etc/nixos/configuration.nix
        echo "nixos config copied."
    else
        echo "WARNING: no $1 config found; can't copie for now."
    fi
    echo "------------------ nixos config copied ------------------"
}


if [ "$HOSTNAME"  = "nixos" ]
then
   copieNixosConfig
   sudo nixos-rebuild switch --upgrade
   echo "------------------ nixos rebuild done ------------------"
else
    echo "you have to install ${filesToLinkInConfig[@]} and ${filesToLinkInHome[@]} manually." 
fi

createSymlinks() {
    if [ -f $1 ] || [ -r $1 ]; then # check if file exists
       rm ~/"$2""$1"
       ln -s $(pwd)/$1 ~/"$2""$1"
        echo "$1 config linked."
    else
        echo "WARNING: no $1 config found; can't link for now."
    fi
}

createAllSymlink() {
    echo "------------------ create symlinks ------------------" 
    for file in "${filesToLinkInHome[@]}"; do
       createSymlinks $file ""
    done
    for file in "${filesToLinkInConfig[@]}"; do
       createSymlinks $file ".config/"
    done
    echo "------------- creation off symlink done -------------" 
}



cpDocuments() {
    echo "------------------ cp mozilla ------------------"
    cp -r /run/media/$USER/dd3/config/Documents ~/
    cp -r /run/media/$USER/dd3/config/Musique ~/
    cp -r /run/media/$USER/dd3/config/Vidéos ~/
    cp -r /run/media/$USER/dd3/config/Images ~/
    cp -r /run/media/$USER/dd3/config/gh ~/.config/
    cp -r /run/media/$USER/dd3/config/gitcopilot ~/.config/
    cp -r /run/media/$USER/dd3/config/gtk4.0 ~/.config/
    cp -r /run/media/$USER/dd3/config/autostart ~/.config/
}
cpMozilla() {
    echo "------------------ cp mozilla ------------------"
    cp -r /run/media/$USER/dd3/config/firefox ~/.mozilla/firefox/
}
cpKeybinding() {
    echo "------------------ cp keybinding ------------------"
    cat /run/media/$USER/dd3/config/custom.txt | dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
}
gitinit() { 
    echo "Do you want to connect to your github? (y/n)"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) gh auth login; break;;
            No ) break;; #exit;;
        esac
    done
}


askForReboot() {
    echo "Do you want to reboot? (y/n)"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) sudo reboot; break;;
            No ) break;;
        esac
    done
}


createAllSymlink
cpMozilla
cpDocuments
cpKeybinding
gitinit
askForReboot

echo "------------------ finished ------------------"
