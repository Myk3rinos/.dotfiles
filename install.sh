
filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty nvim neofetch starship.toml)

echo "------------------ starting ------------------"

createSymlinks() {
    if [ -f $1 ] || [ -r $1 ]; then # check if file exists
      rm ~/"$2""$1"
      ln -s $(pwd)/$1 ~/"$2""$1"
        echo "$1 config linked."
    else
        echo "WARNING: no $1 config found; can't link for now."
    fi
}

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

gitinit() { 
    echo "Do you want to connect to your github? (y/n)"
    select yn in "Yes" "No"; do
        case $yn in
            # No ) exit;;
            Yes ) gh auth login; break;;
            No ) break;;
        esac
    done
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

askForReboot() {
    echo "Do you want to reboot? (y/n)"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) sudo reboot; break;;
            No ) break;;
        esac
    done
}

copieNixosConfig
gitinit
createAllSymlink

echo "------------------ rebuild nixos ------------------"
sudo nixos-rebuild switch

askForReboot
echo "------------------ finished ------------------"
