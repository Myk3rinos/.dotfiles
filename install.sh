#!/bin/bash

source ~/.dotfiles/script/colors.sh
source ~/.dotfiles/script/checkCopy.sh
source ~/.dotfiles/script/chooseFunction.sh
source ~/.dotfiles/installDeb.sh

echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Install start |${colorEnd}---"

filesToLinkInHome=(.zshrc .themes)
filesToLinkInConfig=( yazi kitty lazygit conky btop nvim neofetch starship.toml)

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
    pushd "$1"/$USER/
    if [[ $(ls -A) ]]; then
        list_all_drive+=($(ls -d *))
        choose_from_menu "Select drive:" selected_drive "${list_all_drive[@]}"
    else
        echo "no external drive found" ; return
    fi
    popd
    
    pushd "$1"/$USER/${selected_drive}/
    if [[ $(ls -A) ]]; then
        list_all_directory+=($(ls -d *))
        choose_from_menu "Select configguration directory:" selected_directory "${list_all_directory[@]}"
    else
        echo "no directory found" ; return 
    fi
    popd

    cpDocuments() {
        if [ ! -d "$1"/$USER/${selected_drive}/${selected_directory} ]; then
            echo -e "${colorB}WARNING: no configuration found; can't copy for now.${colorEnd}"
            return
        fi
        echo -e "${color4}- copy Documents ${colorEnd}"
        cp -r "$1"/$USER/${selected_drive}/${selected_directory}/Documents ~/
        checkIfCopyOk ~/Documents "$1"/$USER/${selected_drive}/${selected_directory}/Documents
        cp -r "$1"/$USER/${selected_drive}/${selected_directory}/Musique ~/
        checkIfCopyOk ~/Musique "$1"/$USER/${selected_drive}/${selected_directory}/Musique
        cp -r "$1"/$USER/${selected_drive}/${selected_directory}/Vidéos ~/
        checkIfCopyOk ~/Vidéos "$1"/$USER/${selected_drive}/${selected_directory}/Vidéos
        cp -r "$1"/$USER/${selected_drive}/${selected_directory}/Images ~/
        checkIfCopyOk ~/Images "$1"/$USER/${selected_drive}/${selected_directory}/Images
        cp -r "$1"/$USER/${selected_drive}/${selected_directory}/autostart ~/.config/
        checkIfCopyOk ~/.config/autostart "$1"/$USER/${selected_drive}/${selected_directory}/autostart
    }
    cpMozilla() {
        echo -e "${color4}- copy firefox user ${colorEnd}"
        cp -r "$1"/$USER/${selected_drive}/${selected_directory}/.mozilla ~/
        checkIfCopyOk ~/.mozilla "$1"/$USER/${selected_drive}/${selected_directory}/.mozilla
    }
    cpKeybinding() {
        echo -e "${color4}- copy keybindings ${colorEnd}"
        cat "$1"/$USER/${selected_drive}/${selected_directory}/custom.txt | dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
    }
    cpGnomeExtensions() {
        echo -e "${color4}- copy gnome extensions ${colorEnd}"
        mkdir -p ~/.local/share/gnome-shell/extensions/
        cp -r "$1"/$USER/${selected_drive}/${selected_directory}/gnomeExtensions/* ~/.local/share/gnome-shell/extensions/
        pushd ~/.local/share/gnome-shell/extensions/
        unzip \*.zip
        rm *.zip
        # pkill -TERM gnome-shell
        gnome-extensions enable caffeine@patapon.info 
        gnome-extensions enable clipboard-indicator@tudmotu.com 
        gnome-extensions enable color-picker@tuberry 
        gnome-extensions enable extension-list@tu.berry 
        gnome-extensions enable mediacontrols@cliffniff.github.com 
        gnome-extensions enable top-bar-organizer@julian.gse.jsts.xyz 
        gnome-extensions enable x11gestures@joseexposito.github.io
        popd
        # checkIfCopyOk ~/.mozilla "$1"/$USER/${selected_drive}/${selected_directory}/.mozilla

    }
    # cpMozilla $1
    cpDocuments $1
    cpKeybinding $1
    cpGnomeExtensions $1
}

copieNixosConfig() {
    echo -e "${color4}- copy configuration.nix ${colorEnd}"
    originPath="/home/$USER/.dotfiles/configuration.nix"
    destinationPath="/etc/nixos/configuration.nix"
    if [ -f /home/$USER/.dotfiles/configuration.nix ]; then
      sudo cp $originPath $destinationPath
      # checkIfCopyOk function 
      cpFileInfo=$(du -sb $destinationPath | cut -f1 )
      originalFileInfo=$(du -sb $originPath | cut -f1)
      if [[ $cpFileInfo -eq $originalFileInfo ]];
      then
        echo -e "copy of nix configuration ok: $2 $colorG $originalFileInfo b $colorEnd copied"
        sudo nixos-rebuild switch --upgrade
      else
        echo -e "copy fail! $2: $colorB $originalFileInfo b  is not the same ! $colorEnd"
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
        selections=( "No" "Yes" )
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
        Yes ) cpFiles $1; break;;
        No ) break;;
    esac
}
askForBackup() {
    echo -e "${color4}- Sauvegarde des dossiers personnels ${colorEnd}"
    selections=( "Oui" "Non" )
    choose_from_menu "Voulez-vous sauvegarder vos dossiers (Documents, Images, etc.) sur dd3 ?" selected_choice "${selections[@]}"
    case $selected_choice in
        Oui ) backup_to_dd3; break;;
        Non ) break;;
    esac
}

askForReboot() {
    echo -e "${color4}- reboot ${colorEnd}"
    selections=( "No" "Yes" )
    choose_from_menu "Do you want to reboot? " selected_choice "${selections[@]}"
    case $selected_choice in
        Yes ) sudo reboot; break;;
        No ) break;;
    esac
}
DISTRO=$(hostnamectl | grep "Operating System" | cut -c19-)
echo "$DISTRO"
# if [ "$DISTRO" != "Ubuntu 22.04.4 LTS" || "$DISTRO" != "Ubuntu 23.10.1" ]
if [ "$DISTRO" = "Nixos" ]
then
    echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Nixos rebuild |${colorEnd}---"
    copieNixosConfig
    askForCopy "/run/media"

    echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Nixos rebuild done |${colorEnd}---"
else
    installDeb
    askForCopy "/media"
    echo -e "you have to install ${filesToLinkInConfig[@]} and ${filesToLinkInHome[@]} manually." 
fi

createAllSymlink
echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Copy documents |${colorEnd}---"
/home/$USER/.dotfiles/script/configure.sh
gitinit
askForBackup
askForReboot

echo -e "------------------ ${color2} ¤${colorEnd} ${color1}| Installation done |${colorEnd}---"
