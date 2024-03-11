source ~/.dotfiles/script/colors.sh
filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty conky btop nvim neofetch starship.toml)

echo -e "------------------ ${color2} ¤${colorEnd} ${color1}starting  ${colorEnd}-----------"



createSymlinks() {
    if [ -f /home/$USER/.dotfiles/$1 ] || [ -r /home/$USER/.dotfiles/$1 ]; then # check if file exists
       rm ~/"$2""$1"
       ln -s /home/$USER/.dotfiles/$1 ~/"$2""$1"
        echo "$1 config linked."
    else
        echo "WARNING: no $1 config found; can't link for now."
    fi
}

createAllSymlink() {
    echo -e "------------------ ${color2} ¤${colorEnd} ${color1} create symlinks${colorEnd}-----------"
    for file in "${filesToLinkInHome[@]}"; do
       createSymlinks $file ""
    done
    for file in "${filesToLinkInConfig[@]}"; do
       createSymlinks $file ".config/"
    done
    # echo "------------- creation off symlink done -------------" 
}



cpDocuments() {
    echo -e "------------------ ${color2} ¤${colorEnd} ${color1}cp Documents  ${colorEnd}-----------"
    cp -r /run/media/$USER/dd3/config/Documents ~/
    echo "Documents copied."
    cp -r /run/media/$USER/dd3/config/Musique ~/
    echo "Musique copied."
    cp -r /run/media/$USER/dd3/config/Vidéos ~/
    echo "Vidéos copied."
    cp -r /run/media/$USER/dd3/config/Images ~/
    echo "Images copied."
    cp -r /run/media/$USER/dd3/config/autostart ~/.config/
    echo "autostart copied."
}
cpMozilla() {
    echo -e "------------------ ${color2} ¤${colorEnd} ${color1} cp mozilla ${colorEnd}-----------"
    cp -r /run/media/$USER/dd3/config/firefox ~/.mozilla/
}
cpKeybinding() {
    echo -e "------------------ ${color2} ¤${colorEnd} ${color1} cp keybinding ${colorEnd}-----------"
    cat /run/media/$USER/dd3/config/custom.txt | dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
}


copieNixosConfig() {
    if [ -f $1 ]; then
      sudo cp /home/$USER/.dotfiles/configuration.nix /etc/nixos/configuration.nix
        echo "nixos config copied."
    else
        echo "WARNING: no $1 config found; can't copie for now."
    fi
    echo -e "------------------ ${color2} ¤${colorEnd} ${color1} nixos config copied ${colorEnd}-----------"
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
    echo -e "------------------ ${color2} ¤${colorEnd} ${color1} nixos rebuild done   ${colorEnd}-----------"
else
    echo "you have to install ${filesToLinkInConfig[@]} and ${filesToLinkInHome[@]} manually." 
fi
createAllSymlink
cpMozilla
cpKeybinding
cpDocuments
gitinit
/home/$USER/.dotfiles/script/configure.sh
askForReboot

echo -e "------------------ ${color2} ¤${colorEnd} ${color1}finished  ${colorEnd}-----------"
