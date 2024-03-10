
filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty conky btop nvim neofetch starship.toml)

echo "------------------ starting ------------------"



createSymlinks() {
    if [ -f $1 ] || [ -r $1 ]; then # check if file exists
       rm ~/"$2""$1"
       ln -s ~/.dotfiles/$1 ~/"$2""$1"
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
    echo "------------------ cp Documents ------------------"
    cp -r /run/media/$USER/dd3/config/.gitconfig ~/
    echo "gitconfig copied."
    cp -r /run/media/$USER/dd3/config/Documents ~/
    echo "Documents copied."
    cp -r /run/media/$USER/dd3/config/Musique ~/
    echo "Musique copied."
    cp -r /run/media/$USER/dd3/config/Vidéos ~/
    echo "Vidéos copied."
    cp -r /run/media/$USER/dd3/config/Images ~/
    echo "Images copied."
    cp -r /run/media/$USER/dd3/config/gh ~/.config/
    echo "gh copied."
    cp -r /run/media/$USER/dd3/config/github-copilot ~/.config/
    echo "github-copilot copied."
    cp -r /run/media/$USER/dd3/config/gtk-4.0 ~/.config/
    echo "gtk-4.0 copied."
    cp -r /run/media/$USER/dd3/config/autostart ~/.config/
    echo "autostart copied."
}
cpMozilla() {
    echo "------------------ cp mozilla ------------------"
    cp -r /run/media/$USER/dd3/config/firefox ~/.mozilla/firefox/
}
cpKeybinding() {
    echo "------------------ cp keybinding ------------------"
    cat /run/media/$USER/dd3/config/custom.txt | dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
}


copieNixosConfig() {
    if [ -f $1 ]; then
      sudo cp ~/.dotfiles/configuration.nix /etc/nixos/configuration.nix
        echo "nixos config copied."
    else
        echo "WARNING: no $1 config found; can't copie for now."
    fi
    echo "------------------ nixos config copied ------------------"
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

if [ "$HOSTNAME"  = "nixos" ]
then
   copieNixosConfig
   sudo nixos-rebuild switch --upgrade
   echo "------------------ nixos rebuild done ------------------"
else
    echo "you have to install ${filesToLinkInConfig[@]} and ${filesToLinkInHome[@]} manually." 
fi
createAllSymlink
cpMozilla
cpKeybinding
cpDocuments
gitinit
askForReboot

echo "------------------ finished ------------------"
