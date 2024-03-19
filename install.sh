source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/checkCopy.sh
source ~/.dotfiles/script/choiseFunction.sh
filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty lazygit conky btop nvim neofetch starship.toml)

echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Install start |${colorEnd}---"


createSymlinks() {
    if [ -f /home/$USER/.dotfiles/$1 ] || [ -r /home/$USER/.dotfiles/$1 ]; then # check if file exists
       rm -r ~/"$2""$1"
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


cpFiles() {
    pushd /run/media/$USER/
    list_all_drive+=($(ls -d *))
    choose_from_menu "Select drive mountpoints destination to save configuration files:" selected_drive "${list_all_drive[@]}"
    popd
    
    pushd /run/media/$USER/${selected_drive}/
    list_all_directory+=($(ls -d *))
    choose_from_menu "Select drive mountpoints destination to save configuration files:" selected_directory "${list_all_directory[@]}"
    popd

    cpDocuments() {
        if [ ! -d /run/media/$USER/${selected_drive}/${selected_directory} ]; then
            echo -e "${colorB}WARNING: no configuration found; can't copy for now.${colorEnd}"
            return
        fi
        echo -e "${color4}- copy Documents ${colorEnd}"
        cp -r /run/media/$USER/${selected_drive}/${selected_directory}/Documents ~/
        checkIfCopyOk ~/Documents /run/media/$USER/${selected_drive}/${selected_directory}/Documents
        cp -r /run/media/$USER/${selected_drive}/${selected_directory}/Musique ~/
        checkIfCopyOk ~/Musique /run/media/$USER/${selected_drive}/${selected_directory}/Musique
        cp -r /run/media/$USER/${selected_drive}/${selected_directory}/Vidéos ~/
        checkIfCopyOk ~/Vidéos /run/media/$USER/${selected_drive}/${selected_directory}/Vidéos
        cp -r /run/media/$USER/${selected_drive}/${selected_directory}/Images ~/
        checkIfCopyOk ~/Images /run/media/$USER/${selected_drive}/${selected_directory}/Images
        cp -r /run/media/$USER/${selected_drive}/${selected_directory}/autostart ~/.config/
        checkIfCopyOk ~/.config/autostart /run/media/$USER/${selected_drive}/${selected_directory}/autostart
    }
    cpMozilla() {
        echo -e "${color4}- copy firefox user ${colorEnd}"
        cp -r /run/media/$USER/${selected_drive}/${selected_directory}/.mozilla ~/
        checkIfCopyOk ~/.mozilla /run/media/$USER/${selected_drive}/${selected_directory}/.mozilla
    }
    cpKeybinding() {
        echo -e "${color4}- copy keybindings ${colorEnd}"
        cat /run/media/$USER/${selected_drive}/${selected_directory}/custom.txt | dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
    }
    cpMozilla
    cpDocuments
    cpKeybinding
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
        selections=( "Yes" "No" )
        choose_from_menu "Do you want to set your git name and email? " selected_choice "${selections[@]}"
        case $selected_choice in
            Yes ) setGitConfig; break;;
            No ) break;; #exit;;
        esac
    else
      echo -e "Your git name is ${color3}${gitNamee}${colorEnd}" 
    fi


    echo -e "${color4}- github ${colorEnd}"
    githubName=$(gh auth status)
    if [[ "$githubName" = "" ]]; then
        selections=( "Yes" "No" )
        choose_from_menu "Do you want to connect to your github? " selected_choice "${selections[@]}"
        case $selected_choice in
            Yes ) gh auth login; break;;
            No ) break;; #exit;;
        esac
    else
      gh auth status
    fi
}
askForCopy() {
    echo -e "${color4}- Import configuration ${colorEnd}"
    selections=( "Yes" "No" )
    choose_from_menu "Do you want to import configuration from external drive? " selected_choice "${selections[@]}"
    case $selected_choice in
        Yes ) cpFiles; break;;
        No ) break;;
    esac
}
askForReboot() {
    echo -e "${color4}- reboot ${colorEnd}"
    selections=( "Yes" "No" )
    choose_from_menu "Do you want to reboot? " selected_choice "${selections[@]}"
    case $selected_choice in
        Yes ) sudo reboot; break;;
        No ) break;;
    esac
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
askForCopy
/home/$USER/.dotfiles/script/configure.sh
gitinit
askForReboot

echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Installation done |${colorEnd}---"
