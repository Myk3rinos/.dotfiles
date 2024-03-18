source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/checkCopy.sh
filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty lazygit conky btop nvim neofetch starship.toml)

echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Install start |${colorEnd}---"

lsblk | grep -E '^└─' 
printf "%s" "Enter the drive mountpoints destination for install: "
read drive
ls -la /run/media/$USER/$drive 
printf "%s" "Enter the config directory name for install: "
read directory

createSymlinks() {
    if [ -f /home/$USER/.dotfiles/$1 ] || [ -r /home/$USER/.dotfiles/$1 ]; then # check if file exists
       rm ~/"$2""$1"
       ln -s /home/$USER/.dotfiles/$1 ~/"$2""$1"
       echo -e "${colorG}$1 configuration linked.${colorEnd}"
    else
       echo -e "${colorB}WARNING: no $1 config found; can't link for now.${colorEnd}"
    fi
}

createAllSymlink() {
    echo -e "${color4}- create symlink $1 ${colorEnd}"
    for file in "${filesToLinkInHome[@]}"; do
       createSymlinks $file ""
    done
    for file in "${filesToLinkInConfig[@]}"; do
       createSymlinks $file ".config/"
    done
}



cpDocuments() {
    if [ ! -d /run/media/$USER/${drive}/${directory} ]; then
        echo -e "${colorB}WARNING: no configuration found; can't copy for now.${colorEnd}"
        return
    fi
    echo -e "${color4}- copy Documents ${colorEnd}"
    cp -r /run/media/$USER/${drive}/${directory}/Documents ~/
    checkIfCopyOk ~/Documents /run/media/$USER/${drive}/${directory}/Documents
    cp -r /run/media/$USER/${drive}/${directory}/Musique ~/
    checkIfCopyOk ~/Musique /run/media/$USER/${drive}/${directory}/Musique
    cp -r /run/media/$USER/${drive}/${directory}/Vidéos ~/
    checkIfCopyOk ~/Vidéos /run/media/$USER/${drive}/${directory}/Vidéos
    cp -r /run/media/$USER/${drive}/${directory}/Images ~/
    checkIfCopyOk ~/Images /run/media/$USER/${drive}/${directory}/Images
    cp -r /run/media/$USER/${drive}/${directory}/autostart ~/.config/
    checkIfCopyOk ~/.config/autostart /run/media/$USER/${drive}/${directory}/autostart
}
cpMozilla() {
    echo -e "${color4}- copy firefox user ${colorEnd}"
    cp -r /run/media/$USER/${drive}/${directory}/.mozilla ~/
    checkIfCopyOk ~/.mozilla /run/media/$USER/${drive}/${directory}/.mozilla
}
cpKeybinding() {
    echo -e "${color4}- copy keybindings ${colorEnd}"
    cat /run/media/$USER/${drive}/${directory}/custom.txt | dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
}


copieNixosConfig() {
    echo -e "${color4}- copy configuration.nix ${colorEnd}"
    oriPath="/home/$USER/.dotfiles/configuration.nix"
    desPath="/etc/nixos/configuration.nix"
    if [ -f /home/$USER/.dotfiles/configuration.nix ]; then
      sudo cp $oriPath $desPath
      # checkIfCopyOk /etc/nixos/configuration.nix /home/$USER/.dotfiles/configuration.nix
        # echo "nixos config copied."
      destinationInfo=$(du -sb $desPath | cut -f1 )
      originalInfo=$(du -sb $oriPath | cut -f1)
      if [[ $destinationInfo -eq $originalInfo ]];
      then
        echo -e "$2 $colorG $originalInfo b $colorEnd"
        sudo nixos-rebuild switch --upgrade
      else
        echo -e "$2: $colorB $originalInfo b  is not the same ! $colorEnd"
      fi

    else
        echo -e " ${colorB} WARNING: no $1 config found; can't copie for now.${colorEnd}"
    fi
}



gitinit() { 
    setGitConfig() {
        echo "Enter your git name"
        read gitName
        git config --global user.name "$gitName"
        echo "Enter your git email"
        read gitEmail
        git config --global user.email "$gitEmail"
        git config --list --global
    }

    echo -e "${color4}- git ${colorEnd}"
    gitNamee=$(git config --global user.name)
    if [[ "$gitNamee" = "" ]]; then
      echo "Do you want to set your git name and email? (y/n)"
      select yn in "Yes" "No"; do
        case $yn in
            Yes ) setGitConfig; break;;
            No ) break;; #exit;;
        esac
      done
    else
      echo -e "Your git name is ${color3}${gitNamee}${colorEnd}" 
    fi


    echo -e "${color4}- github ${colorEnd}"
    githubName=$(gh auth status)
    if [[ "$githubName" = "" ]]; then
      echo "Do you want to connect to your github? (y/n)"
      select yn in "Yes" "No"; do
        case $yn in
            Yes ) gh auth login; break;;
            No ) break;; #exit;;
        esac
      done
    else
      gh auth status
    fi
}

askForReboot() {
    echo -e "${color4}- reboot ${colorEnd}"
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
    echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Nixos rebuild |${colorEnd}---"
    copieNixosConfig
    echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Nixos rebuild done |${colorEnd}---"
else
    echo -e "you have to install ${filesToLinkInConfig[@]} and ${filesToLinkInHome[@]} manually." 
fi

createAllSymlink
echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Copy documents |${colorEnd}---"
cpMozilla
cpDocuments
cpKeybinding
/home/$USER/.dotfiles/script/configure.sh
gitinit
askForReboot

echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Installation done |${colorEnd}---"
